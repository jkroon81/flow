/*
 * Flow - Copyright (C) 2007 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Integrator : ODESolver {
  public StepMethod step_method { get; set; }

  public void run() {
    int i;
    double t;
    double h;
    double local_error;

    step_method.prepare(ode.n_states);
    t = ode.t_start;
    h = 1.0;

    while(t < ode.t_stop) {
      step_method.estimate_error(t, h);
      local_error = step_method.error.norm_1();
      if(local_error < tolerance) {
        step_method.estimate_x();
        t += h;
        // FIXME: Emit a signal once valac supports arrays
        //        as signal callback arguments.
        for(i = 0; i < ode.n_states; i++)
          GLib.stdout.printf("x%d = %f, ", i, step_method.x.get()[i]);
        GLib.stdout.printf("t = %f\n", t);
      }
      h = 0.9 * h * GLib.Math.pow(tolerance / local_error, 1.0 / step_method.order);
    }
  }
}
