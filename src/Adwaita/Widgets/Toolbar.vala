
public class Vui.Widget.ToolBar : Vui.Impl.Subclass<Adw.ToolbarView> {

    private Vui.Widget.Box content_box;
    private Vui.Widget.Box title_page_box;

    public Gtk.Widget top_bar {
        set {
            Vui.Impl.BoubleDestination (value, this);
            widget.add_top_bar (value);
        }
    }

    public Gtk.Widget bottom_bar {
        set {
            Vui.Impl.BoubleDestination (value, this);
            widget.add_bottom_bar (value);
        }
    }

    public Gtk.Widget content {
        set {
            Vui.Impl.BoubleDestination (value, this);
            content_box.append (value);
        }
    }

    public Gtk.Widget[] title_append {
        set {
            foreach (var item in value) {
                item.set_halign (Gtk.Align.END);
                this.title_page_box.append (item);
            }
        }
    }

    public string title_page {
        set {
            this.title = value;

            title_page_box = new HBox () {
                margin_bottom = 10,
                spacing = 10,
                content = {
                    new Label (value) {
                        css_classes = { "title-1", "title-bigger" },
                        halign = Gtk.Align.START,
                        valign = Gtk.Align.CENTER,
                    },
                    new Vui.Widget.HSpacer ()
                }
            };
            this.content_box.prepend (title_page_box);
        }
    }

    public new int margin_top {
        get { return this.content_box.margin_top; }
        set { this.content_box.margin_top = value; }
    }

    public new int margin_start {
        get { return this.content_box.margin_start; }
        set { this.content_box.margin_start = value; }
    }

    public new int margin_bottom {
        get { return this.content_box.margin_bottom; }
        set { this.content_box.margin_bottom = value; }
    }

    public new int margin_end {
        get { return this.content_box.margin_end; }
        set { this.content_box.margin_end = value; }
    }

    public ToolBar () {
        widget = new Adw.ToolbarView ();
        content_box = new VBox () {

            valign = Gtk.Align.FILL,
            halign = Gtk.Align.FILL,
        };
        widget.set_content (content_box);
        this.child = widget;
    }
}
