namespace Vui.Widget {

    public class PageLink : Vui.Widget.Button {

        public Gtk.Widget trigger {
            set {
                widget.child = value;
            }
        }

        public PageLink (owned Vui.Impl.Subclass destination) {
            base ();
            widget.css_classes = { "nav_link" };
            this.destination = { destination };

            this.on_click = () => {
                string action_name = @"$(this.destination[0].title)";
                Vui.simple_action_group.activate_action ("nav." + action_name, null);
            };
        }
    }

    public class Navigation : Vui.Impl.Subclass<Adw.NavigationView> {

        protected delegate void navigation_callback (Adw.NavigationView nav);

        public Navigation bind (navigation_callback handle) {
            handle (this.widget);
            return this;
        }

        private void add_action (string action_name, owned navigation_callback handle) {
            var new_action = new SimpleAction ("nav." + action_name, null);
            new_action.activate.connect (() => handle (this.widget));

            Vui.simple_action_group.add_action (new_action);
        }

        public unowned navigation_callback? on_pushed {
            set {
                widget.pushed.connect (() => {
                    value (this.widget);
                });
            }
        }

        public Vui.Impl.Logistics push {
            set {
                var tmp = new Page (value.title) {
                    content = (Gtk.Widget) value
                };
                widget.add (tmp);
                message ("Added page: %s\n", tmp.tag);
            }
        }

        public Vui.Impl.Logistics[] pages {
            set {
                foreach (var item in value) {
                    push = item;
                    foreach (var dest in item.destination) {
                        push = dest;
                        add_action (dest.title, (nav) => {
                            message (@"pushing: $(dest.title)");
                            this.widget.push_by_tag (dest.title);
                        });
                    }
                }
            }
        }

        public Navigation () {
            widget = new Adw.NavigationView () {
                hexpand = true,
                vexpand = true
            };
            this.child = widget;
        }
    }
}
