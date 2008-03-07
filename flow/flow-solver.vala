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
    set construct { _tolerance = value; }
    default(0.0001);
  }
}
