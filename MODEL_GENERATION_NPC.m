%%% file: MODEL GENERATION %%%

%% MODEL RESPONSE WITH GAUSSIAN %%

% find time indices of response which are not NaN (valid times)

t_ind = find(~(isnan(resp)));

% filter responses by valid times

resp_filtered = resp(t_ind); 

% fit normal distribution to filtered responses

[resp_mu, resp_s, resp_muci,resp_sci] = normfit(resp_filtered);

% calculate z-score for all

resp_z = (resp_filtered - resp_mu)/(resp_s);

% LOOKS POISSON --> fit Poisson next time
% 3/11/18