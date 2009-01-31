/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public abstract class Flow.StepMethod : Object {
  const int N_VECTORS = 10;
  protected Vector[] vector;
  public ODE ode   { protected get; set; }
  public int order { get; protected set; }
  public double h  { protected get; set; }

  construct {
    int i;

    vector = new Vector[N_VECTORS];
    for(i = 0; i < N_VECTORS; i++)
      vector[i] = new Vector();
  }

  internal abstract Vector estimate_error();
  internal abstract void step();
}
