using GLib;

enum Flags {
  NONE        = 0,
  PRINT_STATS = 1 << 0
}

class FlowDemo : Object {
  FlowDemoODE[] ode;

  void print_help () {
    int i;

    stdout.printf("Usage: flow-demo <ode>\n");
    stdout.printf(" ODE\n");
    for(i = 0; i < ode.length; i++)
      stdout.printf("  %d %s\n", i + 1, ode[i].name);
  }

  public int run(string[] args) {
    Flow.Integrator integrator;
    Flags flags;
    int ode_id;
    int i;

    ode = new FlowDemoODE[] {
      new BallOnBeam(),
      new LinearTestEquation(),
      new Step(),
      new StiffPendulum()
    };

    if(args.length < 2) {
      print_help();
      return 0;
    }

    ode_id = args[1].to_int();
    if(ode_id < 1 || ode_id > ode.length) {
      print_help();
      return 0;
    }

    flags = Flags.NONE;
    for(i = 2; i < args.length; i++)
      if(args[i] == "--print-stats")
        flags |= Flags.PRINT_STATS;
      else {
        print_help();
        return 0;
      }

    integrator = new Flow.Integrator();
    integrator.step_method = new Flow.Euler();
    integrator.ode = ode[ode_id - 1];
    integrator.sample += (integrator, data) => {
      int i;

      for(i = 0; i < data.size; i++)
        stdout.printf("x%d = %f, ", i, data.x[i]);
      stdout.printf("t = %f\n", data.t);
    };
    integrator.run();

    if ((flags & Flags.PRINT_STATS) != 0) {
      stdout.printf("Number of F-evaluations: %d\n", ode[ode_id - 1].n_f_evals);
      stdout.printf("Number of successful steps: %d\n", integrator.n_successful_steps);
      stdout.printf("Number of failed steps: %d\n", integrator.n_failed_steps);
    }

    return 0;
  }

  public static int main(string[] args) {
    return new FlowDemo().run(args);
  }
}
