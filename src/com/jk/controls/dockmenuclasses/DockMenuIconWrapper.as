package com.jk.controls.dockmenuclasses
{
	import com.jk.controls.DockMenuPosition;
	import flash.display.DisplayObjectContainer;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.*;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.utils.getDefinitionByName;

	/**
	 * This class wraps the icon image to allow special actions like: selection animation, image
	 * caching, reflection, correct icon placing (even if register point is not correctly set)
	 * 
     * @author Juan Carlos Pazmiño
	 * @private
	 */
	public class DockMenuIconWrapper extends Sprite
	{
		private static const ICON_MARGIN:int = 1;

		// Click effect variables
		private var clickEffect:String;
		private var clickEffectCounter:Number;
		private var tickTween:TweenMax;

		// Current icon
		private var _iconInstance:DisplayObject;
		// Current icon cache bitmap
		private var bitmapInstance:Bitmap;

		private var _data:Object;
		/**
		 * The data stored in the icon. It comes from the <code>DockMenu.dataProvider</code>.
		 * 
		 * @see com.jk.controls.DockMenu#dataProvider
		 */
		public function get data():Object
		{
			return _data;
		}

		private var _middlePosition:Number;
		/**
		 * Caches the icon middle x position usefull to center and position the icon.
		 */
		public function get middlePosition():Number
		{
			return _middlePosition;
		}

		private var _container:Sprite;
		/**
		 * The icon container.
		 */
		public function get container():Sprite
		{
			return _container;
		}

		// Is the icon currently animating
		private var _animating:Boolean = false;

		// The minimum icon width
		private var _iconSize:Number;
		
		// The current icon width
		private var _currentHeight:Number;
		// The current icon height
		private var _currentWidth:Number;

		// Mask used to create the reflection
		private var _reflectionMask:Shape;

		// The position in which the <code>DockMenu</code> is docked.
		private var _barPos:DockMenuPosition;

		private var _reflectionContainer:Sprite;
		private var _reflection:Bitmap;
		
		private var _bitmapCapture:BitmapData;
		
		private var _tweenPosition:Number;
		
		/**
		 * Creates a <code>DockMenuIconWrapper</code> instance. It wraps the actual icon image to perform calculations
		 * @param d The icon data passed directly from data in side <code>DockMenu.dataProvider</code>.
		 * @param iconSize The minimum icon size.
		 * @param position The position to place the new icon.
		 * @param barPos The instance of <code>DockMenuPosition</code> object used by the <code>DockMenu</code> to handle 
		 * positioning based on dock position.
		 * 
		 * @see com.jk.controls.DockMenu#dataProvider
		 * @see com.jk.controls.DockMenu#minIconSize
		 * @see com.jk.controls.DockMenu#position
		 */
		public function DockMenuIconWrapper(d:Object, iconSize:Number, position:Point, barPos:DockMenuPosition)
		{
			// Create the container for the icon
			_container = new Sprite();
			addChild(_container);

			// Store data
			_barPos = barPos;
			_currentHeight = iconSize;
			_data = d;
			
			// Get total icon space depending on dock position (side margins included)
			_iconSize = iconSize;

			// Prevent icons from handling mouse interaction
			_container.mouseEnabled = false;
			_container.mouseChildren = false;

			// Add the icon
			_container.addChild(iconInstance);
			
			var w:Number = iconSize - (_barPos.isVertical? (ICON_MARGIN * 2) : 0);
			var h:Number = iconSize - (!_barPos.isVertical? (ICON_MARGIN * 2) : 0);

			// Get the ratio
			var ratio:Number = iconInstance.width / iconInstance.height;
			var iconRatio:Number = w / h;

			// Icon aspect ratio is compared against available space aspect ratio.
			if (ratio > iconRatio)
			{
				// Adjust width and set scaleY
				iconInstance.width = w;
				iconInstance.scaleY = iconInstance.scaleX;
			}
			else
			{
				// Adjust height and set scaleX
				iconInstance.height = h;
				iconInstance.scaleX = iconInstance.scaleY;
			}
			
			// Center the icon into the total space
			iconInstance.x = (iconSize - iconInstance.width) / 2;
			iconInstance.y = (iconSize - iconInstance.height) / 2;
			
			// Calculate offsets in case the icon is not setting the registration point correctly
			var bounds:Rectangle = iconInstance.getRect(_container);
			var offsetX:Number = iconInstance.x - bounds.x;
			var offsetY:Number = iconInstance.y - bounds.y;

			// Add these offsets
			iconInstance.x += offsetX;
			iconInstance.y += offsetY;

			// Create the transparent boundingBox
			var boundingBox:Sprite = new Sprite();
			boundingBox.graphics.beginFill(0, 0);
			boundingBox.graphics.drawRect(0, 0, _iconSize, _iconSize);

			// Add the bounding box to the container
			_container.addChildAt(boundingBox, 0);

			// Create the bitmap caching holder
			bitmapInstance = new Bitmap();
			bitmapInstance.pixelSnapping=PixelSnapping.NEVER;
			_container.addChild(bitmapInstance);

			// And the reflection which is composed of a mask and the reflection inside a container
			_reflectionContainer = new Sprite();

			_reflection = new Bitmap();

			_reflectionMask = new Shape();
			_reflectionMask.blendMode=BlendMode.ALPHA;
			_reflectionContainer.blendMode=BlendMode.LAYER;

			_barPos.setYProp("scale", _reflectionContainer, -1);
			
			// Set reflection scale and position based on DockMenu dock position
			if (_barPos.isInverse)
			{
				_barPos.setY(_reflection, -iconSize);
				_barPos.setY(_reflectionContainer, iconSize);
			}

			_reflectionContainer.addChild(_reflection);
			_reflectionContainer.addChild(_reflectionMask);

			// Add reflection outside the container to avoid animating it at the same time of the icon
			addChild(_reflectionContainer);

			// Clean data on unload
			addEventListener(Event.UNLOAD, unloadHandler);

			x = position.x;
			y = position.y;
			
			// Set current icon size (this doesn't take into account the reflection).
			_currentWidth = _currentHeight = iconSize;

			// Store the original icon middle position (x + size / 2)
			_middlePosition = _barPos.getX(position) + (iconSize / 2);
		}
		
		private function resolveIconClass(className:Object):Class
		{
			// If the icon is a class ...
			if (className is Class)
			{
				// ... cast the object to a class
				return className as Class;
			}

			// ... Otherwise try to get a class reference with that name
			try
			{
				return getDefinitionByName(String(className)) as Class;
			}
			catch (e:Error){ }
			return null;
		}
		
		private function get iconInstance():DisplayObject
		{
			_iconInstance ||= instantiateIcon();
			return _iconInstance;
		}
		
		private function instantiateIcon():DisplayObject
		{
			var instance:DisplayObject = instantiateIconWithData(_data.icon);
			if (instance == null)
			{
				throw new Error("The icon's DisplayObject could no be created with data: " + _data.icon + ".");
			}
			return instance;
		}
		
		private function instantiateIconWithData(className:Object):DisplayObject 
		{
			trace("Instantiate icon", className);
			var IconClass:Class = resolveIconClass(className);

			// If the icon is a class ...
			if (IconClass != null)
			{
				// ... create an instance of the DisplayObject
				return (new IconClass()) as DisplayObject;
			}
			
			// ... then it could be a DisplayObject
			return className as DisplayObject;
		}

		/**
		 * Height is overridden to prevent the icon from considering its reflection as part of its height.
		 */
		override public function get height():Number
		{
			return _currentHeight;
		}
		/**
		 * @private
		 */
		override public function set height(val:Number):void
		{
			_currentHeight = val;
			// We better use scaleY to set the size as a percentage (newHeight / originalHeight)
			// We do this because the size/position of the reflection might vary so it is difficult to control
			super.scaleY = _currentHeight / _iconSize;
		}

		/**
		 * Width is overridden to prevent the icon from considering its reflection as part of its height.
		 */
		override public function get width():Number
		{
			return _currentWidth;
		}
		/**
		 * @private
		 */
		override public function set width(val:Number):void
		{
			_currentWidth = val;
			// We better use scaleX to set the size as a percentage (newWidth / originalWidth)
			// We do this because the size/position of the reflection might vary so it is difficult to control
			super.scaleX = _currentHeight / _iconSize;
		}

		/**
		 * Creates or hides the icon cache image depending on a status.
		 *  
		 * @param status The whether to show or hide the cached image
		 * @param minIconSize Minimum icon size used to resize the icon after the capture is done.
		 * @param maxIconSize Maximum icon size used to create the capture and avoid bitmap pixelation.
		 * 
		 */
		public function setIconCache(status:Boolean, minIconSize:Number, maxIconSize:Number):void
		{
			if (_data.cacheIcon != undefined)
			{
				status = Boolean(_data.cacheIcon);
			}
			
			bitmapInstance.visible = status;
			iconInstance.visible = !status;

			if (!status)
			{
				return;
			}

			createBitmapCapture(maxIconSize);

			bitmapInstance.bitmapData = _bitmapCapture;
			bitmapInstance.smoothing = true;
			bitmapInstance.width = bitmapInstance.height = minIconSize;
		}

		/**
		 * Animates effects during an specified amount of time.
		 *  
		 * @param effect The effect to animate
		 * @param duration The animation duration
		 * @param amount The amount of times to animate
		 * 
		 */
		public function animate(effect:String, duration:Number, amount:uint):void
		{
			if (_animating)
			{
				return;
			}

			clickEffect = effect;
			_animating = true;
			
			clickEffectCounter = (amount - 1) * 2 - 1;
			
			var props:Object = {
				tweenPosition: 1,
				ease: Quad.easeOut,
				yoyo: true,
				repeat: clickEffectCounter,
				onComplete: itemMotionFinishHandler
			};

			_tweenPosition = 0;
			tickTween = new TweenMax(this, duration, props);
		}

		
		public function get tweenPosition():Number
		{
			return _tweenPosition;
		}
		
		public function set tweenPosition(val:Number):void
		{
			_tweenPosition = val;
			this[clickEffect+"Tick"](_tweenPosition);
		}

		/**
		 * Handles motion finish to determine if a new animation cycle is nedded or
		 * is animation must be stopped. 
		 * @param event
		 * 
		 */
		private function itemMotionFinishHandler():void
		{
			_animating=false;
			filters=[];
			tickTween=null;
		}

		/**
		 * Handles jump animation
		 * @param val The current animation tick percentage.
		 * 
		 */
		private function jumpTick(val:Number):void
		{
			var newPos:Number =  val * 4 * (_barPos.isInverse? -1 : 1);
			_barPos.setY(_container, newPos);
			_barPos.setY(_reflectionContainer, (_barPos.isInverse? _iconSize : 0) - newPos);
		}

		/**
		 * Handles fade animation
		 * @param val The current animation tick percentage.
		 * 
		 */
		private function fadeTick(val:Number):void
		{
			var matrix:Array = [1, 0, 0, 0, 0,
			0, 1, 0, 0, 0,
			0, 0, 1, 0, 0,
			0, 0, 0, 1 - (val * 0.6), 0];

			var fadeFilter:ColorMatrixFilter=new ColorMatrixFilter(matrix);

			_container.filters=[fadeFilter];
			_reflectionContainer.filters=[fadeFilter];
		}

		/**
		 * Handles glow animation
		 * @param val The current animation tick percentage.
		 * 
		 */
		private function set glowTick(val:Number):void
		{
			var blur:Number=20*val;
			var strength:Number=2.5*val;
			var glowFilter:GlowFilter=new GlowFilter(0xFFFFFF,1,blur,blur,strength,2);
			_container.filters=[glowFilter];
			_reflectionContainer.filters=[glowFilter];
		}

		/**
		 * Handles shine animation
		 * @param val The current animation tick percentage.
		 * 
		 */
		private function shineTick(val:Number):void
		{
			var colorTrans:ColorTransform = new ColorTransform();
			colorTrans.redOffset = 
			colorTrans.greenOffset = 
			colorTrans.blueOffset = 100 * val;

			_container.transform.colorTransform=colorTrans;
			_reflectionContainer.transform.colorTransform=colorTrans;
		}

		/**
		 * Handles bevel animation
		 * @param val The current animation tick percentage.
		 * 
		 */
		private function bevelTick(val:Number):void
		{
			var dist:Number=1.3*val*scaleX;
			var bevelFilter:BevelFilter = new BevelFilter(dist, 45, 0xFFFFFF, 0.7, 0x000000, 0.7, 
			  dist, dist, 1, 2);
			_container.filters=[bevelFilter];
			_reflectionContainer.filters=[bevelFilter];
		}

		/**
		 * Handles blur animation
		 * @param val The current animation tick percentage.
		 * 
		 */
		private function blurTick(val:Number):void
		{
			var blur:Number=2*val*scaleX;
			var blurFilter:BlurFilter=new BlurFilter(blur,blur,2);
			_container.filters=[blurFilter];
			_reflectionContainer.filters=[blurFilter];
		}
		
		/**
		 * Disposes bitmap data on unload (garbage collection) 
		 * @param event
		 * 
		 */
		private function unloadHandler(event:Event):void
		{
			if (bitmapInstance.bitmapData)
			{
				bitmapInstance.bitmapData.dispose();
			}
		}

		/**
		 * Creates or hides the reflection depending on a status.
		 *  
		 * @param status The whether to show or hide the reflection
		 * @param minIconSize Minimum icon size used to resize the icon after the capture is done.
		 * @param maxIconSize Maximum icon size used to create the capture and avoid bitmap pixelation.
		 * @param alpha The alpha transparency used for the reflection.
		 * @param size The size of the reflection from 0 to 1.
		 * 
		 */
		public function setReflection(status:Boolean, minIconSize:int, maxIconSize:int, alpha:Number, size:Number):void
		{
			_reflectionContainer.visible=status;

			if (! status)
			{
				return;
			}

			createBitmapCapture(maxIconSize);

			_reflection.alpha=alpha;
			_reflection.bitmapData=_bitmapCapture;
			_reflection.smoothing = true;
			_reflection.width=_reflection.height=minIconSize;

			var matrix:Matrix = new Matrix();
			var divider:int = 1;
			var degSize:Number = minIconSize/divider;

			if (_barPos.position==DockMenuPosition.TOP)
			{
				matrix.createGradientBox(minIconSize, minIconSize + (degSize * 2), 
				Math.PI/2, 0, -degSize);
			}
			else if (_barPos.position == DockMenuPosition.BOTTOM)
			{
				matrix.createGradientBox(minIconSize, minIconSize + (degSize * 2), 
				-Math.PI/2, 0, -degSize);
			}
			if (_barPos.position==DockMenuPosition.LEFT)
			{
				matrix.createGradientBox(minIconSize + (degSize * 2), minIconSize, 
				0, -degSize, 0);
			}
			if (_barPos.position==DockMenuPosition.RIGHT)
			{
				matrix.createGradientBox(minIconSize + (degSize * 2), minIconSize, 
				-Math.PI, -degSize, 0);
			}

			var partialRatio:int = 0xFF / (divider + 2);
			var begin:int = size * (0xFF - partialRatio);
			var end:int=begin+partialRatio;

			_reflectionMask.graphics.clear();
			_reflectionMask.graphics.beginGradientFill(
			GradientType.LINEAR, [0, 0], [1, 0], [begin, end],
			matrix, SpreadMethod.PAD);
			_reflectionMask.graphics.drawRect(0, 0, minIconSize, minIconSize);

			if (_barPos.isInverse)
			{
				_barPos.setY(_reflectionMask, -minIconSize);
			}
		}

		/**
		 * Clears the cached icon bitmap. 
		 */
		public function clearCache():void
		{
			if (_bitmapCapture)
			{
				_bitmapCapture.dispose();
				_bitmapCapture = null;
			}
		}

		/**
		 *  Creates a Bitmap the is a capture of the contents on this wrapper without the reflection.
		 *  The capture is stored in _bitmapCapture so that reflection and cache can use it and share it.
		 * 
		 * @param maxIconSize The maximum size the icon will have. This way we ensure the icon will not pixelate.
		 * 
		 */
		private function createBitmapCapture(maxIconSize:Number):void
		{
			if (_bitmapCapture != null && _bitmapCapture.width == maxIconSize)
			{
				return;
			}

			if (_bitmapCapture)
			{
				_bitmapCapture.dispose();
			}

			var savedWidth:Number = _container.width;
			var savedHeight:Number = _container.height;
			var savedInternalX:Number = _container.x;
			var savedInternalY:Number = _container.y;
			var savedVisible:Boolean = iconInstance.visible;

			_container.width = _container.height = maxIconSize;
			_container.x = _container.y = 0;

			_bitmapCapture = new BitmapData(maxIconSize, maxIconSize, true, 0);

			iconInstance.visible = true;
			_bitmapCapture.draw(_container, _container.transform.matrix, null, null, null, true);
			iconInstance.visible = savedVisible;

			// Reset properties to original values
			_container.width = savedWidth;
			_container.height = savedHeight;
			_container.x = savedInternalX;
			_container.y = savedInternalY;
		}
	}
}