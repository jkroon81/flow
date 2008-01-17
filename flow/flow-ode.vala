/*
 * Flow - Copyright (C) 2007 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public abstract class Flow.ODE : GLib.Object {
  uint _n_f_evals;
  Vector _x;
  public double t_start { get; set; }
  public double t_stop { get; set; }

  public uint n_f_evals {
    get { return _n_f_evals; }
  }

  public Vector x {
    get { return _x; }
  }

  construct {
    _x = new Vector();
  }

  public abstract void f_func(weak double[] dx, weak double[] x, double t);

  public void eval_f (weak double[] dx, weak double[] x, double t) {
    _n_f_evals++;
    f_func(dx, x, t);
  }
}
