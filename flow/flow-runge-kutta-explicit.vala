/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public abstract class Flow.RungeKuttaExplicit : StepMethod {
  protected double* c;
  protected double* b1;
  protected double* b2;
  protected double* a;
  protected uint n_stages;

  public override Vector estimate_error() {
    unowned Vector[] k = vector;
    Vector dx    = vector[n_stages];
    Vector error = vector[n_stages+1];
    Vector temp  = vector[n_stages+2];
    uint i;
    uint j;

    /* NOTE: c[0] must always be zero */
    k[0].mul(ode.dx, h);
    error.mul(k[0], b2[0] - b1[0]);
    for(i = 1; i < n_stages; i++) {
      temp.copy(ode.x);
      for(j = 0; j < i; j++) {
        dx.mul(k[j], a[(i-1)*(n_stages-1)+j]);
        temp.add(temp, dx);
      }
      ode.eval_f(dx.get_data(), temp.get_data(), ode.u.get_data(), ode.t + c[i]*h);
      k[i].mul(dx, h);
      temp.mul(k[i], b2[i] - b1[i]);
      error.add(error, temp);
    }
    return error;
  }

  public override void step() {
    unowned Vector[] k = vector;
    uint i;

    ode.t += h;
    for(i = 0; i < n_stages; i++) {
      k[i].mul(k[i], b2[i]);
      ode.x.add(ode.x, k[i]);
    }
    ode.eval_f(ode.dx.get_data(), ode.x.get_data(), ode.u.get_data(), ode.t);
  }
}
