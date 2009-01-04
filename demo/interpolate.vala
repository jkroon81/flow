using Flow;

class Interpolate {
  public static void main(string[] args) {
    Vector v = new Vector();
    Vector v1 = new Vector();
    Vector v2 = new Vector();
    Vector dv1 = new Vector();
    Vector dv2 = new Vector();
    double[] x1 = new double[] {0.0, 0.0, 0.0};
    double[] x2 = new double[] {1.0, 0.0, -1.0};
    double[] dx1 = new double[] {0.0, 1.0, -5.0};
    double[] dx2 = new double[] {0.0, -1.0, 0.0};
    double t;

    v1.set_data(3, x1);
    v2.set_data(3, x2);
    dv1.set_data(3, dx1);
    dv2.set_data(3, dx2);
    for(t = 0.0; t < 5.0; t += 0.05) {
      v.interpolate(v1, v2, dv1, dv2, 0.0, 5.0, t);
      stdout.printf("t=%f, x1=%f, x2=%f, x3=%f\n", t, v.data[0], v.data[1], v.data[2]);
    }
  }
}
