public class LinearTestEquation : FlowDemoODE {
  construct {
    var x_0 = new double[] {1.0};

    name = "Linear Test Equation";
    x.set_from_array(1, x_0);
    t_start = 0.0;
    t_stop = 10.0;
    f_func = (dx, x, u, t) => {
      dx[0] = -x[0];
    };
  }
}
