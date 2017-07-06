
using Toybox.WatchUi as Ui;
using Toybox.Communications as Net;

class BatteryMenuDelegate extends Ui.BehaviorDelegate {
    function initialize() {
        Ui.BehaviorDelegate.initialize();
    }

    function onTap(clickEvent) {
        Net.openWebPage("http://vacancy.new.hr/?utm=garmin", {}, {});
        Ui.popView(Ui.SLIDE_LEFT);
    }

    function onKey(keyEvent) {
        if (4 == keyEvent.getKey()) {
        	 Ui.popView(Ui.SLIDE_LEFT);
        }
    }
}