using Flow;

class LinearTestEquation {
  class MyODE : ODE {
    public override void f_func(weak double[] dx, weak double[] x, double t) {
      dx[0] = -x[0];
    }
  }

  public static int main(string[] args) {
    var x_0 = new double[] {1.0};
    var integrator = new Integrator();
    var ode = new MyODE();

    integrator.step_method = new Euler();
    integrator.ode = ode;
    ode.t_start = 0.0;
    ode.t_stop = 10.0;
    ode.x.set(x_0);
    integrator.run();

    return 0;
  }
}
