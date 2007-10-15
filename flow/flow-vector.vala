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
      if (_x.length != value)
        _x = new double[value];
    }
  }

  public weak double[] get () {
    return _x;
  }

  public void set (weak double[] x) {
    // FIXME: Use copy() method for arrays when
    //        valac supports it.
    int i;

    size = x.length;
    for(i = 0; i < size; i++)
      _x[i] = x[i];
  }

  public void copy(Vector v) {
    int i;

    size = v.size;
    for(i = 0; i < size; i++)
      _x[i] = v._x[i];
  }

  public void mul(Vector v, double s) {
    int i;

    size = v.size;
    for(i = 0; i < size; i++)
      _x[i] = v._x[i] * s;
  }

  public void add(Vector v1, Vector v2) {
    int i;

    GLib.assert(v1.size == v2.size);
    size = v1.size;
    for(i = 0; i < size; i++)
      _x[i] = v1._x[i] + v2._x[i];
  }

  public double norm_1 () {
    int i;
    double retval = 0.0;

    for(i = 0; i < size; i++)
      retval += (_x[i] > 0.0 ? _x[i] : -_x[i]);
    return retval;
  }
}
