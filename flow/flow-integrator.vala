/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Integrator : ODESolver {
  uint _n_successful_steps;
  uint _n_failed_steps;
  uint _n_samples;
  bool _uniform_sampling;
  StepMethod _step_method;

  public uint n_successful_steps {
    get { return _n_successful_steps; }
  }

  public uint n_failed_steps {
    get { return _n_failed_steps; }
  }

  public uint n_samples {
    set { _n_samples = value; }
  }

  public bool uniform_sampling {
    set { _uniform_sampling = value; }
  }

  public StepMethod step_method {
    set { _step_method = value; }
  }

  public signal void sample (ODE ode);

  construct {
    _uniform_sampling = true;
    _n_samples = 500;
  }

  public void run() {
    Vector x1;
    Vector x2;
    Vector dx1;
    Vector dx2;
    double local_error;
    double t_sample;
    double t_prev;
    double t_next;
    double h_sample;
    double h;

    _n_successful_steps = 0;
    _n_failed_steps = 0;
    _step_method.ode = _ode;
    _ode.t = _ode.t_start;
    _ode.dx.set_size(_ode.x.get_size());
    _ode.u.set_size(_ode.x.get_size());
    _ode.eval_f(_ode.dx.get_data(), _ode.x.get_data(), _ode.u.get_data(), _ode.t);
    sample(_ode);
    x1 = new Vector();
    x2 = new Vector();
    dx1 = new Vector();
    dx2 = new Vector();
    _step_method.h = 1.0;
    local_error = _step_method.estimate_error().norm_1();
    h = 0.9 * GLib.Math.pow(_tolerance / local_error, 1.0 / _step_method.order);
    x1.copy(_ode.x);
    dx1.mul(_ode.dx, h);
    h_sample = (_ode.t_stop - _ode.t_start) / _n_samples;
    t_prev = _ode.t_start;
    t_sample = t_prev + h_sample;
    while(_ode.t < _ode.t_stop) {
      _step_method.h = h;
      local_error = _step_method.estimate_error().norm_1();
      if(local_error < _tolerance) {
        _n_successful_steps++;
        _step_method.step();
        if(_uniform_sampling) {
          t_next = _ode.t;
          x2.copy(_ode.x);
          dx2.mul(_ode.dx, h);
          while(t_sample < t_next) {
            _ode.t = t_sample;
            _ode.x.interpolate(x1, x2, dx1, dx2, t_prev, t_next, t_sample);
            sample(ode);
            t_sample += h_sample;
          }
          _ode.t = t_prev = t_next;
          x1.copy(x2);
          dx1.copy(dx2);
          _ode.x.copy(x2);
        } else
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
