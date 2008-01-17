public class Step : FlowDemoODE {
  construct {
    var x_0 = new double[] {0.0, 0.0};

    _name = "Step";
    x.set(x_0);
    t_start = 0.0;
    t_stop = 20.0;
  }

  public override void f_func(weak double[] dx, weak double[] x, double t) {
    dx[0] = x[1];
    dx[1] = - x[0] - x[1] + 1.0;
  }
}