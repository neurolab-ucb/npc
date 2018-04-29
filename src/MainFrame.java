


import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;


public class MainFrame {
    double[][][] data;
    private static final String TEST_DATA_PATH = "../NPC - Pathway/data/r0206B_stim.mat";

    Cone[][] receptorLayer;

    public MainFrame(String filePath) {
        File file = null;

        //read data
        data = null;

        int T = 100; //T buckets
        receptorLayer = new Cone[16][16];
        for (int i = 0; i < 16; i += 1) {
            for (int j = 0; j < 16; j += 1) {
                receptorLayer[i][j] = new Cone(i, j, data[i][j]);
            }
        }

    }




}
