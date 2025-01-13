protected class Vui.Widget.Box : Gtk.Box, Vui.Impl.Logistics {

    public override string title {
        set; get; default = null;
    }

    public override Vui.Impl.Subclass[] destination {
        set; get; default = null;
    }
    protected Vui.Impl.Subclass[] concatenate_arrays (Vui.Impl.Subclass[] array1, Vui.Impl.Subclass[] array2) {
        Vui.Impl.Subclass[] combined_array = new Vui.Impl.Subclass[array1.length + array2.length];

        for (int i = 0; i < array1.length; i++) {
            combined_array[i] = array1[i];
        }

        for (int i = 0; i < array2.length; i++) {
            combined_array[array1.length + i] = array2[i];
        }

        return combined_array;
    }

    public Gtk.Widget[] content {
        set {
            foreach (Gtk.Widget child in value) {

                Vui.Impl.Logistics b = (child is  Vui.Impl.Logistics) ? (Vui.Impl.Logistics) child : null;
                if (b != null && b.destination != null)
                    this.destination = concatenate_arrays (this.destination, b.destination);

                this.append (child);
            }
        }
    }
}

public class Vui.Widget.HBox : Vui.Widget.Box {
    public HBox () {
        Object (orientation: Gtk.Orientation.HORIZONTAL, spacing: 0);
    }
}

public class Vui.Widget.VBox : Vui.Widget.Box {
    public VBox () {
        Object (orientation: Gtk.Orientation.VERTICAL, spacing: 0);
    }
}
