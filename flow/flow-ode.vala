/*
 * Flow - Copyright (C) 2007 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.ODE : GLib.Object {
  Vector _x;
  public double t_start { get; set; }
  public double t_stop { get; set; }

  public Vector x {
    get { return _x; }
  }

  construct {
    _x = new Vector();
  }

  public abstract void f_func(weak double[] dx, weak double[] x, double t);

  public void eval_f (weak double[] dx, weak double[] x, double t) {
    f_func(dx, x, t);
  }
}
