package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import com.jk.controls.DockMenu;
	import flash.display.StageQuality;
	import flash.display.StageAlign;
	import flash.display.GradientType;
	import flash.geom.Matrix;
	import flash.display.Shape;
    
    /**
     * ...
     * @author Juan Carlos Pazmiño
     */
    public class Main extends Sprite
    {
        
        public function Main()
        {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }
        
        private function init(e:Event = null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
			createDockMenu();
        }
    
		public var dockMenu:DockMenu;
		
		private function addIcon(icon:Object, caption:String, init:Function = null):void
		{
			var iconInfo:Object = new Object();
			iconInfo.icon = icon;
			iconInfo.caption = caption;
			if (init != null) {
				init(iconInfo);
			}
			dockMenu.dataProvider.addItem(iconInfo);
		}
		
		private function createDockMenu():void{
			stage.quality = StageQuality.BEST;
			stage.align = StageAlign.TOP_LEFT;
			
			dockMenu = new DockMenu();
			dockMenu.showReflection = true;
			dockMenu.cacheIcons = true;
			
			addIcon(MacClockIcon, "Clock", function (info:Object):void { info.cacheIcon = false; });
			addIcon(MacOSIcon, "Finder");
			addIcon(MacCalculatorIcon, "Calculator");
			addIcon(MacTextEditIcon, "TextEdit");
			addIcon(FlashIcon, "Flash");
			addIcon(FireworksIcon, "Fireworks");
			addIcon(DreamWeaverIcon, "Dreamweaver");
			addIcon(FirefoxIcon, "FireFox");
			addIcon(WordIcon, "Word");
			addIcon(ExcelIcon, "Excel");
			addIcon(PowerPointIcon, "PowerPoint");
			addIcon(MessengerIcon, "MSN Messenger");
			addIcon(IllustratorIcon, "Illustrator");
			addIcon(PhotoshopIcon, "Photoshop");
			addIcon(AcrobatIcon, "Acrobat Reader");
			addIcon(QuicktimeIcon, "Quicktime");
			addIcon(ShowcaseIcon, "Showcase");
			addIcon(MacCalendarIcon, "Calendar");
			addIcon(ToastTitaniumIcon, "Toast Titanium");
			addIcon(ITunesIcon, "iTunes");
			
			var size:Number = 300;
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(size, size, 45, 0, 0);
			
			var sp:Shape = new Shape();
			with(sp.graphics)
			{
				beginGradientFill(GradientType.RADIAL, [0xFFFFFF, 0xFF0000, 0x550000],
					[1, 1, 1], [0, 0x30, 0xFF], matrix, "pad", "rgb", -0.7);
				drawCircle(size / 2, size / 2, size / 2);
			}
			addIcon(sp, "Graph API Circle");
			
			sp = new Shape();
			with(sp.graphics)
			{
				beginGradientFill(GradientType.RADIAL, [0xFFFFFF, 0x0000DD, 0x000033],
					[1, 1, 1], [0, 0x30, 0xFF], matrix, "pad", "rgb", -0.7);
				drawRoundRect(0, 0, size, size, size * 0.20);
			}
			addIcon(sp, "Graph API Rect");
			
			addChild(dockMenu);
		}
	}
}