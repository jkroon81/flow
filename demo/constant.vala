public class Constant : FlowDemoODE {
  construct {
    var x_0 = new double[] {0.0, 0.0, 0.0};

    name = "Constant";
    x.set_from_array(3, x_0);
    t_start = 0.0;
    t_stop = 10.0;
    f_func = (dx, x, u, t) => {
      dx[0] = 1.0;
      dx[1] = 0.0;
      dx[2] = -1.0;
    };
  }
}
