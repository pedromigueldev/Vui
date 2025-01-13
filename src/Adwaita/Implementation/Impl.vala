namespace Vui.Impl {

    private void BoubleDestination (Gtk.Widget value, Logistics parent) {
        Logistics b = (value is  Logistics) ? (Logistics) value : null;
        if (b != null && b.destination != null)
            parent.destination = b.destination;
    }

    protected interface Logistics : GLib.Object {
        public abstract string title {
            set; get; default = null;
        }
        public abstract Subclass[] destination {
            set; get; default = null;
        }
    }

    public abstract class Derived : Subclass<Gtk.Widget> {
        public Gtk.Widget derived {
            set {
                widget = value;
                this.child = widget;

                Logistics b = (Logistics) value;
                if (b != null) {
                    this.destination = b.destination;
                    this.title = b.title;
                }
            }
        }
    }

    public abstract class Subclass<G>: Adw.Bin, Logistics {

        public virtual G widget { get; set; }

        public virtual Gtk.Widget gtk_widget {
            get { return (Gtk.Widget) widget; }
            set { widget = value; }
        }

        public override string title {
            set; get; default = null;
        }

        public override Subclass[] destination {
            set; get; default = null;
        }

        public new bool vexpand {
            get { return gtk_widget.get_vexpand (); }
            set {

                this.set_vexpand (value);
                gtk_widget.set_vexpand (value);
            }
        }

        public new bool hexpand {
            get { return gtk_widget.get_hexpand (); }
            set {
                this.set_hexpand (value);
                gtk_widget.set_hexpand (value);
            }
        }

        public new Gtk.Align valign {
            get { return gtk_widget.valign; }
            set {
                this.set_valign (value);
                gtk_widget.set_valign (value);
            }
        }

        public new Gtk.Align halign {
            get { return gtk_widget.halign; }
            set {
                this.set_halign (value);
                gtk_widget.set_halign (value);
            }
        }

        public new int margin_top {
            get { return gtk_widget.margin_top; }
            set { gtk_widget.margin_top = value; }
        }

        public new int margin_start {
            get { return gtk_widget.margin_start; }
            set { gtk_widget.margin_start = value; }
        }

        public new int margin_bottom {
            get { return gtk_widget.margin_bottom; }
            set { gtk_widget.margin_bottom = value; }
        }

        public new int margin_end {
            get { return gtk_widget.margin_end; }
            set { gtk_widget.margin_end = value; }
        }

        public new string[] css_classes {
            set {
                foreach (var item in value) {
                    gtk_widget.add_css_class (item);
                }
            }
        }

        public new int height_request {
            get { return gtk_widget.height_request; }
            set { gtk_widget.height_request = value; }
        }
    }
}
