public class Lorentz : FlowDemoODE {
  static double a = 10.0;
  static double b = 28.0;
  static double c = 8.0/3.0;

  construct {
    var x_0 = new double[] {10.0, 10.0, 10.0};

    name = "Lorentz attractor";
    x.set_data(3, x_0);
    t_start = 0.0;
    t_stop = 50.0;
    f_func = (dx, x, u, t) => {
      dx[0] = a*(x[1] - x[0]);
      dx[1] = x[0]*(b - x[2]) - x[1];
      dx[2] = x[0]*x[1] - c*x[2];
    };
  }
}
