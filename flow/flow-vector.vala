/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Vector {
  [NoArrayLength]
  double[] _x;
  uint _size;

  public uint get_size() {
    return _size;
  }

  public void set_size(uint size) {
    if(_size != size) {
      _size = size;
      _x = new double[_size];
    }
  }

  [NoArrayLength]
  public weak double[] get_data () {
    return _x;
  }

  [NoArrayLength]
  public void set_data(uint size, weak double[] x) {
    if(_size != size)
      set_size(size);
    GLib.Memory.copy(_x, x, _size * sizeof(double));
  }

  public void set_null() {
    uint i;

    for(i = 0; i < _size; i++)
      _x[i] = 0.0;
  }

  public void copy(Vector v) {
    if(_size != v._size)
      set_size(v._size);
    GLib.Memory.copy(_x, v._x, _size * sizeof(double));
  }

  public void mul(Vector v, double s) {
    uint i;

    if(_size != v._size)
      set_size(v._size);
    for(i = 0; i < _size; i++)
      _x[i] = v._x[i] * s;
  }

  public void add(Vector v1, Vector v2) {
    uint i;

    GLib.assert(v1._size == v2._size);
    if(_size != v1._size)
      set_size(v1._size);
    for(i = 0; i < _size; i++)
      _x[i] = v1._x[i] + v2._x[i];
  }

  public double norm_1 () {
    uint i;
    double retval = 0.0;

    for(i = 0; i < _size; i++)
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

    GLib.assert(v1._size == v2._size);
    GLib.assert(v1._size == dv1._size);
    GLib.assert(v1._size == dv2._size);
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
