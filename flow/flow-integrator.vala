/*
 * Flow - Copyright (C) 2007 Jacob Kroon
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

  public signal void sample (ODESample data);

  public void run() {
    ODESample data;
    double t;
    double h;
    double local_error;

    _n_successful_steps = 0;
    _n_failed_steps = 0;
    _step_method.ode = _ode;
    t = _ode.t_start;
    h = 1.0;
    data = new ODESample();
    data.x = _ode.x.get();
    data.n_states = _ode.x.size;
    data.error = 0.0;
    data.t = t;
    sample(data);
    while(t < _ode.t_stop) {
      _step_method.estimate_error(t, h);
      local_error = _step_method.error.norm_1();
      if(local_error < _tolerance) {
        _n_successful_steps++;
        _step_method.estimate_x();
        t += h;
        data.error = local_error;
        data.t = t;
        sample(data);
      } else {
        _n_failed_steps++;
      }
      h = 0.9 * h * GLib.Math.pow(_tolerance / local_error, 1.0 / _step_method.order);
      if(t + h > _ode.t_stop)
        h = _ode.t_stop - t;
    }
  }
}
