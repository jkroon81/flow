/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Solver : GLib.Object {
  protected double _tolerance;

  public double tolerance {
    get { return _tolerance; }
    set { _tolerance = value; }
  }

  construct {
    _tolerance = 0.0001;
  }
}
