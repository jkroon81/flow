/*
 * Flow - Copyright (C) 2007 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.ODE : GLib.Object {
  public int n_states { get; set; }
  public double t_start { get; set; }
  public double t_stop { get; set; }
  public double[] x_0;

  public abstract void f_func(weak double[] dx, weak double[] x, double t);

  public void eval_f (weak double[] dx, weak double[] x, double t) {
    f_func(dx, x, t);
  }

  public void set_x_0 (double[] _x_0) {
    int i;

    x_0 = new double[_x_0.length];
    for(i = 0; i < x_0.length; i++)
      x_0[i] = _x_0[i];
  }
}
