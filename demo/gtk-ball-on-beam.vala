using Gdk;
using Gtk;
using Cairo;
using Flow;

class GtkBallOnBeam : Gtk.Window {
  Widget vbox;
  Widget darea;
  Widget slider;
  Timer timer;
  Integrator integrator;
  double[] u;
  double angle;
  double pos;
  const double BALL_RADIUS = 0.02;
  const double BEAM_LENGTH = 0.6;
  const double BEAM_HEIGHT = 0.02;
  const double BOX_WIDTH = 0.5;
  const double BOX_HEIGHT = 0.3;

  construct {
    title = "Ball On Beam";
    set_default_size(400, 400);
    destroy += Gtk.main_quit;

    darea = new DrawingArea();
    darea.expose_event += expose_cb;

    slider = new HScale.with_range(-0.8 * BEAM_LENGTH / 2, 0.8 * BEAM_LENGTH / 2, BEAM_LENGTH / 10);
    ((Range)slider).set_value(0.0);

    vbox = new VBox(false, 0);
    ((VBox)vbox).pack_start(darea, true, true, 0);
    ((VBox)vbox).pack_end(slider, false, false, 0);

    add(vbox);
    show_all();

    Timeout.add(1000 / 25, refresh_cb);

    integrator = new Integrator();
    integrator.step_method = new Dopri();
    integrator.ode = new BallOnBeam();
    integrator.ode.t_stop = 0.0;

    timer = new Timer();
    timer.start();

    u = new double[1];
  }

  bool refresh_cb() {
    u[0] = ((Range)slider).get_value();
    integrator.ode.t_start = integrator.ode.t_stop;
    integrator.ode.t_stop = timer.elapsed();
    integrator.ode.u.set_from_array(1, u);
    integrator.run();
    pos = integrator.ode.x.data[3];
    angle = integrator.ode.x.data[0];
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
    cr.translate(0.5, 0.5);

    /* Draw Box */
    cr.rectangle(-BOX_WIDTH / 2, -BOX_HEIGHT / 2, BOX_WIDTH, BOX_HEIGHT);
    cr.set_source_rgb(0.5, 0.5, 1.0);
    cr.fill_preserve();
    cr.set_source_rgb(0.5, 0.5, 0.6);
    cr.stroke();

    /* Draw beam */
    cr.rotate(-angle);
    cr.translate(0.0, BEAM_HEIGHT);
    cr.set_source_rgb(0.0, 1.0, 0.0);
    cr.rectangle(-BEAM_LENGTH / 2, 0.0, BEAM_LENGTH, BEAM_HEIGHT);
    cr.fill_preserve();
    cr.set_source_rgb(0.0, 0.5, 0.0);
    cr.stroke();

    /* Draw ball */
    cr.translate(pos, -BALL_RADIUS);
    cr.arc(0.0, 0.0, BALL_RADIUS, 0.0, 6.28);
    cr.set_source_rgb(0.3, 0.3, 0.3);
    cr.fill_preserve();
    cr.set_source_rgb(0.0, 0.0, 0.0);
    cr.stroke();

    return false;
  }
}

int main(string[] args) {
  Gtk.init(ref args);
  new GtkBallOnBeam();
  Gtk.main();
  return 0;
}
