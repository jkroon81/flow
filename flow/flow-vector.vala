/*
 * Flow - Copyright (C) 2007 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Vector : GLib.Object {
  double[] _x;

  public int size {
    get { return _x.length; }
    set {
      if(_x.length != value)
        _x = new double[value];
    }
  }

  public weak double[] get () {
    return _x;
  }

  public void set (weak double[] x) {
    if(_x.length != x.length)
      _x = new double[x.length];
    GLib.Memory.copy(_x, x, _x.length * sizeof(double));
  }

  public void copy(Vector v) {
    if(_x.length != v._x.length)
      _x = new double[v._x.length];
    GLib.Memory.copy(_x, v._x, _x.length * sizeof(double));
  }

  public void mul(Vector v, double s) {
    int i;

    if(_x.length != v._x.length)
      _x = new double[v._x.length];
    for(i = 0; i < _x.length; i++)
      _x[i] = v._x[i] * s;
  }

  public void add(Vector v1, Vector v2) {
    int i;

    GLib.assert(v1._x.length == v2._x.length);
    if(_x.length != v1._x.length)
      _x = new double[v1._x.length];
    for(i = 0; i < _x.length; i++)
      _x[i] = v1._x[i] + v2._x[i];
  }

  public double norm_1 () {
    int i;
    double retval = 0.0;

    for(i = 0; i < _x.length; i++)
      retval += (_x[i] > 0.0 ? _x[i] : -_x[i]);
    return retval;
  }
}
