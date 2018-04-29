/**
 * stores matlab data on cell;
 * NOTE: Seems like every V1 cell needs its own model due to its selectivity, etc
 */

public class V1Cell {
    String id;
    int diam; //might not be necessary
    double[][][] stim; //16 x 16 x T frame
    double[] resp;
    double noiseFactor;

    public V1Cell(String name, double[][][] s, double[] r, int d) {
        id = name;
        stim = s;
        resp = r;
        diam = d;
        noiseFactor = 0; //extra noise in the background, needs to be tuned
                            //to individual cell based on data
    }

    private int xyto1D(int x, int y) {
        return (x + 1) + 16 * y;
    }


}
