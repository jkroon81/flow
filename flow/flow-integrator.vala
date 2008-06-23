/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Integrator : ODESolver {
  public uint n_successful_steps { get; private set; }
  public uint n_failed_steps     { get; private set; }
  public uint n_samples          { private get; set construct; default = 500; }
  public bool uniform_sampling   { private get; set construct; default = false; }
  public StepMethod step_method  { private get; set; }

  public signal void sample (ODE ode);

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

    n_successful_steps = 0;
    n_failed_steps = 0;
    step_method.ode = ode;
    ode.t = ode.t_start;
    ode.dx.size = ode.x.size;
    ode.eval_f(ode.dx.get_data(), ode.x.get_data(), ode.u.get_data(), ode.t);
    sample(ode);
    if(uniform_sampling) {
      tmp = new Vector[4];
      for(n = 0; n < 4; n++)
        tmp[n] = new Vector();
    }
    h = 1.0;
    n = 1;
    t_total = ode.t_stop - ode.t_start;
    t_sample = ode.t_start + t_total * n++ / n_samples;
    while(true) {
      if(ode.t + h > ode.t_stop) {
        h = ode.t_stop - ode.t;
        final_step = true;
      } else
        final_step = false;
      step_method.h = h;
      local_error = step_method.estimate_error().norm_1();
      if(local_error < tolerance) {
        n_successful_steps++;
        if(uniform_sampling) {
          t_prev = ode.t;
          tmp[0].copy(ode.x);
          tmp[2].mul(ode.dx, h);
        }
        step_method.step();
        if(uniform_sampling) {
          t_next = ode.t;
          tmp[1].copy(ode.x);
          tmp[3].mul(ode.dx, h);
          while(t_sample < t_next) {
            ode.t = t_sample;
            ode.x.interpolate(tmp[0], tmp[1], tmp[2], tmp[3], t_prev, t_next, t_sample);
            sample(ode);
            t_sample = ode.t_start + t_total * n++ / n_samples;
          }
          ode.t = t_next;
          ode.x.copy(tmp[1]);
        } else
          sample(ode);
        if(final_step)
          break;
      } else
        n_failed_steps++;
      h = 0.9 * h * Math.pow(tolerance / local_error, 1.0 / step_method.order);
    }
    if(uniform_sampling)
      sample(ode);
  }
}
