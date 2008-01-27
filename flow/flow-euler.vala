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

  public override weak Vector estimate_error() {
    weak Vector x_h   = _vector[0];
    weak Vector x_l   = _vector[1];
    weak Vector dx    = _vector[2];
    weak Vector error = _vector[3];

    dx.mul(_ode.dx, _h);
    x_l.add(_ode.x, dx);
    dx.mul(dx, 0.5);
    x_h.add(_ode.x, dx);
    _ode.eval_f(dx.get_data(), x_h.get_data(), _ode.u.get_data(), _ode.t + _h/2);
    dx.mul(dx, _h/2);
    x_h.add(x_h, dx);
    error.mul(x_h, -1.0);
    error.add(error, x_l);
    return error;
  }

  public override void step() {
    _ode.t += _h;
    _ode.x.copy(_vector[0]);
    _ode.eval_f(_ode.dx.get_data(), _ode.x.get_data(), _ode.u.get_data(), _ode.t);
  }
}
