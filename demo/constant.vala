public class Constant : FlowDemoODE {
  construct {
    var x_0 = new double[] {0.0, 0.0, 0.0};

    name = "Constant";
    x.set_data(3, x_0);
    t_start = 0.0;
    t_stop = 10.0;
  }

  [NoArrayLength]
  public override void f_func(weak double[] dx, weak double[] x, weak double[] u, double t) {
    dx[0] = 1.0;
    dx[1] = 0.0;
    dx[2] = -1.0;
  }
}
