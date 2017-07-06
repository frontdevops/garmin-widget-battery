
using Toybox.WatchUi  as Ui;
using Toybox.System   as Sys;


class BatteryDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        Ui.BehaviorDelegate.initialize();
    }
/*
    function onTap(clickEvent) {
        //System.println(clickEvent.getCoordinates()); // e.g. [36, 40]
        //System.println(clickEvent.getType());        // CLICK_TYPE_TAP = 0
    }
//*/
    function onKey(keyEvent) {
        //System.println(keyEvent.getKey()); // e.g. KEY_MENU = 7
 		switch (keyEvent.getKey()) {
 			case 4:
 			case 7:
 				showAboutScreen();
 				break;
 		}       
    }

	function showAboutScreen() {
        Ui.pushView(
        	new BatteryMenuView(),
        	new BatteryMenuDelegate(),
        	Ui.SLIDE_RIGHT
		);
	}
}