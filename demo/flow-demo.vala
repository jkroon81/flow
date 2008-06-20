using GLib;

enum Flags {
  NONE        = 0,
  PRINT_STATS = 1 << 0,
  UNIFORM     = 1 << 1,
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
    Flow.StepMethod step_method;
    Flags flags;
    int ode_id;
    int i;

    ode = new FlowDemoODE[] {
      new BallOnBeam(),
      new Constant(),
      new LinearTestEquation(),
      new Lorentz(),
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
      if(args[i] == "--stats")
        flags |= Flags.PRINT_STATS;
      else if(args[i] == "--uniform")
        flags |= Flags.UNIFORM;
      else if(args[i] == "--method") {
        i++;
        if(args[i] == "euler")
          step_method = new Flow.Euler();
        else if(args[i] == "dopri")
          step_method = new Flow.Dopri();
      } else {
        print_help();
        return 0;
      }

    integrator = new Flow.Integrator();
    integrator.uniform_sampling = (flags & Flags.UNIFORM) != 0;
    integrator.step_method = step_method != null ? step_method : new Flow.Dopri();
    integrator.ode = ode[ode_id - 1];
    integrator.sample += (integrator, ode) => {
      int i;

      for(i = 0; i < ode.x.size; i++)
        stdout.printf("x%d = %f, ", i, ode.x.get_data()[i]);
      stdout.printf("t = %f\n", ode.t);
    };
    integrator.run();

    if ((flags & Flags.PRINT_STATS) != 0) {
      stdout.printf("%u F-evaluations\n", ode[ode_id - 1].n_f_evals);
      stdout.printf("%u successful steps\n", integrator.n_successful_steps);
      stdout.printf("%u failed steps\n", integrator.n_failed_steps);
    }

    return 0;
  }

  public static int main(string[] args) {
    return new FlowDemo().run(args);
  }
}
