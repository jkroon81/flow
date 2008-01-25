using GLib;
using Flow;

class TestSpline {
  public static void main(string[] args) {
    Spline s;
    double[] dx1 = new double[] {0.0, 1.0, -1.0};
    double[] x1 = new double[] {0.0, 0.0, 0.0};
    double[] dx2 = new double[] {0.0, -1.0, 0.0};
    double[] x2 = new double[] {1.0, 0.0, -1.0};
    double[] x = new double[3];
    double t;

    s = new Spline();
    s.set_data(dx1, dx2, x1, x2, 0.0, 5.0);
    s.set_size(3);
    for(t = 0.0; t < 5.0; t += 0.05) {
      s.eval(x, t);
      stdout.printf("t=%f, x1=%f, x2=%f, x3=%f\n", t, x[0], x[1], x[2]);
    }
  }
}
