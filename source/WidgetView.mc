using Toybox.WatchUi  as Ui;
using Toybox.System   as Sys;
using Toybox.Graphics as Gfx;

class WidgetView extends Ui.View {

	private var pb;
	private var title = "";
	private var status = "";
	private var hours = ""; 
	private var colorsteps = [
		0xAA0000, // 0  -  10
		0xFF0000, // 10 -  20
		0xFF5500, // 20 -  30
		0xFFAA00, // 30 -  40
		0x00AA00, // 40 -  50
		0x00AA00, // 50 -  60
		0x00FF00, // 60 -  70
		0x00FF00, // 70 -  80
		0x00FF00, // 80 -  90
		0x00FF00  // 90 - 100
	];

    function initialize() {
        View.initialize();
        pb = new Rez.Drawables.Battery();        
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        title = new Ui.Text({
            :text  =>"Battery",
            :color => Gfx.COLOR_WHITE,
            :font  => Gfx.FONT_SMALL,
            :locX  => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY  => 10
        });
        status = new Ui.Text({
            :text  =>"100%",
            :color => Gfx.COLOR_WHITE,
            :font  => Gfx.FONT_NUMBER_HOT,
            :locX  => Ui.LAYOUT_HALIGN_CENTER,
            :locY  => 40
        });
        hours = new Ui.Text({
            :text  =>"1050h",
            :color => Gfx.COLOR_WHITE,
            :font  => Gfx.FONT_SMALL,
            :locX  => Ui.LAYOUT_HALIGN_CENTER,
            :locY  => 150
        });
    }
	
    // Update the view
    function onUpdate(dc) {
 		Sys.println("RequestUpdate");
    
        // Call the parent onUpdate function to redraw the layout
        var dev = Sys.getDeviceSettings(); 
    	var stat = Sys.getSystemStats();
    	var bats = stat.battery;
//* debug */ bats = 100;

		// Draw battery.
        pb.draw(dc);
        title.draw(dc);        

        status.setText(bats.format("%.0f")+"%");
        status.draw(dc);
        
        //hours.draw(dc);

		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);	
        
        for (var i = 10, iter = 0; iter < bats; iter+=i) { 
        	var width = i;
        	
        	if ((bats-iter) < i) {
        		width = (bats-iter);
        	}
            
            var color = colorsteps[iter/10];
			
			dc.setColor(color,color);
			dc.fillRoundedRectangle(i+iter*1.28,103, width, 34, 3);
		}
    }

}
