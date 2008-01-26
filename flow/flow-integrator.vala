/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Integrator : ODESolver {
  uint _n_successful_steps;
  uint _n_failed_steps;
  StepMethod _step_method;

  public uint n_successful_steps {
    get { return _n_successful_steps; }
  }

  public uint n_failed_steps {
    get { return _n_failed_steps; }
  }

  public StepMethod step_method {
    set { _step_method = value; }
  }

  public signal void sample (ODE ode);

  public void run() {
    double h;
    double local_error;

    _n_successful_steps = 0;
    _n_failed_steps = 0;
    _step_method.ode = _ode;
    _ode.t = _ode.t_start;
    sample(_ode);
    h = 1.0;
    while(_ode.t < _ode.t_stop) {
      local_error = _step_method.estimate_error(h).norm_1();
      if(local_error < _tolerance) {
        _n_successful_steps++;
        _step_method.step();
        _ode.t += h;
        sample(_ode);
      } else {
        _n_failed_steps++;
      }
      h = 0.9 * h * GLib.Math.pow(_tolerance / local_error, 1.0 / _step_method.order);
      if(_ode.t + h > _ode.t_stop)
        h = _ode.t_stop - _ode.t;
    }
  }
}
