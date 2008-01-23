/*
 * Flow - Copyright (C) 2007 Jacob Kroon
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

  public override void estimate_error (double t, double h) {
    weak Vector[] k;
    weak Vector x;
    weak Vector dx;
    weak Vector temp;
    uint i;
    uint j;

    k = _vector;
    x = _ode.x;
    dx = _vector[_n_stages];
    temp = _vector[_n_stages+1];
    _error.set_null();

    for(i = 0; i < _n_stages; i++) {
      temp.copy(x);
      for(j = 0; j < i; j++) {
        dx.mul(k[j], _a[(i-1)*(_n_stages-1)+j]);
        temp.add(temp, dx);
      }
      _ode.eval_f(dx.get_data(), temp.get_data(), _ode.u.get_data(), t + _c[i]*h);
      k[i].mul(dx, h);
      temp.mul(k[i], _b2[i] - _b1[i]);
      _error.add(_error, temp);
    }
  }

  public override void estimate_x () {
    weak Vector[] k;
    weak Vector x;
    uint i;

    k = _vector;
    x = _ode.x;
    for(i = 0; i < _n_stages; i++) {
      k[i].mul(k[i], _b2[i]);
      x.add(x, k[i]);
    }
  }
}
