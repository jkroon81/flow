/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public abstract class Flow.StepMethod : GLib.Object {
  int N_VECTORS = 10;
  [NoArrayLength]
  protected Vector[] _vector;
  protected ODE _ode;
  protected int _order;

  public int order {
    get { return _order; }
  }

  public ODE ode {
    set {
      int i;

      _ode = value;
      for(i = 0; i < N_VECTORS; i++)
        _vector[i].set_size(_ode.x.get_size());
    }
  }

  construct {
    int i;

    _vector = new Vector[N_VECTORS];
    for(i = 0; i < N_VECTORS; i++)
      _vector[i] = new Vector();
  }

  public abstract weak Vector estimate_error(double h);
  public abstract void step();
}
