public class StiffPendulum : FlowDemoODE {
  const double C = 1000.0;

  construct {
    var x_0 = new double[] {0.9, 0.1, 0.0, 0.0};

    name = "Stiff Pendulum";
    x.set_from_array(4, x_0);
    t_start = 0.0;
    t_stop = 10.0;
    f_func= (dx, x, u, t) => {
      double lambda;

      lambda = C*(Math.sqrt(x[0]*x[0]+x[1]*x[1])-1)/Math.sqrt(x[0]*x[0]+x[1]*x[1]);
      dx[0] = x[2];
      dx[1] = x[3];
      dx[2] = -lambda*x[0];
      dx[3] = -lambda*x[1] - 1.0;
    };
  }
}
