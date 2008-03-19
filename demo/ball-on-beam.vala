/* See http://www.control.lth.se/education/laboratory/bommen.html */

public class BallOnBeam : FlowDemoODE {
  static double w = 1.0;
  double b1 = 225.0;
  double b0 = 46900.0;
  double a2 = 103.0;
  double a1 = 10100.0;
  double a0 = 833.0;
  double c1 = 0.15;
  double c0 = -6.7;
  double k1 = -0.45*w*w;
  double td = 1.0/w;
  double ti = 3.0*1.0/w;
  double k2 = 2.0;

  construct {
    var x_0 = new double[] {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
    var u_0 = new double[] {1.0};

    name = "Ball On Beam";
    x.set_data(6, x_0);
    u.set_data(1, u_0);
    t_start = 0.0;
    t_stop = 50.0;
  }

  [NoArrayLength]
  public override void f_func(weak double[] dx, weak double[] x, weak double[] u, double t) {
    double x4_dot;
    double x5_dot;

    x4_dot = c1*x[2] + c0*x[0];
    x5_dot = k1*(-x[4] + td*(-x4_dot) + 1.0/ti*(u[0] - x[3]));
    dx[0] = x[1];
    dx[1] = x[2];
    dx[2] = b1*k2*(x5_dot - x[1]) + b0*k2*(x[5] - x[0]) - a2*x[2] - a1*x[1] - a0*x[0];
    dx[3] = x[4];
    dx[4] = x4_dot;
    dx[5] = x5_dot;
  }
}
