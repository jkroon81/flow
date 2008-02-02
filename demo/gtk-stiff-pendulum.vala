using Gtk;
using Cairo;
using Flow;

class GtkStiffPendulum : Window {
  Widget darea;
  ODE ode;
  Integrator integrator;
  double x;
  double y;

  construct {
    title = "Stiff Pendulum";
    delete_event += Gtk.main_quit;

    darea = new DrawingArea();
    darea.set_size_request(400, 400);
    darea.expose_event += (darea, foo) => {
      expose_cb();
    };

    add(darea);
    show_all();

    GLib.Timeout.add(50, refresh_cb, this);

    integrator = new Integrator();
    integrator.step_method = new Dopri();
    integrator.ode = new StiffPendulum();
  }

  void refresh_cb() {
    integrator.ode.t_start = integrator.ode.t_stop;
    integrator.ode.t_stop = integrator.ode.t_start + 0.05;
    integrator.run();
    x = integrator.ode.x.get_data()[0];
    y = integrator.ode.x.get_data()[1];
    darea.queue_draw();
  }

  void expose_cb() {
    var cr = Gdk.cairo_create(darea.window);
    cr.set_line_width(1.0 / 400.0);
    cr.scale(400.0, 400.0);
    cr.translate(0.5, 0.3);
    cr.scale(0.4, -0.4);

    /* Draw spring */
    cr.arc(0.0, 0.0, 0.025, 0.0, 6.28);
    cr.stroke();
    cr.move_to(0.0, 0.0);
    cr.line_to(x, y);
    cr.stroke();
    /* Draw ball */
    cr.arc(x, y, 0.05, 0.0, 6.28);
    cr.fill();
  }

  public static int main(string[] args) {
    Gtk.init(ref args);
    new GtkStiffPendulum();
    Gtk.main();
    return 0;
  }
}
