/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Vector : GLib.Object {
  double[] _x;

  public uint size {
    get {
      return _x.length;
    }
    set {
      if(_x.length != value)
        _x = new double[value];
    }
  }

  [NoArrayLength]
  public weak double[] get_data () {
    return _x;
  }

  [NoArrayLength]
  public void set_data(uint size, weak double[] x) {
    if(_x.length != size)
      _x = new double[size];
    GLib.Memory.copy(_x, x, _x.length * sizeof(double));
  }

  public void set_null() {
    uint i;

    for(i = 0; i < _x.length; i++)
      _x[i] = 0.0;
  }

  public void copy(Vector v) {
    if(_x.length != v._x.length)
      _x = new double[v._x.length];
    GLib.Memory.copy(_x, v._x, _x.length * sizeof(double));
  }

  public void mul(Vector v, double s) {
    uint i;

    if(_x.length != v._x.length)
      _x = new double[v._x.length];
    for(i = 0; i < _x.length; i++)
      _x[i] = v._x[i] * s;
  }

  public void add(Vector v1, Vector v2) {
    uint i;

    GLib.assert(v1._x.length == v2._x.length);
    if(_x.length != v1._x.length)
      _x = new double[v1._x.length];
    for(i = 0; i < _x.length; i++)
      _x[i] = v1._x[i] + v2._x[i];
  }

  public double norm_1 () {
    uint i;
    double retval = 0.0;

    for(i = 0; i < _x.length; i++)
      retval += (_x[i] > 0.0 ? _x[i] : -_x[i]);
    return retval;
  }

  public void interpolate(Vector v1,
                          Vector v2,
                          Vector dv1,
                          Vector dv2,
                          double t1,
                          double t2,
                          double t)
  {
    /* See http://en.wikipedia.org/wiki/Cubic_Hermite_spline */
    Vector temp;
    double[] c;

    GLib.assert(v1._x.length == v2._x.length);
    GLib.assert(v1._x.length == dv1._x.length);
    GLib.assert(v1._x.length == dv2._x.length);
    temp = new Vector();
    c = new double[4];
    t = (t - t1) / (t2 - t1);
    c[0] = 2*t*t*t - 3*t*t + 1;
    c[1] = t*t*t - 2*t*t + t;
    c[2] = -2*t*t*t + 3*t*t;
    c[3] = t*t*t - t*t;
    temp.mul(v1, c[0]);
    copy(temp);
    temp.mul(dv1, c[1]);
    add(temp, this);
    temp.mul(v2, c[2]);
    add(temp, this);
    temp.mul(dv2, c[3]);
    add(temp, this);
  }
}
