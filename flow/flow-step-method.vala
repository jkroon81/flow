/*
 * Flow - Copyright (C) 2007 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public abstract class Flow.StepMethod : GLib.Object {
  int N_VECTORS = 10;
  protected Vector _error;
  protected Vector[] _vector;
  protected ODE _ode;
  protected int _order;

  public int order {
    get { return _order; }
  }

  public Vector error {
    get { return _error; }
  }

  public ODE ode {
    set {
      int i;

      _ode = value;
      _error.size = _ode.x.size;
      for(i = 0; i < N_VECTORS; i++)
        _vector[i].size = _ode.x.size;
    }
  }

  construct {
    int i;

    _error = new Vector();
    _vector = new Vector[N_VECTORS];
    for(i = 0; i < N_VECTORS; i++)
      _vector[i] = new Vector();
  }

  public abstract void estimate_error (double t, double h);
  public abstract void estimate_x ();
}
