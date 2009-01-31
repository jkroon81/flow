/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Euler : StepMethod {
  construct {
    order = 2;
  }

  internal override Vector estimate_error() {
    Vector x_h   = vector[0];
    Vector x_l   = vector[1];
    Vector dx    = vector[2];
    Vector error = vector[3];

    dx.mul(ode.dx, h);
    x_l.add(ode.x, dx);
    dx.mul(dx, 0.5);
    x_h.add(ode.x, dx);
    ode.eval_f(dx.data, x_h.data, ode.u.data, ode.t + h/2);
    dx.mul(dx, h/2);
    x_h.add(x_h, dx);
    error.mul(x_h, -1.0);
    error.add(error, x_l);
    return error;
  }

  internal override void step() {
    ode.t += h;
    ode.x.copy(vector[0]);
    ode.eval_f(ode.dx.data, ode.x.data, ode.u.data, ode.t);
  }
}
