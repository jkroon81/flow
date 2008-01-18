using Gtk;
using Cairo;
using Flow;

class GtkBallOnBeam : Window {
  Widget vbox;
  Widget darea;
  Widget slider;
  ODE ode;
  Integrator integrator;
  double[] u;
  double angle;
  double pos;
  float BALL_RADIUS = 0.02;
  float BEAM_LENGTH = 0.6;
  float BEAM_HEIGHT = 0.02;
  float BOX_WIDTH = 0.5;
  float BOX_HEIGHT = 0.3;

  construct {
    title = "Ball On Beam";
    delete_event += Gtk.main_quit;

    darea = new DrawingArea();
    darea.set_size_request(400, 400);
    darea.expose_event += (darea, foo) => {
      expose_cb();
    };

    slider = new HScale.with_range(-0.8 * BEAM_LENGTH / 2, 0.8 * BEAM_LENGTH / 2, BEAM_LENGTH / 10);
    ((Range)slider).set_value(0.0);

    vbox = new VBox(false, 0);
    ((VBox)vbox).pack_start(darea, true, true, 0);
    ((VBox)vbox).pack_end(slider, false, false, 0);

    add(vbox);
    show_all();

    GLib.Timeout.add(50, refresh_cb, this);

    integrator = new Integrator();
    integrator.step_method = new Euler();
    integrator.ode = new BallOnBeam();

    u = new double[1];
  }

  void refresh_cb() {
    u[0] = ((Range)slider).get_value();
    integrator.ode.t_start = integrator.ode.t_stop;
    integrator.ode.t_stop = integrator.ode.t_start + 0.05;
    integrator.ode.u.set(1, u);
    integrator.run();
    pos = integrator.ode.x.get()[3];
    angle = integrator.ode.x.get()[0];
    darea.queue_draw();
  }

  void expose_cb() {
    var cr = Gdk.cairo_create(darea.window);
    cr.set_line_width(1.0 / 400.0);
    cr.scale(400.0, 400.0);
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
  }

  public static int main(string[] args) {
    Gtk.init(ref args);
    new GtkBallOnBeam();
    Gtk.main();
    return 0;
  }
}
