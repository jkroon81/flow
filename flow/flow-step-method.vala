/*
 * Flow - Copyright (C) 2007 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public abstract class Flow.StepMethod : GLib.Object {
  int N_VECTORS = 10;
  protected Vector[] vector = new Vector[N_VECTORS];
  public int order { get; set; }
  public Vector x { get; set; }
  public Vector error { get; set; }
  public Integrator integrator { get; set; }

  construct {
    x = new Vector();
    error = new Vector();
  }

  public abstract void estimate_error (double t, double h);
  public abstract void estimate_x ();

  public void prepare (int n_states) {
    int i;

    x.size = n_states;
    x.set(integrator.ode.x_0);
    error.size = n_states;
    for(i = 0; i < N_VECTORS; i++) {
      vector[i] = new Vector();
      vector[i].size = n_states;
    }
  }
}
