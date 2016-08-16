using Toybox.Ant as Ant;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class PongMenuDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :item_1) {
            Sys.println("Host");
            Ui.switchToView(new GameView(), new GameDelegate(), Ui.SLIDE_RIGHT);
        } else if (item == :item_2) {
            Sys.println("Join");
        }
    }

}