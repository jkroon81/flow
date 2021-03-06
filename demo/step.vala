public class Step : FlowDemoODE {
  construct {
    var x_0 = new double[] {0.0, 0.0};

    name = "Step";
    x.set_from_array(2, x_0);
    t_start = 0.0;
    t_stop = 20.0;
    f_func = (dx, x, u, t) => {
      dx[0] = x[1];
      dx[1] = - x[0] - x[1] + 1.0;
    };
  }
}
