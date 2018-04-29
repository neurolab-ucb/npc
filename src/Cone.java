
/**
 * Photoreceptor cell class placed on 16 x 16 grid
 * Dark current = constant output stream and system only activates with large number of
 *             hyperpolarization --> system is noiseless
 * Model currently assumes all involved receptive cells are cones because stim is shown
 *             in a natural movie
 *
 */

public class Cone {
    int id;
    int x;
    int y;
    static final double DARK_CURRENT = 100.0; //strength percentage of default current
    double[] stimInput;
    double[] output;
    //Output bipolar cell connection here;

    public Cone(int x, int y, double[] stimInput) {
        this.x = x;
        this.y = y;
        this.stimInput = stimInput;
        this.id = xyto1D(x, y);
        this.output = new double[stimInput.length];
    }

    private int xyto1D(int x, int y) {
        return x + 1 + y * 16;
    }

    /**
     * REQUIRES MORE RESEARCH
     * Mathematically transform input light intensity to a proportional decrease in
     *              magnitude of default dark current
     */
    private double transduce(double stimInput) {
        return DARK_CURRENT / stimInput;
    }


}
