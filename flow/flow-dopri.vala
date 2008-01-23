/*
 * Flow - Copyright (C) 2007 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Dopri : RungekuttaExplicit {
  construct {
    _c  = new double[] { 0.0,            1.0/5.0, 3.0/10.0,       4.0/5.0,      8.0/9.0,           1.0,        1.0    };
    _b1 = new double[] { 5179.0/57600.0, 0.0,     7571.0/16695.0, 393.0/640.0,  -92097.0/339200.0, 187.0/2100, 1.0/40 };
    _b2 = new double[] { 35.0/384.0,     0.0,     500.0/1113.0,   125.0/192.0,  -2187.0/6784.0,    11.0/84.0,  0.0    };
    _a  = new double[] {
      1.0/5.0,        0.0,             0.0,            0.0,          0.0,             0.0,
      3.0/40.0,       9.0/40.0,        0.0,            0.0,          0.0,             0.0,
      44.0/45.0,      -56.0/15.0,      32.0/9.0,       0.0,          0.0,             0.0,
      19372.0/6561.0, -25360.0/2187.0, 64448.0/6561.0, -212.0/729.0, 0.0,             0.0,
      9017.0/3168.0,  -355.0/33.0,     46732.0/5247.0, 49.0/176.0,   -5103.0/18656.0, 0.0,
      35.0/384.0,     0.0,             500.0/1113.0,   125.0/192.0,  -2187.0/6784.0,  11.0/84.0
    };
    _order = 5;
    _n_stages = 7;
  }
}
