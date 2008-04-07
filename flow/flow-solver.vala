/*
 * Flow - Copyright (C) 2007-2008 Jacob Kroon
 *
 * Contributor(s):
 *   Jacob Kroon <jacob.kroon@gmail.com>
 */

public abstract class Flow.Solver : GLib.Object {
  public double tolerance { protected get; set construct; default = 0.0001; }
}
