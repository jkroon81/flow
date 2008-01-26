/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.RungekuttaExplicit : StepMethod {
  [NoArrayLength] protected double[] _c;
  [NoArrayLength] protected double[] _b1;
  [NoArrayLength] protected double[] _b2;
  [NoArrayLength] protected double[] _a;
  protected uint _n_stages;

  public override weak Vector estimate_error(double h) {
    weak Vector[] k   = _vector;
    weak Vector dx    = _vector[_n_stages];
    weak Vector error = _vector[_n_stages+1];
    weak Vector temp  = _vector[_n_stages+2];
    uint i;
    uint j;

    error.set_null();
    for(i = 0; i < _n_stages; i++) {
      temp.copy(_ode.x);
      for(j = 0; j < i; j++) {
        dx.mul(k[j], _a[(i-1)*(_n_stages-1)+j]);
        temp.add(temp, dx);
      }
      _ode.eval_f(dx.get_data(), temp.get_data(), _ode.u.get_data(), _ode.t + _c[i]*h);
      k[i].mul(dx, h);
      temp.mul(k[i], _b2[i] - _b1[i]);
      error.add(error, temp);
    }
    return error;
  }

  public override void step() {
    weak Vector[] k = _vector;
    uint i;

    for(i = 0; i < _n_stages; i++) {
      k[i].mul(k[i], _b2[i]);
      _ode.x.add(_ode.x, k[i]);
    }
  }
}
