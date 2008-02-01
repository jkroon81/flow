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
    _uniform_sampling = false;
    _n_samples = 500;
  }

  public void run() {
    Vector[] tmp;
    double local_error;
    double t_total;
    double t_sample;
    double t_prev;
    double t_next;
    double h;
    uint n;
    bool final_step;

    _n_successful_steps = 0;
    _n_failed_steps = 0;
    _step_method.ode = _ode;
    _ode.t = _ode.t_start;
    _ode.dx.set_size(_ode.x.get_size());
    _ode.eval_f(_ode.dx.get_data(), _ode.x.get_data(), _ode.u.get_data(), _ode.t);
    sample(_ode);
    if(_uniform_sampling) {
      tmp = new Vector[4];
      for(n = 0; n < 4; n++)
        tmp[n] = new Vector();
    }
    h = 1.0;
    n = 1;
    t_total = _ode.t_stop - _ode.t_start;
    t_sample = _ode.t_start + t_total * n++ / _n_samples;
    while(true) {
      if(_ode.t + h > _ode.t_stop) {
        h = _ode.t_stop - _ode.t;
        final_step = true;
      } else
        final_step = false;
      _step_method.h = h;
      local_error = _step_method.estimate_error().norm_1();
      if(local_error < _tolerance) {
        _n_successful_steps++;
        if(_uniform_sampling) {
          t_prev = _ode.t;
          tmp[0].copy(_ode.x);
          tmp[2].mul(_ode.dx, h);
        }
        _step_method.step();
        if(_uniform_sampling) {
          t_next = _ode.t;
          tmp[1].copy(_ode.x);
          tmp[3].mul(_ode.dx, h);
          while(t_sample < t_next) {
            _ode.t = t_sample;
            _ode.x.interpolate(tmp[0], tmp[1], tmp[2], tmp[3], t_prev, t_next, t_sample);
            sample(ode);
            t_sample = _ode.t_start + t_total * n++ / _n_samples;
          }
          _ode.t = t_next;
          _ode.x.copy(tmp[1]);
        } else
          sample(_ode);
        if(final_step)
          break;
      } else
        _n_failed_steps++;
      h = 0.9 * h * GLib.Math.pow(_tolerance / local_error, 1.0 / _step_method.order);
    }
    if(_uniform_sampling)
      sample(_ode);
  }
}
