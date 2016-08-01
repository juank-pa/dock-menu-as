package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	public class MacClockIcon extends Sprite {
		private static const dayNames:Array = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
		
		private var timer:Timer;
		
		private var _view:MovieClip;
		
		public function MacClockIcon():void{
			timer = new Timer(500, 0);
			_view = new MacClock();
			addChild(_view);
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
			
			_view.hour_txt.text = hour.toString();
			_view.min_txt.text = (now.minutes < 10? "0" : "") + now.minutes;
			_view.colon_mc.visible = !_view.colon_mc.visible;
			_view.day_txt.text = dayNames[now.day];
			_view.ampm_txt.text = (now.hours >= 12? "PM" : "AM");
		}
	}
}