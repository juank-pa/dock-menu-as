package com.jk.events {
	import flash.events.Event;
	
	/**
	 * A <code>DockMenuEvent</code> object is dispatched in response to user interaction between
	 * the pointing device and the icons. 
	 * <p>There are the types of keyboard events: DockMenuEvent.ICON_CLICK DockMenuEvent.ICON_ROLL_OVER 
	 * and DockMenuEvent.ICON_ROLL_OUT.</p>
	 * 
     * @author Juan Carlos Pazmiño
	 * 
	 * @see #ICON_CLICK
	 * @see #ICON_ROLL_OVER
	 * @see #ICON_ROLL_OUT
	 */
	public class DockMenuEvent extends Event
	{	
		/** 
		 * Defines the value of the  
		 * <code>type</code> property of an <code>iconClick</code> event. 
		 * 
		 * <p>This event has the following properties:</p> 
		 * <table class="innertable"> 
		 * <tr><th>Property</th><th>Value</th></tr>
		 * <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>
		 * <tr><td><code>cancelable</code></td><td><code>true</code>; canceling this event prevents the default link/target 
		 * behavior from running and allows creating a custom behavior programmatically.</td></tr>
		 * <tr><td><code>currentTarget</code></td><td>The object that is actively processing the Event object with an event listener.</td></tr>
		 * <tr><td><code>data</code></td><td>The data of the icon under the pointing device.</td></tr>
		 * <tr><td><code>id</code></td><td>The positional id of the icon under the pointing device.</td></tr>
		 * <tr><td><code>target</code></td><td>The <code>DockMenu</code> instance under the pointing device. 
		 * The target is not always the object in the display list that registered the event listener. 
		 * Use the currentTarget property to access the object in the display list that is currently processing the event.</td></tr>
		 * </table> 
		 * 
		 * @eventType iconClick
		 * 
		 * @see com.jk.controls.DockMenu#event:iconClick
		 */ 
		public static const ICON_CLICK:String = "iconClick";

		/** 
		 * Defines the value of the  
		 * <code>type</code> property of an <code>iconRollOver</code> event. 
		 * 
		 * <p>This event has the following properties:</p> 
		 * <table class="innertable"> 
		 * <tr><th>Property</th><th>Value</th></tr>
		 * <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>
		 * <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>
		 * <tr><td><code>currentTarget</code></td><td>The object that is actively processing the Event object with an event listener.</td></tr>
		 * <tr><td><code>data</code></td><td>The data of the icon under the pointing device.</td></tr>
		 * <tr><td><code>id</code></td><td>The positional id of the icon under the pointing device.</td></tr>
		 * <tr><td><code>target</code></td><td>The <code>DockMenu</code> instance under the pointing device. 
		 * The target is not always the object in the display list that registered the event listener. 
		 * Use the currentTarget property to access the object in the display list that is currently processing the event.</td></tr>
		 * </table> 
		 * 
		 * @eventType iconRollOver 
		 * 
		 * @see com.jk.controls.DockMenu#event:iconRollOver
		 */ 
		public static const ICON_ROLL_OVER:String = "iconRollOver";

		/** 
		 * Defines the value of the  
		 * <code>type</code> property of an <code>iconRollOut</code> event. 
		 * 
		 * <p>This event has the following properties:</p> 
		 * <table class="innertable"> 
		 * <tr><th>Property</th><th>Value</th></tr>
		 * <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>
		 * <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default behavior to cancel.</td></tr>
		 * <tr><td><code>currentTarget</code></td><td>The object that is actively processing the Event object with an event listener.</td></tr>
		 * <tr><td><code>data</code></td><td>The data of the icon under the pointing device.</td></tr>
		 * <tr><td><code>id</code></td><td>The positional id of the icon under the pointing device.</td></tr>
		 * <tr><td><code>target</code></td><td>The <code>DockMenu</code> instance under the pointing device. 
		 * The target is not always the object in the display list that registered the event listener. 
		 * Use the currentTarget property to access the object in the display list that is currently processing the event.</td></tr>
		 * </table> 
		 * 
		 * @eventType iconRollOut 
		 * 
		 * @see com.jk.controls.DockMenu#event:iconRollOut
		 */ 
		public static const ICON_ROLL_OUT:String = "iconRollOut";
		
		private var _id:int = -1;
		private var _data:Object = null;
		
		/**
		 * Creates an Event object that contains specific information about <code>DockMenu</code> events. 
		 * Event objects are passed as parameters to event listeners.
		 * 
		 * @param type The type of the event. Possible values are: <code>DockMenu.ICON_CLICK</code>, 
		 * <code>DockMenu.ICON_ROLL_OVER</code> and <code>DockMenu.ICON_ROLL_OUT</code>
		 * @param id The positional id of the icon under the pointing device.
		 * @param data The data of the icon under the pointing device.
		 * @param cancelable Determines whether the Event object can be canceled.
		 * 
		 * @see #ICON_CLICK
		 * @see #ICON_ROLL_OUT
		 * @see #ICON_ROLL_OVER
		 */
		public function DockMenuEvent(type:String,
									  id:int=-1, data:Object=null,
									  cancelable:Boolean=false):void
		{
			super(type, false, cancelable);
			_id = id;
			
			if(data)
			{
				_data = data;
			}
		}
		
		/**
		 * Specifies the positional index of the icon undex the pointing device (begins with zero).
		 */
		public function get id():int 
		{
			return _id;
		}
		
		/**
		 * Contains the data of the icon under the pointing device.
		 */
		public function get data():Object 
		{
			return _data;
		}
		
		/**
		 * Creates a copy of the DockMenuEvent object and sets the value of each property to match that of the original.
		 */
		override public function clone():Event
		{
			return new DockMenuEvent(type, id, data, cancelable);
		}
		
		/**
		 * Returns a string that contains all the properties of the KeyboardEvent object. The string is in the following format: 
		 * <p><code>[DockMenuEvent type=<em>value</em> bubbles=<em>value</em> cancelable=<em>value</em> ... data=<em>value</em>]</code></p>
		 * 
		 * @return A string that contains all the properties of the DockMenuEvent object.
		 */
		override public function toString():String 
		{
			return formatToString("DockMenuEvent", "type", "cancelable", "id", "data");
		}
	}
}
