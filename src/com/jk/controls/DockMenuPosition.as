package com.jk.controls
{
	import com.jk.controls.DockMenu;
	
	/**
	 * A class that provides constant values for <code>DockMenu</code> bar position property. 
     * @author Juan Carlos Pazmiño
	 * 
	 * @see DockMenu#position
	 */
	public class DockMenuPosition
	{
		private static const positionHash:Object = {
													  top:1,
													  bottom:1,
													  left:1,
													  right:1
												   };
		
		// Dock positions allowed
		
		/**
		 * Places the <code>DockMenu</code> bar centered at the top of the screen or container clip (<code>DisplayObjectContainer</code>).
		 */
		public static const TOP:String = "top";
		
		/**
		 * Places the <code>DockMenu</code> bar centered at the bottom of the screen or container clip (<code>DisplayObjectContainer</code>).
		 */
		public static const BOTTOM:String = "bottom";
		
		/**
		 * Places the <code>DockMenu</code> bar centered to the left side of the screen or container clip (<code>DisplayObjectContainer</code>).
		 */
		public static const LEFT:String = "left";
		
		/**
		 * Places the <code>DockMenu</code> bar centered to the right side of the screen or container clip (<code>DisplayObjectContainer</code>).
		 */
		public static const RIGHT:String = "right";
		
		// Namespaces used for position calculations
		private namespace VerticalNS;
		private namespace HorizontalNS;
		
		// Default namespace is horizontal
		private var ns:Namespace = VerticalNS;
		
		// Names used as X properties when the bar is vertical
		/**
		* @private
		*/
		static VerticalNS const _xNames:Array = ["x","X","width","Width"];
		// Names used as Y properties when the bar is vertical
		/**
		 * @private
		 */
		static VerticalNS const _yNames:Array = ["y","Y","height","Height"];
		
		// Names used as X properties when the bar is horizontal
		/**
		 * @private
		 */
		static HorizontalNS const _xNames:Array = VerticalNS::_yNames;
		// Names used as Y properties when the bar is horizontal
		/**
		 * @private
		 */
		static HorizontalNS const _yNames:Array = VerticalNS::_xNames;
				
		// Current position
		private var _position:String = "bottom";
		
		/**
		 * Gets the X property name depending on the position namespace.
		 * Used internally only to make bar positioning and sizing easier.
		 * 
		 * @param lower If true it returns the property name in lower case.
		 * @return "x" or "X" if horizontal and "y" or "Y" for vertical.
		 * 
		 * @private
		 */
		public function getXName(lower:Boolean = true):String
		{
			return lower? ns::_xNames[0] : ns::_xNames[1];
		}
		
		/**
		 * Gets the Y property name depending on the position namespace
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param lower If true it returns the property name in lower case.
		 * @return "y" or "Y" if horizontal and "x" or "X" for vertical.
		 * 
		 * @private
		 */
		public function getYName(lower :Boolean = true):String
		{
			return lower? ns::_yNames[0] : ns::_yNames[1];
		}
		
		/**
		 * Gets the Width property name depending on the position namespace
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param lower If true it returns the property name in lower case.
		 * @return "width" or "Width" if horizontal and "height" or "Height" for vertical.
		 * 
		 * @private
		 */
		public function getWidthName(lower:Boolean = true):String
		{
			return lower? ns::_xNames[2] : ns::_xNames[3];
		}
		
		/**
		 * Gets the Height property name depending on the position namespace
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param lower If true it returns the property name in lower case.
		 * @return "height" or "Height" if horizontal and "width" or "Width" for vertical.
		 * 
		 * @private
		 */
		public function getHeightName(lower:Boolean = true):String
		{
			return lower? ns::_yNames[2] : ns::_yNames[3];
		}
		
		/**
		 * Creates a new position instance (used internally only)
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param ns Namespace that allows access to DockMenu internal properties.
		 * 
		 * @private
		 */
		public function DockMenuPosition()
		{
		}
		
		/**
		 * Gets the current position
		 * Used internally only to make bar positioning and sizing easier.
		 * 
		 * @private
		 */
		public function get position():String
		{
			return _position;
		}
		
		/**
		 * Sets the position and the correct positional namespace.
		 * Used internally only to make bar positioning and sizing easier.
		 * 
		 * @private
		 */
		public function set position(val:String):void
		{
			val = val.toLowerCase();
			
			if(isValid(val))
			{
				_position = val;
				
				ns = (_position == "top" || _position == "bottom"? VerticalNS : HorizontalNS);
			}
		}
		
		/**
		 * Determines whether the current position is valid
		 *
		 * @param position Position name.
		 * @return true if valid false if not.
		 */
		private function isValid(position:String):Boolean
		{
			return (positionHash[position] != null);
		}
		
		/**
		 * Determines the bar direction.
		 * Used internally only to make bar positioning and sizing easier.
		 * 
		 * @return true if vertical (LEFT or RIGHT) and false if horizontal (TOP or BOTTOM).
		 * 
		 * @private
		 */
		public function get isVertical():Boolean
		{
			return ns == VerticalNS;
		}
		
		/**
		 * Determines if the position used inverse coordinates (stageWidth - coord.x 
		 * instead of just coord.x)
		 * Used internally only to make bar positioning and sizing easier.
		 * 
		 * return true if inverse (RIGHT or BOTTOM) and false otherwise
		 * 
		 * @private
		 */
		public function get isInverse():Boolean
		{
			return (_position == "right" || _position == "bottom");
		}
		
		/**
		 * Gets the X position depending on the position namespace.
		 * It extracts X if horizontal and Y if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param target Object to extract the X property from.
		 *
		 * @return The X value if horizontal Y if vertical.
		 * 
		 * @private
		 */
		public function getX(target:Object):Number
		{
			return target[getXName()];
		}		
		
		/**
		 * Sets the X position depending on the position namespace.
		 * It sets X if horizontal and Y if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param target Object to set the X property.
		 * @param val The value to set the property.
		 * 
		 * @private
		 */
		public function setX(target:Object, val:Number):void
		{
			target[getXName()] = val;
		}
		
		/**
		 * Gets the Y position depending on the position namespace.
		 * It extracts Y if horizontal and X if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param target Object to extract the Y property from.
		 *
		 * @return The Y value if horizontal Y if vertical.
		 * 
		 * @private
		 */
		public function getY(target:Object):Number
		{
			return target[getYName()];
		}
		
		/**
		 * Sets the Y position depending on the position namespace.
		 * It sets Y if horizontal and X if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param target Object to set the Y property.
		 *
		 * @private
		 */
		public function setY(target:Object, val:Number):void
		{
			target[getYName()] = val;
		}
		
		/**
		 * Gets the Width value depending on the position namespace.
		 * It extracts Width if horizontal and Height if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param target Object to extract the Width property from.
		 *
		 * @return The Width value if horizontal Height if vertical.
		 * 
		 * @private
		 */
		public function getWidth(target:Object):Number
		{
			return target[getWidthName()];
		}
		
		/**
		 * Sets the Width value depending on the position namespace.
		 * It sets Width if horizontal and Height if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param target Object to set the Width property.
		 *
		 * @private
		 */
		public function setWidth(target:Object, val:Number):void
		{
			target[getWidthName()] = val;
		}
		
		/**
		 * Gets the Height value depending on the position namespace.
		 * It extracts Height if horizontal and Width if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param target Object to extract the Height property from.
		 *
		 * @return The Height value if horizontal Width if vertical.
		 * 
		 * @private
		 */
		public function getHeight(target:Object):Number
		{
			return target[getHeightName()];
		}
		
		/**
		 * Sets the Height value depending on the position namespace.
		 * It sets Height if horizontal and Width if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param target Object to set the Height property.
		 *
		 * @private
		 */
		public function setHeight(target:Object, val:Number):void
		{
			target[getHeightName()] = val;
		}
		
		/**
		 * Helper function to get a property value for namespaced <code>DockMenu</code> properties.
		 *
		 * @param prop The base property name.
		 * @param dir The property direction (X, Y, Width, or Height).
		 * @param target Object to get namespaced property from.
		 *
		 * @return The property value.
		 */
		private function getNamespacedProp(prop:String, dir:String, target:Object):Number
		{
			if(target is DockMenu && prop == "offset" || prop == "stage")
			{
				return target[prop + dir];
			}
			return target[prop + dir];
		}
		
		/**
		 * Helper function to set a property value for namespaced <code>DockMenu</code> properties.
		 *
		 * @param prop The base property name.
		 * @param dir The property direction (X, Y, Width, or Height).
		 * @param target Object to set namespaced property.
		 * @param val The value to set the target to.
		 */
		private function setNamespacedProp(prop:String, dir:String,  target:Object, val:Number):void
		{
			if(target is DockMenu && prop == "offset" || prop == "stage")
			{
				target[prop + dir] = val;
				return;
			}
			target[prop + dir] = val;
		}
		
		/**
		 * Gets any property in the form (propertyX) value depending on the position namespace.
		 * It extracts propertyX if horizontal and propertyY if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param property The base property name to which X will be added before getting its value.
		 * @param target Object to extract the propertyX value from.
		 *
		 * @return The propertyX value if horizontal propertyY if vertical.
		 * 
		 * @private
		 */
		public function getXProp(prop:String, target:Object):Number
		{
			return getNamespacedProp(prop, getXName(false), target);
		}	
		
		/**
		 * Sets any property in the form (propertyX) depending on the position namespace.
		 * It sets propertyX if horizontal and propertyY if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param property The base property name to which X will be added before setting its value.
		 * @param target Object to set the propertyX value.
		 *
		 * @private
		 */
		public function setXProp(prop:String, target:Object, val:Number):void
		{
			setNamespacedProp(prop, getXName(false), target, val);
		}
		
		/**
		 * Gets any property in the form (propertyY) value depending on the position namespace.
		 * It extracts propertyY if horizontal and propertyX if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param property The base property name to which Y will be added before getting its value.
		 * @param target Object to extract the propertyY value from.
		 *
		 * @return The propertyY value if horizontal propertyX if vertical.
		 * 
		 * @private
		 */
		public function getYProp(prop:String, target:Object):Number
		{
			return getNamespacedProp(prop, getYName(false), target);
		}	
		
		/**
		 * Sets any property in the form (propertyY) depending on the position namespace.
		 * It sets propertyY if horizontal and propertyX if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param property The base property name to which Y will be added before setting its value.
		 * @param target Object to set the propertyY value.
		 *
		 * @private
		 */
		public function setYProp(prop:String, target:Object, val:Number):void
		{
			setNamespacedProp(prop, getYName(false), target, val);
		}
		
		/**
		 * Gets any property in the form (propertyWidth) value depending on the position namespace.
		 * It extracts propertyWidth if horizontal and propertyHeight if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param property The base property name to which Width/Height will be added before getting its value.
		 * @param target Object to extract the propertyWidth value from.
		 *
		 * @return The propertyWidth value if horizontal propertyHeight if vertical.
		 * 
		 * @private
		 */
		public function getWidthProp(prop:String, target:Object):Number
		{
			return getNamespacedProp(prop, getWidthName(false), target);
		}
		
		/**
		 * Sets any property in the form (propertyWidth) depending on the position namespace.
		 * It sets propertyWidth if horizontal and propertyHeight if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param property The base property name to which Width/Height will be added before setting its value.
		 * @param target Object to set the propertyWidth value.
		 *
		 * @private
		 */
		public function setWidthProp(prop:String, target:Object, val:Number):void
		{
			setNamespacedProp(prop, getWidthName(false), target, val);
		}
		
		/**
		 * Gets any property in the form (propertyHeight) value depending on the position namespace.
		 * It extracts propertyHeight if horizontal and propertyWidth if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param property The base property name to which Width/Height will be added before getting its value.
		 * @param target Object to extract the propertyHeight value from.
		 *
		 * @return The propertyHeight value if horizontal propertyWidth if vertical.
		 * 
		 * @private
		 */
		public function getHeightProp(prop:String, target:Object):Number
		{
			return getNamespacedProp(prop, getHeightName(false), target);
		}
		
		/**
		 * Sets any property in the form (propertyHeight) depending on the position namespace.
		 * It sets propertyHeight if horizontal and propertyWidth if vertical.
		 * Used internally only to make bar positioning and sizing easier.
		 *
		 * @param property The base property name to which Width/Height will be added before setting its value.
		 * @param target Object to set the propertyHeight value.
		 *
		 * @private
		 */
		public function setHeightProp(prop:String, target:Object, val:Number):void
		{
			setNamespacedProp(prop, getHeightName(false), target, val);
		}
	}
}