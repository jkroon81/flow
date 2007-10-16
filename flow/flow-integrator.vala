/*
 * Flow - Copyright (C) 2007 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Integrator : ODESolver {
  StepMethod _step_method;

  public StepMethod step_method {
    set { _step_method = value; }
  }

  public void run() {
    int i;
    double t;
    double h;
    double local_error;

    _step_method.ode = _ode;
    t = _ode.t_start;
    h = 1.0;

    // FIXME: Emit a signal once valac supports arrays
    //        as signal callback arguments.
    for(i = 0; i < _ode.x.size; i++)
      GLib.stdout.printf("x%d = %f, ", i, _ode.x.get()[i]);
    GLib.stdout.printf("t = %f\n", t);
    while(t < _ode.t_stop) {
      _step_method.estimate_error(t, h);
      local_error = _step_method.error.norm_1();
      if(local_error < _tolerance) {
        _step_method.estimate_x();
        t += h;
        // FIXME: Emit a signal once valac supports arrays
        //        as signal callback arguments.
        for(i = 0; i < _ode.x.size; i++)
          GLib.stdout.printf("x%d = %f, ", i, _ode.x.get()[i]);
        GLib.stdout.printf("t = %f\n", t);
      }
      h = 0.9 * h * GLib.Math.pow(_tolerance / local_error, 1.0 / _step_method.order);
      if(t + h > _ode.t_stop)
        h = _ode.t_stop - t;
    }
  }
}
