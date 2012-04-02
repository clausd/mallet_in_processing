  import cc.mallet.optimize.*;

public class Solveforthis implements Optimizable.ByGradientValue {

    // Optimizables encapsulate all state variables, 
    //  so a single Optimizer object can be used to optimize 
    //  several functions.

    double[] parameters;

    public Solveforthis(double x, double y) {
        parameters = new double[2];
        parameters[0] = x;
        parameters[1] = y;
    }

    public double getValue() {

        double x = parameters[0];
        double y = parameters[1];

        return -3*x*x - 4*y*y + 2*x - 4*y + 18;

    }

    public void getValueGradient(double[] gradient) {

        gradient[0] = -6 * parameters[0] + 2;
        gradient[1] = -8 * parameters[1] - 4;

    }

    // The following get/set methods satisfy the Optimizable interface

    public int getNumParameters() { return 2; }
    public double getParameter(int i) { return parameters[i]; }
    public void getParameters(double[] buffer) {
        buffer[0] = parameters[0];
        buffer[1] = parameters[1];
    }

    public void setParameter(int i, double r) {
        parameters[i] = r;
    }
    public void setParameters(double[] newParameters) {
        parameters[0] = newParameters[0];
        parameters[1] = newParameters[1];
    }
}

