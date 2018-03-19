%%% file: MODEL GENERATION %%%

% load data
load(celldata(1).datafile);

% find time indices of response which are not NaN (valid times)
t_ind = find(~(isnan(resp)));

% filter responses by valid times
resp_filtered = resp(t_ind); 

%{
%% MODEL RESPONSE WITH GAUSSIAN %%

% fit normal distribution to filtered responses

[resp_mu, resp_s, resp_muci,resp_sci] = normfit(resp_filtered);

% calculate z-score for all

resp_z = (resp_filtered - resp_mu)/(resp_s);

% LOOKS POISSON --> fit Poisson next time
% 3/11/18
% hist(resp_z);

%}

%% MODEL WITH POISSON DISTR %%

%--- RESP ---%

% get lambda
lambda = mean(resp_filtered);

% execute vst
resp_vst = [];
for i = resp_filtered
   v = vst(i, lambda);
   resp_vst = [resp_vst, v];
   %disp(v);
end

%--- STIM ---%

% make stim_mask via weighted averages
stim_mask = zeros([16, 16]);
for t = 1:length(t_ind)
    time = t_ind(t);
    stim_frame = stim(:, :, time);
    resp_frame = resp(time);
    if resp_frame < 2
        continue
    end
    stim_frame_weighted = resp_frame*stim_frame;
    stim_mask = stim_frame_weighted + stim_mask;
end 
stim_mask = stim_mask / length(t_ind);

% poss future for stim_mask:
%   > normalize (?)
%   > remove any stim masks that have < 2 or so response
%   > fine tune later to poss improve classification
% 3/18/18 next time:
%   > make stim_distr (somehow)
%   > correlate stim to response based on vst of stim relative to
%   stim_distr and vst of resp relative to resp_distr

%{
% grading each stim frame in terms of vst (of that frame) 
for t = 1:length(t_ind)
    % get frame at time index
    stim_frame = stim(:, :, t_ind(t));
    % get lambda of all values in frame
    stim_frame_flat = reshape(stim_frame, [1, 16*16]);
    stim_frame_lambda = mean(stim_frame_flat);
    % calc vst for all values in frame
    stim_frame_vst = 2*sqrt(stim_frame_lambda) + (1/(sqrt(stim_frame_lambda)))*(stim_frame_flat-stim_frame_lambda);
    stim_frame_vst_mat = reshape(stim_frame_vst, [16, 16]);
    % TAKE WEIGHTED AVERAGE 
end
%}

% END OF POISSON