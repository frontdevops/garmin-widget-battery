
using Toybox.WatchUi  as Ui;
using Toybox.Graphics as Gfx;
//using Toybox.System   as Sys;


class BatteryMenuView extends Ui.View {

    function initialize() {
    	//Sys.println("initialize");
        View.initialize();
    }
	
    function onLayout(dc) {
    	//Sys.println("onLayout");

       	var message = new Ui.Text({
            :text  =>	"Created in New.HR\n"+
            			"Need a job?\n" +
            			"vacancy.new.hr",
            :color => Gfx.COLOR_WHITE,
            :font  => Gfx.FONT_SMALL,
            :locX  => Ui.LAYOUT_HALIGN_CENTER,
            :locY  => Ui.LAYOUT_VALIGN_CENTER
        });

 		dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
		dc.clear();

    	message.draw(dc);    
    }
    
    function onUpdate(dc){}
}
