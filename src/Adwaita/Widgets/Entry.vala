namespace Vui.Widget {

    public class Section : Vui.Widget.VBox {
        private Gtk.ListBox box_list;

        public new EntryCommon[] content {
            set {
                foreach (var entry in value) {
                    var click_controller = new Gtk.GestureClick ();
                    var focus_controller = new Gtk.EventControllerFocus ();

                    var row = new Gtk.ListBoxRow () {
                        child = entry,
                        focusable = false,
                    };

                    // on click focus will move to entry
                    entry.add_controller (click_controller);
                    click_controller.pressed.connect (() => entry.widget.focus (Gtk.DirectionType.DOWN));

                    // when focus is on entry set row's styles
                    entry.widget.set_can_target (false);
                    entry.widget.add_controller (focus_controller);
                    entry.widget.add_css_class ("vui-section-entry");
                    focus_controller.enter.connect (() => row.add_css_class ("vui-section-row-focused"));
                    focus_controller.leave.connect (() => row.remove_css_class ("vui-section-row-focused"));

                    this.destination = concatenate_arrays (this.destination, entry.destination);
                    this.box_list.append (row);
                }
                Gtk.ListBoxRow first = (Gtk.ListBoxRow) this.box_list.get_first_child ();
                if (value.length > 1) {
                    Gtk.ListBoxRow last = (Gtk.ListBoxRow) this.box_list.get_last_child ();
                    first.add_css_class ("vui-section-row-first");
                    last.add_css_class ("vui-section-row-last");
                } else first.add_css_class ("vui-section-row-solo");
            }
        }

        public Section (string? header = null) {
            this.box_list = new Gtk.ListBox ();
            this.box_list.add_css_class ("vui-section");
            this.box_list.set_selection_mode (Gtk.SelectionMode.NONE);

            if (header != null) {
                this.prepend (new Vui.Widget.Label (header) {
                    css_classes = { "heading", "dimmed-gray" },
                    halign = Gtk.Align.START,
                    margin_bottom = 8,
                    margin_top = 8,
                });
            }

            this.margin_bottom = 8;
            this.valign = Gtk.Align.FILL;
            this.halign = Gtk.Align.FILL;
            this.append (this.box_list);
        }
    }

    public abstract class EntryCommon : Vui.Impl.Subclass<Gtk.Entry> {
        protected Gtk.Box box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10) {
            margin_start = 4,
            margin_end = 8,
            margin_top = 4,
            margin_bottom = 4
        };

        public virtual Vui.Model.Store<string> bind_buffer {
            set {
                widget.changed.connect ((element) => value.state = element.get_text ());
            }
        }

        public virtual Vui.Widget.Button append {
            set {
                value.css_classes = { "flat" };
                value.halign = Gtk.Align.CENTER;
                value.valign = Gtk.Align.CENTER;
                this.box.append (value);
            }
        }

        private EntryCommon (string placeholder) {
            this.widget = new Gtk.Entry () {
                hexpand = true,
                placeholder_text = placeholder
            };

            this.box.append (widget);
            this.child = this.box;
        }
    }

    public class Entry : EntryCommon {
        public Entry (string placeholder) {
            base (placeholder);
        }
    }

    public class Toggle : EntryCommon {
        private Gtk.GestureClick click_controller = new Gtk.GestureClick ();
        private Gtk.Switch toggle = new Gtk.Switch () {
            css_classes = { "flat" },
            halign = Gtk.Align.CENTER,
            valign = Gtk.Align.CENTER
        };

        private void place_controller () {
            this.add_controller (click_controller);
            this.click_controller.pressed.connect (() => {
                toggle.activate ();
                toggle.grab_focus ();
            });
        }

        public Toggle (string placeholder, Vui.Model.Store<bool> state) {
            base (placeholder);
            this.widget.set_can_focus (false);
            this.widget.set_can_target (false);
            this.widget.set_text (placeholder);

            this.place_controller ();
            this.box.append (toggle);

            this.toggle.state_set.connect ((value) => {
                state.state = value;
                return false;
            });
        }
    }
}
