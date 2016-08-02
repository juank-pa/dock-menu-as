package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	public class MacClock extends MovieClip{
		private static const dayNames:Array = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
		
		private var timer:Timer;
		
		public var hour_txt:TextField;
		public var min_txt:TextField;
		public var day_txt:TextField;
		public var ampm_txt:TextField;
		
		public var colon_mc:Sprite;
		
		public function MacClock():void{
			timer = new Timer(500, 0);
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler(event:Event):void{
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			timer.start();
			timer.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
		}
		
		private function removedFromStageHandler(event:Event):void{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			timer.removeEventListener(TimerEvent.TIMER, timerHandler);
			timer.stop();
		}
		
		private function timerHandler(event:TimerEvent):void{
			var now:Date = new Date();
			var hour:Number = now.hours;
			hour = (hour == 0 || hour == 12? 12 : hour % 12);
			
			hour_txt.text = hour.toString();
			min_txt.text = (now.minutes < 10? "0" : "") + now.minutes;
			colon_mc.visible = !colon_mc.visible;
			day_txt.text = dayNames[now.day];
			ampm_txt.text = (now.hours >= 12? "PM" : "AM");
		}
	}
}