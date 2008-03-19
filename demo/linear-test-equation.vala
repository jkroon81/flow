public class LinearTestEquation : FlowDemoODE {
  construct {
    var x_0 = new double[] {1.0};

    name = "Linear Test Equation";
    x.set_data(1, x_0);
    t_start = 0.0;
    t_stop = 10.0;
  }

  [NoArrayLength]
  public override void f_func(weak double[] dx, weak double[] x, weak double[] u, double t) {
    dx[0] = -x[0];
  }
}
