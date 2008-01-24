/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Euler : StepMethod {
  construct {
    _order = 2;
  }

  public override void estimate_error (double t, double h) {
    weak Vector x_h = _vector[0];
    weak Vector x_l = _vector[1];
    weak Vector dx = _vector[2];

    _ode.eval_f(dx.get_data(), _ode.x.get_data(), _ode.u.get_data(), t);
    dx.mul(dx, h);
    x_l.add(_ode.x, dx);
    dx.mul(dx, 0.5);
    x_h.add(_ode.x, dx);
    _ode.eval_f(dx.get_data(), x_h.get_data(), _ode.u.get_data(), t + h/2);
    dx.mul(dx, h/2);
    x_h.add(x_h, dx);
    _error.mul(x_h, -1.0);
    _error.add(_error, x_l);
  }

  public override void estimate_x () {
    _ode.x.copy(_vector[0]);
  }
}
