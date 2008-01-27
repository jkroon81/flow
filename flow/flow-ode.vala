/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public abstract class Flow.ODE : GLib.Object {
  uint _n_f_evals;
  Vector _dx;
  Vector _x;
  Vector _u;
  public double t_start { get; set; }
  public double t_stop { get; set; }
  public double t { get; set; }

  public uint n_f_evals {
    get { return _n_f_evals; }
  }

  public Vector dx {
    get { return _dx; }
  }

  public Vector x {
    get { return _x; }
  }

  public Vector u {
    get { return _u; }
  }

  construct {
    _dx = new Vector();
    _x = new Vector();
    _u = new Vector();
  }

  [NoArrayLength]
  public abstract void f_func(weak double[] dx, weak double[] x, weak double[] u, double t);

  [NoArrayLength]
  public void eval_f (weak double[] dx, weak double[] x, weak double[] u, double t) {
    _n_f_evals++;
    f_func(dx, x, u, t);
  }
}
