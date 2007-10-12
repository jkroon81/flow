using Flow;

class StiffPendulum {
  class MyODE : ODE {
    double C = 1000.0;

    construct {
      n_states = 4;
    }

    public override void f_func(weak double[] dx, weak double[] x, double t) {
      double lambda;

      lambda = C*(GLib.Math.sqrt(x[0]*x[0]+x[1]*x[1])-1)/GLib.Math.sqrt(x[0]*x[0]+x[1]*x[1]);
      dx[0] = x[2];
      dx[1] = x[3];
      dx[2] = -lambda*x[0];
      dx[3] = -lambda*x[1] - 1.0;
    }
  }

  public static int main(string[] args) {
    var x_0 = new double[] {0.9, 0.1, 0.0, 0.0};
    var integrator = new Integrator();
    var ode = new MyODE();

    integrator.step_method = new Euler();
    integrator.step_method.integrator = integrator;
    integrator.ode = ode;
    ode.t_start = 0.0;
    ode.t_stop = 10.0;
    ode.set_x_0(x_0);
    integrator.run();

    return 0;
  }
}
