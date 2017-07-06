
using Toybox.WatchUi  as Ui;
using Toybox.System   as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Timer;

class BatteryView extends Ui.View {

	private var timer,
				step = 0;

	private var screenCenterH = 0,
				screenCenterV = 0,
				posx        = 0,
				posy        = 0;

	private var title   = "",
				status  = "",
				model = "???";

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
        timer = new Timer.Timer();
    }

    // Load your resources here
    function onLayout(dc) {
        screenCenterH = (dc.getHeight() /2);
        screenCenterV = (dc.getWidth() /2 );
/*
		var deviceSettings = Sys.getDeviceSettings();
		var partNumber = deviceSettings.partNumber;
		Sys.println("debug:");
		Sys.println(partNumber);
//*/		
		model = Ui.loadResource(Rez.Strings.DeviceModel);
		switch (model) {
			case "fenix5":
			case "fenix5s":
			case "fenix5x":
			case "fenixchronos":
		        posx = screenCenterH -65;
        		posy = screenCenterV;
				break;

			case "fr935":
		        posx = screenCenterH -70;
        		posy = screenCenterV;
				break;

			case "fr735xt":
		        posx = screenCenterH -50;
        		posy = screenCenterV -10;
				break;

			case "edge820":
		        posx = screenCenterH -75;
        		posy = screenCenterV +10;
				break;

			case "edge_520":
		        posx = screenCenterH -95;
        		posy = screenCenterV +20;
				break;
			
			case "oregon7xx":
			case "rino7xx":
			case "edge_1000":		
		        posx = screenCenterH -120;
        		posy = screenCenterV +50;
				break;

			case "vivoactivehr":
			default:
		        posx = screenCenterH -97;
        		posy = screenCenterV +26;
		}
          
       	timer.start(method(:timerCtrl), 800, true);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        title = new Ui.Text({
            :text  => "Battery",
            :color => Gfx.COLOR_WHITE,
            :font  => Gfx.FONT_SMALL,
            :locX  => WatchUi.LAYOUT_HALIGN_CENTER,
            :locY  => 1
        });
        status = new Ui.Text({
            :text  => "100%",
            :color => Gfx.COLOR_WHITE,
            :font  => Gfx.FONT_NUMBER_HOT,
            :locX  => Ui.LAYOUT_HALIGN_CENTER,
            :locY  => posy -60
        });
    }
    
    function timerCtrl() {
    	step = step == 0 ? 1 : 0;    
        Ui.requestUpdate();
    }
	
    // Update the view
    function onUpdate(dc) {
    	var charge = Sys.getSystemStats().battery;
//* debug */ charge = 92;

		dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
		dc.clear();

        title.draw(dc);
        status.setText(charge.format("%.0f")+"%");
        status.draw(dc);
        
        // For debug
        //dc.drawText(1, 20, Gfx.FONT_SMALL, model, Gfx.TEXT_JUSTIFY_LEFT);

		// Draw battery.
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		//dc.drawRoundedRectangle(x, y, width, height, radius)
        dc.drawRoundedRectangle(posx, posy, 134, 40, 3);
        dc.fillRoundedRectangle(posx +129, posy +10,  10, 20, 3);
        
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        dc.fillRectangle(posx +123, posy +10,  10, 20);
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);

    	var i = 10; // Magic :)
    	charge = charge -(step *i);
        for (var iter = 0; iter < charge; iter +=i)
		{
        	var width = i;
        	if (charge -iter < i) {
        		width = charge -iter;
        	}

            var color = colorsteps[iter/10];			
			dc.setColor(color,color);
			dc.fillRoundedRectangle(
				(posx -7) +i +iter *1.28,
				posy +3,
				width, 34, 3
			);
		}
    }

}
