public class LinearTestEquation : FlowDemoODE {
  construct {
    var x_0 = new double[] {1.0};

    _name = "Linear Test Equation";
    x.set(x_0);
    t_start = 0.0;
    t_stop = 10.0;
  }

  public override void f_func(weak double[] dx, weak double[] x, double t) {
    dx[0] = -x[0];
  }
}
