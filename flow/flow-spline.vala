/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

/* http://en.wikipedia.org/wiki/Cubic_Hermite_spline */

public class Flow.Spline {
  [NoArrayLength] weak double[] _dx1;
  [NoArrayLength] weak double[] _dx2;
  [NoArrayLength] weak double[] _x1;
  [NoArrayLength] weak double[] _x2;
  double _t1;
  double _t2;
  uint _size;

  [NoArrayLength]
  public void set_data(weak double[] dx1,
                       weak double[] dx2,
                       weak double[] x1,
                       weak double[] x2,
                       double t1,
                       double t2)
{
    _dx1 = dx1;
    _dx2 = dx2;
    _x1 = x1;
    _x2 = x2;
    _t1 = t1;
    _t2 = t2;
  }

  public void set_size(uint size) {
    _size = size;
  }

  [NoArrayLength]
  public void eval(weak double[] x, double t) {
    double[] c = new double[4];
    double h;
    uint i;

    h = _t2 - _t1;
    t = (t - _t1) / h;
    c[0] = 2*t*t*t - 3*t*t + 1;
    c[1] = t*t*t - 2*t*t + t;
    c[2] = -2*t*t*t + 3*t*t;
    c[3] = t*t*t - t*t;
    for(i = 0; i < _size; i++)
      x[i] = c[0]*_x1[i] + c[1]*_dx1[i]*h + c[2]*_x2[i] + c[3]*_dx2[i]*h;
  }
}
