/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public abstract class Flow.ODE : GLib.Object {
  public double t_start { get; set; }
  public double t_stop  { get; set; }
  public double t       { get; set; }
  public uint n_f_evals { get; private set; }
  public Vector dx;
  public Vector x;
  public Vector u;

  construct {
    dx = new Vector();
    x = new Vector();
    u = new Vector();
  }

  [NoArrayLength]
  public abstract void f_func(weak double[] dx, weak double[] x, weak double[] u, double t);

  [NoArrayLength]
  public void eval_f (weak double[] dx, weak double[] x, weak double[] u, double t) {
    _n_f_evals++;
    f_func(dx, x, u, t);
  }
}
