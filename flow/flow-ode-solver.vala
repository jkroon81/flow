/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.ODESolver : Solver {
  protected ODE _ode;

  public ODE ode {
    get { return _ode; }
    set { _ode = value; }
  }
}
