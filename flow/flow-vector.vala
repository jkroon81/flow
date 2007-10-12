/*
 * Flow - Copyright (C) 2007 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Vector : GLib.Object {
  double[] x;

  public int size {
    get { return x.length; }
    set {
      if (x.length != value)
        x = new double[value];
    }
  }

  public weak double[] get () {
    return x;
  }

  public void set (weak double[] _x) {
    // FIXME: Use copy() method for arrays when
    //        valac supports it.
    int i;

    size = _x.length;
    for(i = 0; i < size; i++)
      x[i] = _x[i];
  }

  public void copy(Vector v) {
    int i;

    size = v.size;
    for(i = 0; i < size; i++)
      x[i] = v.x[i];
  }

  public void mul(Vector v, double s) {
    int i;

    size = v.size;
    for(i = 0; i < size; i++)
      x[i] = v.x[i] * s;
  }

  public void add(Vector v1, Vector v2) {
    int i;

    GLib.assert(v1.size == v2.size);
    size = v1.size;
    for(i = 0; i < size; i++)
      x[i] = v1.x[i] + v2.x[i];
  }

  public double norm_1 () {
    int i;
    double retval = 0.0;

    for(i = 0; i < size; i++)
      retval += (x[i] > 0.0 ? x[i] : -x[i]);
    return retval;
  }
}
