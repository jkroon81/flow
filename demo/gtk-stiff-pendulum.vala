using Gdk;
using Gtk;
using Cairo;
using Flow;

class GtkStiffPendulum : Gtk.Window {
  Widget darea;
  Timer timer;
  Integrator integrator;
  double x;
  double y;

  construct {
    title = "Stiff Pendulum";
    set_default_size(400, 400);
    destroy.connect(Gtk.main_quit);

    darea = new DrawingArea();
    darea.expose_event.connect(expose_cb);

    add(darea);
    show_all();

    Timeout.add(1000 / 25, refresh_cb);

    integrator = new Integrator();
    integrator.step_method = new Dopri();
    integrator.ode = new StiffPendulum();
    integrator.ode.t_stop = 0.0;

    timer = new Timer();
    timer.start();
  }

  bool refresh_cb() {
    integrator.ode.t_start = integrator.ode.t_stop;
    integrator.ode.t_stop = timer.elapsed();
    integrator.run();
    x = integrator.ode.x.data[0];
    y = integrator.ode.x.data[1];
    darea.queue_draw();
    return true;
  }

  bool expose_cb(Widget widget, EventExpose e) {
    DrawingArea darea;
    int width, height;

    darea = (DrawingArea) widget;
    darea.window.get_size(out width, out height);
    var cr = Gdk.cairo_create(darea.window);
    cr.rectangle(e.area.x, e.area.y, e.area.width, e.area.height);
    cr.clip();
    cr.set_line_width(1.0 / width);
    cr.scale(width, height);
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

    return false;
  }
}

int main(string[] args) {
  Gtk.init(ref args);
  new GtkStiffPendulum();
  Gtk.main();
  return 0;
}
