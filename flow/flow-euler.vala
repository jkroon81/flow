/*
 * Flow - Copyright (C) 2007 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Euler : StepMethod {
  construct {
    order = 2;
  }

  public override void estimate_error (double t, double h) {
    int i;
    weak Vector x_h = vector[0];
    weak Vector x_l = vector[1];
    weak Vector dx = vector[2];

    integrator.ode.eval_f(dx.get(), x.get(), t);
    dx.mul(dx, h);
    x_l.add(x, dx);
    dx.mul(dx, 0.5);
    x_h.add(x, dx);
    integrator.ode.eval_f(dx.get(), x_h.get(), t + h/2);
    dx.mul(dx, h/2);
    x_h.add(x_h, dx);
    error.mul(x_h, -1.0);
    error.add(error, x_l);
  }

  public override void estimate_x () {
    x.copy(vector[0]);
  }
}
