public class Vui.Widget.Dialog : Vui.Impl.Subclass<Adw.Dialog> {

    public int[] content_size {
        set {
            widget.content_width = value[0];
            widget.content_height = value[1];
        }
    }

    public bool follows_content_size {
        set {
            widget.follows_content_size = value;
        }
    }

    public Gtk.Widget content {
        set {
            widget.set_child (value);
        }
    }

    public Dialog () {
        widget = new Adw.Dialog () {
            content_width = 600,
            content_height = 550
        };
        widget.present (Vui.Widget.App.window);
    }
}
