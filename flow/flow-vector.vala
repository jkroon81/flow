/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Vector : Object {
  double[] x;

  public double* data {
    get {
      return x;
    }
  }

  public uint size {
    get {
      return x.length;
    }
    set {
      if(x.length != value)
        x = new double[value];
    }
  }

  public void set_data(uint size, double* x) {
    if(this.x.length != size)
      this.x = new double[size];
    Memory.copy(this.x, x, this.x.length * sizeof(double));
  }

  public void set_null() {
    uint i;

    for(i = 0; i < x.length; i++)
      x[i] = 0.0;
  }

  public void copy(Vector v) {
    if(x.length != v.x.length)
      x = new double[v.x.length];
    Memory.copy(x, v.x, x.length * sizeof(double));
  }

  public void mul(Vector v, double s) {
    uint i;

    if(x.length != v.x.length)
      x = new double[v.x.length];
    for(i = 0; i < x.length; i++)
      x[i] = v.x[i] * s;
  }

  public void add(Vector v1, Vector v2) {
    uint i;

    assert(v1.x.length == v2.x.length);
    if(x.length != v1.x.length)
      x = new double[v1.x.length];
    for(i = 0; i < x.length; i++)
      x[i] = v1.x[i] + v2.x[i];
  }

  public double norm_1 () {
    uint i;
    double retval = 0.0;

    for(i = 0; i < x.length; i++)
      retval += (x[i] > 0.0 ? x[i] : -x[i]);
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
    double[4] c = {0, 0, 0, 0};

    assert(v1.x.length == v2.x.length);
    assert(v1.x.length == dv1.x.length);
    assert(v1.x.length == dv2.x.length);
    temp = new Vector();
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
