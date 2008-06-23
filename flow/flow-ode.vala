/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public static delegate void Flow.FFunc (double* dx, double* x, double* u, double t);

public class Flow.ODE : Object {
  public double t_start { get; set; }
  public double t_stop  { get; set; }
  public double t       { get; set; }
  public uint n_f_evals { get; private set; }
  public Vector dx      { get; private set; }
  public Vector x       { get; private set; }
  public Vector u       { get; private set; }
  public FFunc f_func   { private get; set; }

  construct {
    dx = new Vector();
    x = new Vector();
    u = new Vector();
  }

  public void eval_f (double* dx, double* x, double* u, double t) {
    n_f_evals++;
    f_func(dx, x, u, t);
  }
}
