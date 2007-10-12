/*
 * Flow - Copyright (C) 2007 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public class Flow.Solver : GLib.Object {
  public double tolerance { get; set; }

  construct {
    tolerance = 0.0001;
  }
}
