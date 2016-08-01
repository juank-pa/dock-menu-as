package com.jk.controls{
	import com.jk.controls.dockmenuclasses.DockMenuIconWrapper;
	import com.jk.controls.dockmenuclasses.DockMenuInvalidationType;
	import com.jk.events.DockMenuEvent;
	
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.data.DataProvider;
	import fl.events.DataChangeEvent;
	import com.greensock.*;
	import com.greensock.easing.*;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	[IconFile("dockMenu.png")]
	
	/**
	 * Defines the skin used for the selector that appears when an icon is selected.
	 * The skin can be a Class, class name or <code>DisplayObject</code> instance.
	 */
	[Style(name="selectionSkin", type="Class")]
	
	/**
	 * Defines the skin for the DockMenu bar.
	 * The skin can be a Class, class name or <code>DisplayObject</code> instance.
	 */
	[Style(name="barSkin", type="Class")]
	
	/**
	 * Dispatched when the user rolls over an icon in the <code>DockeMenu</code>.
	 * 
	 * @eventType com.jk.events.DockMenuEvent.ICON_ROLL_OVER
	 * 
	 * @see #iconRollOut
	 * @see #iconClick
	 */	
	[Event(name="iconRollOver", type="com.jk.events.DockMenuEvent")]
	
	/**
	 * Dispatched when the user rolls out of an icon in the <code>DockeMenu</code>.
	 * 
	 * @eventType com.jk.events.DockMenuEvent.ICON_ROLL_OUT
	 * 
	 * @see #iconRollOver
	 * @see #iconClick
	 */	
	[Event(name="iconRollOut", type="com.jk.events.DockMenuEvent")]
	
	/**
	 * Dispatched when the user clicks an icon in the <code>DockeMenu</code>.
	 * 
	 * @eventType com.jk.events.DockMenuEvent.ICON_CLICK
	 * 
	 * @see #iconRollOver
	 * @see #iconRollOut
	 */	
	[Event(name="iconClick", type="com.jk.events.DockMenuEvent")]
		
	/**
	 * The <code>DockMenu</code> component is a menu bar based on the Mac OS X dock. The <code>DockMenu</code> was
	 * created mainly for people with minimum or null ActionScript knowledge. Thus you can configure most of the main
	 * aspects of the component by just setting the component parameters. See the <code>Dockemnu</code> for non programmers section. 
	 * Programmers can add icons using the <code>DockMenu.dataProvider</code> property.
	 * 
	 * <p>The <code>DockMenu</code> can be placed in the main timeline or inside a movie clip (<code>DisplayObjectContainer</code>):</p>
	 * 
	 * <ul>
	 * <li>When placed in the main timeline the menu bar is automatically docked and centered to the desired side of the screen. 
	 * In "fluid" application that will resize with the player/browser window, set <code>stage.align</code> 
	 * to <code>StageAlign.TOP_LEFT</code> for the DockMenu to work correctly.</li>
	 * 
	 * <li>When placed inside a movie clip (<code>DisplayObjectContainer</code>) the menu is automatically docked and centered to the
	 * bounding box of the container. This way you can create a movie clip with a transparent square shape and drag the <code>DockMenu</code> inside.
	 * To move the <code>DockMenu</code> anywhere, just move the container clip.</li>
	 * </ul>
	 * 
	 * <p>Once <code>DockMenu</code> is created the bar will automatically be docked to the side of the container specified 
	 * by the position parameter or the <code>DockMenu.position</code> property, so don't worry about positioning it.</p>
	 * 
	 * <strong><code>DockMenu</code> for non programmers</strong>
	 * 
	 * <ol>
	 * <li>Create icons for the <code>DockMenu</code>:</li>
	 * 
	 * <ul>
	 * <li>Create a movie clip (<code>DisplayObjectContainer</code>) or choose one already in the library. 
	 * You don't need to worry about neither the register point position nor the size of the icon;
	 * they are automatically managed by the <code>DockMenu</code>.</li>
	 * 
	 * <li>Right click the symbol in the Library panel and select Properties</li>
	 * 
	 * <li>In the Properties Dialog select the Advanced button if not already selected and select the Export for ActionScript option.</li>
	 * 
	 * <li>Enter a name in the Class textbox, finally press OK.</li>
	 * 
	 * <li>Repeat the process for each icon.</li>
	 * </ul>
	 * 
	 * <li>Drag a <code>DockMenu</code> instance from the Components panel to your movie and make sure it is selected</li>
	 * 
	 * <li>Open the Component Inspector panel parameters tab (Property Inspector in Flash CS5) and set the dock position, icon size, 
	 * autoHide behavior and cacheIcon behavior.</li>
	 * 
	 * <li>Double click the dataProvider property. A dialog opens to allow you adding icons for the <code>DockMenu</code>.</li>
	 * 
	 * <li>Press the + button to add an icon or - to remove it.</li>
	 * 
	 * <li>Enter the following data for each bar item:</li>
	 *	
	 * <ul>
	 * <li><strong>caption:</strong> (optional) is the label that will appear near the icon. You can omit this value if you don't want any label.</li>
	 * 
	 * <li><strong>icon:</strong> (mandatory) is the Class name of a movie clip (DisplayObject) in the library that will be used as the icon image 
	 * (for information on creating you icons see Using the DockMenu component). 
	 * The icon can be also set to a <code>DisplayObject</code> instance using ActionScript code (see <code>DockMenu.dataProvider</code>).</li>
	 * 
	 * <li><strong>link:</strong> (optional) specifies the action to be performed when a button is clicked. 
	 * What the menu will do depends on this value and the target property also. If no link is specified no 
	 * action will be accomplished but you can still listen to the <code>click</code> event programmatically.</li>
	 * 
	 * <li><strong>target:</strong> (optional) is the object that will perform the action specified by link:</li>
	 * 
	 * <ul>
	 * <li>If the link property contains a file name with the .swf, .gif, .jpg or .png extension then the target
	 * must be set to the path of the movie clip (relative to the <code>DockMenu</code>'s parent timeline or absolute), to be used 
	 * as the loader clip. If the target is a <code>Loader</code> object then it will be set to load the link immediately (you can listen to
	 * the <code>Loader</code> events yourself). If the target is a <code>DisplayObjectContainer</code> (<code>MovieClip</code>, 
	 * <code>Sprite</code>, etc) then <code>DockMenu</code> creates a Loader object inside and begins the loading process. 
	 * <code>DockMenu</code> creates only one <code>Loader</code> object per container.</li>
	 * 
	 * <li>If the link property contains a file name using any other extension (like .html, .pdf, etc...) or if it is a web
	 * site URL (http://www.mysite.com) then the target must be set to the HTML target window (_self, _blank, _parent, _top 
	 * or any other HTML frame name).</li>
	 * 
	 * <li>If the link property doesn't contain the (.) or (/) characters then it is considered a frame label or number. 
	 * The target must be set to the path of the movie clip (relative to the <code>DockMenu</code>'s parent timeline or absolute), to go to
	 * and stop to the specified frame. Write a plus sign (+) at the end of the frame number or label in the link property to go to 
	 * and play to that frame instead of stopping.</li>
	 * </ul>
	 * 
	 * <li><strong>linkType:</strong> (optional) is the link type that allows changing how the link and target data are interpreted 
	 * by <code>DockMenu</code>. Normally you would not change this property but sometimes this property allows <code>DockMenu</code> to 
	 * choose the right behavior when in doubt.</li>
	 * 
	 * <ul>
	 * <li>If linkType is set to "auto" then the link and target are interpreted automatically as described before in the target property.</li>
	 * 
	 * <li>If linkType is "swf" then it will force the link and target to be interpreted as loading an SWF, JPEG, GIF or PNG 
	 * file into a target movie. Use this option when you need to load an SWF, JPEG, GIF or PNG files but the component 
	 * is misunderstanding this. This can happen when the link is a .php, .apsx, .jsp, .cfm, etc... page that returns a 
	 * SWF, JPEG, GIF or PNG as its response instead of a web page.</li>
	 * 
	 * <li>If linkType is "webpage" it will force the link and target to be interpreted as navigating to an HTML page. 
	 * Use this option when you mean to navigate to an URL but the component is misunderstanding this. This can happen if the 
	 * link you use doesn't contain any / or . characters (relative paths mostly). You can also use this option to open the 
	 * image file in a popup window instead of inside a container in the SWF file.</li>
	 * 
	 * <li>If linkType is "movieclip" it will force the link and target to be interpreted as moving a movie clip timeline. 
	 * Use this option when you need to control the timeline of a movie clip but the component is misunderstanding this. 
	 * This can happen if the frame label contains a point in its name.</li>
	 * </ul> 
	 * </ul>
	 * </ol>
	 * 
     * @author Juan Carlos Pazmiño
	 * @see #dataProvider
	 * 
	 * @includeExample ../../../DockMenuSample.as
	 */
	public class DockMenu extends UIComponent
	{
		// Style defaults registration
		private static var defaultStyles:Object = {selectionSkin:"DockMenu_selectionSkin",
												   barSkin:"DockMenu_barSkin"};
		
		/**
		 * To handle Flash style framework
		 * @private
		 */
		public static function getStyleDefinition():Object 
		{ 
			return defaultStyles;
		}

		// Internal magnifier wave size in pixels
		private var magnifiedWaveSize:Number;
		private var waveLength:Number;
		
		// The internal icon list
		private var iconList:Array;
		
		// Activates/deactivates the magnify effect
		private var magnifyActive:Boolean = false;
		// Determines if the magnifying effect is currently running
		private var magnifying:Boolean = false;
		// The magnifying effect current percentage (between 0 and 1)
		public var magnifyPercent:Number = 0;
		
		// Last saved mouse position
		private var lastMousePos:Number;
		
		// It contains the complete DockMenu to allow easy positioning
		private var container:Sprite;
		
		// The bar sprite contains the bar Skin
		private var barSprite:Sprite;
		private var barSkin:DisplayObject;
		
		// Detects hit testing
		private var hitSprite:Sprite;
		
		// Icons container
		private var iconsMc:Sprite;
		
		// Detects hit testing for autoHide behavior
		private var autohideBar:Sprite;
		
		// The icons label. labelField contains the textField
		private var labelField:Sprite;
		private var textField:TextField;
		
		// The selection arrow
		private var arrow:DisplayObject;
		
		private var magnifyTween:TweenNano;
		private var hideTween:TweenNano;
		
		private var autoHideTimer:Timer;
				
		// Determines the dimensions of the container DisplayObject
		/**
		 * @private
		 */
		public var stageWidth:Number;
		/**
		 * @private
		 */
		public var stageHeight:Number;
		
		// If the container contents do not begin at (0, 0) an offset is stored
		// to correctly calculate positions
		/**
		 * @private
		 */
		public var offsetX:Number;
		/**
		 * @private
		 */
		public var offsetY:Number;
		
		// The last rolled over icon
		private var rolledItem:DockMenuIconWrapper;
		
		private var _hidden:Boolean = true;
		
		/**
		 * Defines whether the <code>DockMenu</code> is currently hidden <code>true</code> or shown <code>false</code>.
		 * <p>This property can be <code>true</code> only if the <code>DockeMenu.autoHide</code> property is set to <code>true</code> 
		 * otherwise is always false.</p>
		 * 
		 * @see #autoHide
		 * @see #autoHideTime
		 */
		public function get hidden():Boolean
		{
			return (_autoHide && _hidden)
		}
		
		// Force DockMenuIconData to be included
		private static var iconItem:DockMenuIconData;
		
		private var _dataProvider:DataProvider = null;
		
		[Collection(collectionClass="fl.data.DataProvider", collectionItem="com.jk.controls.DockMenuIconData", identifier="caption")]
		/**
		 * Gets or sets the data model of the list of icons to be viewed. 
		 * A data provider can be shared by multiple <code>DockMenu</code> and list-based components.
		 * Changes to the data provider object are immediately available to all components that use it as a data source but
		 * changes to individual items might not (call the invalidate() method to refresh this kind of changes).
		 * 
		 * <p>Each item can contain an <code>icon</code> (class name), <code>caption</code>, <code>link</code>, <code>target</code> 
		 * and <code>linkType</code> properties plus any other user data needed.</p>
		 * 
		 * The following describes each property:
		 * 
		 * <ul>
		 * <li><strong>caption:</strong> (optional) is the label that will appear near the icon. You can omit this value if you don't want any label.</li>
		 * 
		 * <li><strong>icon:</strong> (mandatory) is the Class name of a movie clip (DisplayObject) in the library that will be used as the icon image 
		 * (for information on creating you icons see Using the DockMenu component). 
		 * The icon can be also set to a <code>DisplayObject</code> instance using ActionScript code (see <code>DockMenu.dataProvider</code>).</li>
		 * 
		 * <li><strong>link:</strong> (optional) specifies the action to be performed when a button is clicked. 
		 * What the menu will do depends on this value and the target property also. If no link is specified no 
		 * action will be accomplished but you can still listen to the <code>click</code> event programmatically.</li>
		 * 
		 * <li><strong>target:</strong> (optional) is the object that will perform the action specified by link:</li>
		 * 
		 * <ul>
		 * <li>If the link property contains a file name with the .swf, .gif, .jpg or .png extension then the target
		 * must be set to the path of the movie clip (relative to the <code>DockMenu</code>'s parent timeline or absolute), to be used 
		 * as the loader clip. If the target is a <code>Loader</code> object then it will be set to load the link immediately (you can listen to
		 * the <code>Loader</code> events yourself). If the target is a <code>DisplayObjectContainer</code> (<code>MovieClip</code>, 
		 * <code>Sprite</code>, etc) then <code>DockMenu</code> creates a Loader object inside and begins the loading process. 
		 * <code>DockMenu</code> creates only one <code>Loader</code> object per container.</li>
		 * 
		 * <li>If the link property contains a file name using any other extension (like .html, .pdf, etc...) or if it is a web
		 * site URL (http://www.mysite.com) then the target must be set to the HTML target window (_self, _blank, _parent, _top 
		 * or any other HTML frame name).</li>
		 * 
		 * <li>If the link property doesn't contain the (.) or (/) characters then it is considered a frame label or number. 
		 * The target must be set to the path of the movie clip (relative to the <code>DockMenu</code>'s parent timeline or absolute), to go to
		 * and stop to the specified frame. Write a plus sign (+) at the end of the frame number or label in the link property to go to 
		 * and play to that frame instead of stopping.</li>
		 * </ul>
		 * 
		 * <li><strong>linkType:</strong> (optional) is the link type that allows changing how the link and target data are interpreted 
		 * by <code>DockMenu</code>. Normally you would not change this property but sometimes this property allows <code>DockMenu</code> to 
		 * choose the right behavior when in doubt.</li>
		 * 
		 * <ul>
		 * <li>If linkType is set to <code>DockMenuLinkType.AUTO</code> then the link and target are interpreted automatically as described before in the target property.</li>
		 * 
		 * <li>If linkType is <code>DockMenuLinkType.SWF</code> then it will force the link and target to be interpreted as loading an SWF, JPEG, GIF or PNG 
		 * file into a target movie. Use this option when you need to load an SWF, JPEG, GIF or PNG files but the component 
		 * is misunderstanding this. This can happen when the link is a .php, .apsx, .jsp, .cfm, etc... page that returns a 
		 * SWF, JPEG, GIF or PNG as its response instead of a web page.</li>
		 * 
		 * <li>If linkType is <code>DockMenuLinkType.WEB_PAGE</code> it will force the link and target to be interpreted as navigating to an HTML page. 
		 * Use this option when you mean to navigate to an URL but the component is misunderstanding this. This can happen if the 
		 * link you use doesn't contain any / or . characters (relative paths mostly). You can also use this option to open the 
		 * image file in a popup window instead of inside a container in the SWF file.</li>
		 * 
		 * <li>If linkType is <code>DockMenuLinkType.MOVIECLIP</code> it will force the link and target to be interpreted as moving a movie clip timeline. 
		 * Use this option when you need to control the timeline of a movie clip but the component is misunderstanding this. 
		 * This can happen if the frame label contains a point in its name.</li>
		 * </ul> 
		 * </ul>
		 * 
		 * @default null
		 * 
		 * @see DockMenuLinkType
		 */
		public function get dataProvider():DataProvider
		{			
			return _dataProvider; 
		}
		
		/**
		 * @private
		 */
		public function set dataProvider(value:DataProvider):void
		{
			if (_dataProvider != null) 
			{
				_dataProvider.removeEventListener(DataChangeEvent.DATA_CHANGE, handleDataChange);
			}
			_dataProvider = value;
			_dataProvider.addEventListener(DataChangeEvent.DATA_CHANGE, handleDataChange, false, 0, true);
			
			// Reset selectedItem to null and hide the arrow because data is different now
			_selectedItem = null;
			
			if(arrow)
			{
				arrow.visible = false;
			}
			
			// Invalidate ICONS, CACHE and REFLECION only
			invalidate(DockMenuInvalidationType.ICONS);
			invalidate(DockMenuInvalidationType.CACHE);
			invalidate(DockMenuInvalidationType.REFLECTION);
		}
		
		/**
		 * If the dataProvider is updated invalidate the component.
		 */
		private function handleDataChange(e:DataChangeEvent):void
		{
			invalidate(DockMenuInvalidationType.ICONS);
			invalidate(DockMenuInvalidationType.CACHE);
			invalidate(DockMenuInvalidationType.REFLECTION);
		}
		
		private var _cacheIcons:Boolean = false;
		
		[Inspectable(defaultValue=false)]
		/**
		 * Specifies if the icons are cached or not. When set to <code>true</code>, a bitmap representation of each icon 
		 * is created, hiding the original vector image and improving the animation speed. If set to <code>false</code> 
		 * the original vector images will be used making it run slower depending of the vector complexity. 
		 * Note that the icons are cached as bitmaps using its <code>DockMenu.maxIconSize</code> value so 
		 * the image will not pixelate when magnified.
		 * 
		 * @default false 
		 */
		public function get cacheIcons():Boolean
		{
			return _cacheIcons;
		}
		
		/**
		 * @private
		 */
		public function set cacheIcons(val:Boolean):void
		{
			_cacheIcons = val;
			
			invalidate(DockMenuInvalidationType.CACHE);
		}
		
		private var _showReflection:Boolean = false;
		
		[Inspectable(defaultValue=false)]
		/**
		 * Determines whether to show a reflection next to each icon <code>true</code> or not <code>false</code>. 
		 * The position of the reflection depends on the <code>DockMenu.position</code> property.
		 * 
		 * @default false
		 * 
		 * @see #reflectionAlpha
		 * @see #reflectionSize
		 */
		public function get showReflection():Boolean
		{
			return _showReflection;
		}
		
		/**
		 * @private
		 */
		public function set showReflection(val:Boolean):void
		{
			_showReflection = val;
			
			invalidate(DockMenuInvalidationType.REFLECTION);
		}
		
		private var _reflectionSize:Number = 0.5;
		
		[Inspectable(defaultValue=0.5)]
		/**
		 * Indicates the size of the icon reflection between 0 and 1. 
		 * A value of zero means that the reflection is not shown at all while a value of 1 means that the 
		 * reflection is shown completely. Test values between 0 and 1 to make the reflection dissappear midways.
		 * 
		 * @default 0.5
		 * 
		 * @see #showReflection
		 * @see #reflectionAlpha
		 */		
		public function get reflectionSize():Number
		{
			return _reflectionSize;
		}
		
		/**
		 * @private
		 */
		public function set reflectionSize(val:Number):void
		{
			_reflectionSize = Math.max(Math.min(val, 1), 0);
			
			invalidate(DockMenuInvalidationType.REFLECTION);
		}
		
		private var _reflectionAlpha:Number = 0.5;
		
		[Inspectable(defaultValue=0.5)]
		/**
		 * Defines the alpha value of the icon reflection between 0 and 1.
		 * 
		 * @default 0.5
		 * 
		 * @see #showReflection
		 * @see #reflectionSize
		 */
		public function get reflectionAlpha():Number
		{
			return _reflectionAlpha;
		}
		
		/**
		 * @private
		 */
		public function set reflectionAlpha(val:Number):void
		{
			_reflectionAlpha = Math.max(Math.min(val, 1), 0);
			
			invalidate(DockMenuInvalidationType.REFLECTION);
		}
		
		// Gets an special position object that controls position correctly
		// depending on the DockMenu dock position.
		private function getPositionObject():DockMenuPosition
		{
			if(_position == null)
			{
				_position = new DockMenuPosition();
			}
			return _position;
		}
		
		private var _position:DockMenuPosition;
		
		[Inspectable(defaultValue="bottom")]
		/**
		 * A value from the <code>DockMenuPosition</code> class to specify the dock position. You can dock the menu
		 * at the <code>DockMenuPosition.TOP</code>, <code>DockMenuPosition.BOTTOM</code>, <code>DockMenuPosition.RIGHT</code>
		 * or <code>DockMenuPosition.LEFT</code> sides of the stage or containing movie clip. 
		 * The bar appears always centered at the side chosen.
		 * 
		 * @default bottom
		 * 
		 * @see DockMenuPosition
		 */
		public function get position():String
		{
			return getPositionObject().position;
		}
		
		/**
		 * @private
		 */
		public function set position(val:String):void
		{
			var posObj:DockMenuPosition = getPositionObject();
			var savedPos:String = posObj.position;
			posObj.position = val;
			
			if(savedPos != posObj.position)
			{
				invalidate(DockMenuInvalidationType.ICONS);
				invalidate(DockMenuInvalidationType.AUTOHIDE);
				invalidate(DockMenuInvalidationType.CACHE);
				invalidate(DockMenuInvalidationType.REFLECTION);
				invalidate(DockMenuInvalidationType.BAR);
			}
		}
		
		private var _minIconSize:Number = 20;
		
		[Inspectable(defaultValue=20)]
		/**
		 * Defines the minimum icon size (idle state). If the property is lower than 10, its value will be reset to 10, and if higher than 
		 * <code>DockMenu.maxIconSize</code> the value will be reset to <code>DockMenu.maxIconSize</code>.
		 * 
		 * @default 20
		 * 
		 * @see #maxIconSize
		 */
		public function get minIconSize():Number
		{
			return _minIconSize;
		}
		
		/**
		 * @private
		 */
		public function set minIconSize(val:Number):void
		{
			_minIconSize = Math.max(10, Math.min(val, _maxIconSize));
			
			invalidate(DockMenuInvalidationType.ICONS);
			invalidate(DockMenuInvalidationType.CACHE);
			invalidate(DockMenuInvalidationType.REFLECTION);
			invalidate(DockMenuInvalidationType.WAVE_EFFECT);
		}
		
		private var _maxIconSize:Number = 120;
		
		[Inspectable(defaultValue=120)]
		/**
		 * Defines the maximum icon size (roll over state). If the property is lower than <code>DockMenu.maxIconSize</code>, 
		 * its value will be reset to <code>DockMenu.maxIconSize</code>. There is no higher limit.
		 * 
		 * @default 120
		 * 
		 * @see #minIconSize
		 */
		public function get maxIconSize():Number
		{
			return _maxIconSize;
		}
		
		/**
		 * @private
		 */
		public function set maxIconSize(val:Number):void
		{
			_maxIconSize = Math.max(_minIconSize, val);
			
			invalidate(DockMenuInvalidationType.WAVE_EFFECT);
			invalidate(DockMenuInvalidationType.CACHE);
			invalidate(DockMenuInvalidationType.REFLECTION);
		}
		
		private var _barColor:uint = 0xFFFFFF;
		
		/**
		 * Sets or gets the RGB color value of the bar background for the default skin only. 
		 * 
		 * @default 0xFFFFFF
		 * 
		 * @see #barAlpha
		 * @see #borderColor
		 * @see #borderAlpha
		 */
		public function get barColor():uint
		{
			return _barColor;
		}
		
		/**
		 * @private
		 */
		public function set barColor(val:uint):void
		{
			_barColor = val;
			invalidate(DockMenuInvalidationType.BAR);
		}
		
		private var _barAlpha:Number = 0.50;
		
		/**
		 * Sets or gets the alpha transparency of the bar background for the default skin only. 
		 * 
		 * @default 0.5
		 * 
		 * @see #barColor
		 * @see #borderColor
		 * @see #borderAlpha
		 */
		public function get barAlpha():Number
		{
			return _barAlpha;
		}
		
		/**
		 * @private
		 */
		public function set barAlpha(val:Number):void
		{
			_barAlpha = val;
			invalidate(DockMenuInvalidationType.BAR);
		}
		
		private var _borderColor:uint = 0xFFFFFF;
		
		/**
		 * Sets or gets the RGB color value of the bar border for the default skin only. 
		 * 
		 * @default 0xFFFFFF
		 * 
		 * @see #barColor
		 * @see #barAlpha
		 * @see #borderAlpha
		 */
		public function get borderColor():uint
		{
			return _borderColor;
		}
		
		/**
		 * @private
		 */
		public function set borderColor(val:uint):void
		{
			_borderColor = val;
			invalidate(DockMenuInvalidationType.BAR);
		}
		
		private var _borderAlpha:Number = 1;
		
		/**
		 * Sets or gets the alpha transparency value of the bar border for the default skin only. 
		 * 
		 * @default 1
		 * 
		 * @see #barColor
		 * @see #barAlpha
		 * @see #borderColor
		 */
		public function get borderAlpha():Number
		{
			return _borderAlpha;
		}
		
		/**
		 * @private
		 */
		public function set borderAlpha(val:Number):void
		{
			_borderAlpha = val;
			invalidate(DockMenuInvalidationType.BAR);
		}
		
		private var _magnificationSpan:Number = 3;
		
		/**
		 * Determines the amount of icons from the current cursor position to the sides that are affected by the magnification effect. 
		 * The default value is 3 which means 3 icons on each sides (6 icons affected by the magnification).
		 * 
		 * @default 3
		 * 
		 * @see #magnificationTime
		 */
		public function get magnificationSpan():Number
		{
			return _magnificationSpan;
		}
		
		/**
		 * @private
		 */
		public function set magnificationSpan(val:Number):void
		{
			_magnificationSpan = Math.max(val, 1);
			waveLength = _minIconSize * _magnificationSpan;
			invalidate(DockMenuInvalidationType.WAVE_EFFECT);
		}
		
		private var _magnificationTime:Number = 300;
		
		/**
		 * Specifies the time in milliseconds it takes to animate the magnification effect to its full size. 
		 * 
		 * @default 300
		 * 
		 * @see #magnificationSpan
		 */
		public function get magnificationTime():Number
		{
			return _magnificationTime;
		}
		
		/**
		 * @private
		 */
		public function set magnificationTime(val:Number):void
		{
			_magnificationTime = Math.max(val, 0);
		}
		
		private var _selectedItem:DockMenuIconWrapper;
		
		/**
		 * An object containing the data for the currently selected icon. 
		 * This object can have any custom property in addition to: 
		 * icon(Class object, class name, or DisplayObject instance), caption, link, target and linkType. 
		 * If no icon is selected the property returns null.
		 */
		public function get selectedItem():*
		{
			return getItemData(_selectedItem);
		}
		
		private var _embedFonts:Boolean = false;
		
		/**
		 * Indicates whether the font used by the caption is going to be embedded <code>true</code> or not <code>false</code>. 
		 * For the font to be embedded successfully you need to create a hidden dynamic <code>TextField</code> and manually select the desired 
		 * font and variation, and embed all the glyphs needed. In Flash CS5 you need to embed the font using the
		 * FontEmbedding dialog instead.
		 * 
		 * @default false
		 */
		public function get embedFonts():Boolean
		{
			return _embedFonts;
		}
		
		/**
		 * @private
		 */
		public function set embedFonts(val:Boolean):void
		{
			_embedFonts = val;
			invalidate(DockMenuInvalidationType.LABEL);
		}
		
		private var _barPaddingTop:Number = 3;
		
		/**
		 * The size in pixels of the bar margin placed on top of the icons (if the bar is placed top or bottom) or at the inner side 
		 * (if the bar is placed right or left).
		 * 
		 * @default 3
		 * 
		 * @see #barPaddingBottom
		 * @see #barPaddingSides
		 */
		public function get barPaddingTop():Number
		{
			return _barPaddingTop;
		}
		
		/**
		 * @private
		 */
		public function set barPaddingTop(val:Number):void
		{
			_barPaddingTop = val;
			invalidate(DockMenuInvalidationType.BAR);
		}
			
		private var _barPaddingBottom:Number = 5;
		
		/**
		 * The size in pixels of the bar margin placed at the bottom top of the icons (if the bar is placed top or bottom) or at the outer side 
		 * (if the bar is placed right or left).
		 * 
		 * @default 5
		 * 
		 * @see #barPaddingTop
		 * @see #barPaddingSides
		 */
		public function get barPaddingBottom():Number
		{
			return _barPaddingBottom;
		}
		
		/**
		 * @private
		 */
		public function set barPaddingBottom(val:Number):void
		{
			_barPaddingBottom = val;
			invalidate(DockMenuInvalidationType.BAR);
		}
			
		private var _barPaddingSides:Number = 4;
		
		/**
		 * The size in pixels of the bar margin placed at the sides of the icons.
		 * 
		 * @default 4
		 * 
		 * @see #barPaddingTop
		 * @see #barPaddingBottom
		 */
		public function get barPaddingSides():Number
		{
			return _barPaddingSides;
		}
		
		/**
		 * @private
		 */
		public function set barPaddingSides(val:Number):void
		{
			_barPaddingSides = val;
			invalidate(DockMenuInvalidationType.BAR);
		}
		
		private var _useSelectedIndicator:Boolean = true;
		
		/**
		 * When set to <code>true</code> it shows a small arrow under the selected. The arrow can be skinned. 
		 */
		public function get useSelectedIndicator():Boolean
		{
			return _useSelectedIndicator;
		}
		
		/**
		 * @private
		 */
		public function set useSelectedIndicator(val:Boolean):void
		{
			_useSelectedIndicator = val;
			invalidate(DockMenuInvalidationType.ARROW);
		}
		
		private var _clickEffectAmount:Number = 5;
		
		/**
		 * Specifies the number of times for the click effect animates. 
		 * To change the effect, use the <code>DockMenu.clickEffect</code> property.
		 * 
		 * @default 5
		 * 
		 * @see #clickEffect
		 * @see #clickEffectTime
		 */
		public function get clickEffectAmount():Number
		{
			return _clickEffectAmount;
		}
		
		/**
		 * @private
		 */
		public function set clickEffectAmount(val:Number):void
		{
			_clickEffectAmount = Math.max(val, 1);
		}
		
		private var _clickEffectTime:Number = 300;
		
		/**
		 * The number of milliseconds it takes to animate a single <code>DockMenu.clickEffect</code> cycle. 
		 * To change the effect, use the <code>DockMenu.clickEffect</code> property.
		 * 
		 * @default 600
		 * 
		 * @see #clickEffect
		 * @see #clickEffectAmount
		 */
		public function get clickEffectTime():Number
		{
			return _clickEffectTime * 2;
		}
		
		/**
		 * @private
		 */
		public function set clickEffectTime(val:Number):void
		{
			_clickEffectTime = val / 2;
		}
		
		private var _clickEffect:String = "jump";
		
		/**
		 * A value from the <code>DockMenuEffect</code> class that specifies the effect to perform when an icon is clicked. 
		 * Valid values are <code>DockMenuClickEffect.JUMP</code>, <code>DockMenuClickEffect.GLOW</code>, 
		 * <code>DockMenuClickEffect.FADE</code>, <code>DockMenuClickEffect.SHINE</code>, 
		 * <code>DockMenuClickEffect.BLUR</code>, <code>DockMenuClickEffect.BEVEL</code>, 
		 * and <code>DockMenuClickEffect.NONE</code>. 
		 * The <code>DockMenuClickEffect.NONE</code> value performs no effect. 
		 * 
		 * @default none
		 * 
		 * @see #clickEffectTime
		 * @see #clickEffectAmount
		 * @see DockMenuClickEffect
		 */
		public function get clickEffect():String
		{
			return _clickEffect;
		}
		
		/**
		 * @private
		 */
		public function set clickEffect(val:String):void
		{
			val = val.toLowerCase();
			if(DockMenuClickEffect.isValid(val)){
				_clickEffect = val;
			}
		}
		
		private var _autoHide:Boolean = false;
		
		[Inspectable(name="autoHide", defaultValue=false)]
		/**
		 * Defines whether the component can hide auto automatically when not in use <code>true</code>
		 * or not <code>false</code>. When hidden the bar has an invisible hit area of 10 pixels placed 
		 * in the position defined by the <code>DockMenu.position</code> property.

		 * @default false
		 * 
		 * @see #autoHideTime
		 * @see #hidden
		 */		
		public function get autoHide():Boolean
		{
			return _autoHide;
		}
		
		/**
		 * @private
		 */
		public function set autoHide(val:Boolean):void
		{
			_autoHide = val;
			invalidate(DockMenuInvalidationType.AUTOHIDE);
		}
		
		private var _autoHideTime:Number = 150;
		
		/**
		 * The time in milliseconds it takes for the auto-hide animation to play.
		 * 
		 * @default 150
		 * 
		 * @see #autoHide
		 * @see #hidden
		 */
		public function get autoHideTime():Number
		{
			return _autoHideTime;
		}
		
		/**
		 * @private
		 */
		public function set autoHideTime(val:Number):void
		{
			_autoHideTime = Math.max(val, 1);
		}
		
		private var _captionShadow:Boolean = true;
		
		/**
		 * Indicates whether the icons caption shows a shadow under the text <code>true</code> or not <code>false</code>.
		 * 
		 * @default true
		 * 
		 * @see #captionShadowColor
		 */
		public function get captionShadow():Boolean
		{
			return _captionShadow;
		}
		
		/**
		 * @private
		 */
		public function set captionShadow(val:Boolean):void
		{
			_captionShadow = val;
			invalidate(DockMenuInvalidationType.LABEL);
		}
		
		private var _captionShadowColor:uint = 0x000000;
		
		/**
		 * Indicates the color of the caption shadow.
		 * 
		 * @default 0x000000
		 * 
		 * @see #captionShadow
		 */
		public function get captionShadowColor():uint
		{
			return _captionShadowColor;
		}
		
		/**
		 * @private
		 */
		public function set captionShadowColor(val:uint):void
		{
			_captionShadowColor = val;
			invalidate(DockMenuInvalidationType.LABEL);
		}
						
		/**
		 * Creates a new <code>DockMenu</code> instance.
		 */
		public function DockMenu()
		{
			super();
			
			DockMenu_barSkin;
			DockMenu_selectionSkin;
			
			// Some things can only be calculated once we have a reference to the stage
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
						
			// Initializes a timer to check hidden status every 200 milliseconds delay
			autoHideTimer = new Timer(200);
			autoHideTimer.addEventListener(TimerEvent.TIMER, autoHideTimerHandler);
		}
		
		/**
		 * When DockMenu is added to the stage.
		 */
		private function addedToStageHandler(event:Event):void
		{
			if(stage != null)
			{
				// If our parent is the root or stage
				if(parent == root || parent == stage)
				{
					// Center against the stage size
					stageWidth = stage.stageWidth;
					stageHeight = stage.stageHeight;
					
					offsetX = offsetY = 0;
					
					// Listen to the stage size changes
					stage.addEventListener(Event.RESIZE, stageResizeHandler);
				}
				else 
				{
					// If our parent is any other container
					// Remove ADDED_TO_STAGE handler to avoid an endless loop
					removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

					// Save the current parent
					var savedParent:DisplayObjectContainer = parent;
				
					// Remove from parent to calculate parent's bounds without the DockMenu
					savedParent.removeChild(this);
					
					// Get dimensions 
					stageWidth = savedParent.width;
					stageHeight = savedParent.height;
					
					// Save offset values
					// This values allow DockMenu use any container even if its content 
					// is not aligned with the containers register point.
					offsetX = savedParent.getBounds(savedParent).x;
					offsetY = savedParent.getBounds(savedParent).y;
					
					// Add the DockMenu again and restore the event handler
					savedParent.addChild(this);
					
					addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
				}
				
				// Add a listener to reset component if removed from stage
				addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
				
				if(hitSprite)
				{
					addEventListener(Event.ENTER_FRAME, animationTimerHandler);
				}
				
				// Everything invalidates when DockMenu is added to stage
				// to force complete recalculation
				invalidate(InvalidationType.ALL);
			}
		}
		
		/**
		 * When DockMenu is removed from the stage.
		 */
		private function removedFromStageHandler(event:Event):void
		{
			// Stops the autiHide timer
			autoHideTimer.stop();
			
			// Remove stage resize listener to mark us as Garbage 
			// Collection candidates if no more references exists
			stage.removeEventListener(Event.RESIZE, stageResizeHandler);
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			// Avoid listening to the ENTER_FRAME event if not in Display Hierarchy
			removeEventListener(Event.ENTER_FRAME, animationTimerHandler);
		}

		/**
		 * @inheritDoc
		 * 
		 * @private
		 */
		override protected function configUI():void
		{
			// Ensures base class configuration
			super.configUI();
			
			// Creates an empty DataProvider if none exists
			if(_dataProvider == null) _dataProvider = new DataProvider();

			// The complete DockMenu container
			container = new Sprite();
			addChild(container);
			
			// The DockMenu bar container which will hold the bar skin
			barSprite = new Sprite();
			barSprite.mouseEnabled = barSprite.mouseChildren = false;
			container.addChild(barSprite);
			drawBar();
			
			// An invisible hit sprite to detect all DockMenu mouse events
			hitSprite = new Sprite();
			hitSprite.graphics.beginFill(0);
			hitSprite.graphics.drawRect(0, 0, 100, 100);
			hitSprite.alpha = 0;
			hitSprite.useHandCursor = false;
			hitSprite.addEventListener(MouseEvent.ROLL_OVER, hitAreaMouseHandler);
			hitSprite.addEventListener(MouseEvent.ROLL_OUT, hitAreaMouseHandler);
			hitSprite.addEventListener(MouseEvent.MOUSE_MOVE, hitAreaMouseHandler);
			hitSprite.addEventListener(MouseEvent.CLICK, hitAreaMouseHandler);
			container.addChild(hitSprite);
			
			// Creates the label
			createLabel();
			
			// An invisible hit sprite to manage autoHide behavior
			autohideBar = new Sprite();
			autohideBar.graphics.beginFill(0);
			autohideBar.graphics.drawRect(0, 0, 100, 100);
			autohideBar.alpha = 0;
			autohideBar.visible = false;
			autohideBar.addEventListener(MouseEvent.ROLL_OVER, autohideBarRollOverHandler);
			autohideBar.useHandCursor = false;
			addChild(autohideBar);
		}
		
		/**
		 * @inheritDoc
		 * 
		 * @private
		 */
		override protected function draw():void
		{
			// Stop currently playing hide animations
			if(hideTween)
			{
				hideTween.kill();
			}
			
			// If arrow or styles are invalidated
			if(isInvalid(DockMenuInvalidationType.ARROW) || isInvalid(InvalidationType.STYLES))
			{
				// Draw the arrow and show/hide it
				drawArrow();
				arrow.visible = _useSelectedIndicator && _selectedItem != null;
			}
			
			// If the label is invalidated
			if(isInvalid(DockMenuInvalidationType.LABEL))
			{
				// Set text filters and embed font properties
				textField.embedFonts = _embedFonts;
				labelField.filters = (_captionShadow? 
					[new DropShadowFilter(2, 45, _captionShadowColor, 0.8, 5, 5, 1.5, 1)] : []);
			}
			
			// If the bar or styles are invalidated
			if(isInvalid(DockMenuInvalidationType.BAR) || isInvalid(InvalidationType.STYLES))
			{
				// Draw the bar again and force creation if styles changed
				drawBar(isInvalid(InvalidationType.STYLES));
			}
			
			// If the bar, icons or styles are invalidated
			if(isInvalid(DockMenuInvalidationType.BAR) || isInvalid(DockMenuInvalidationType.ICONS) || isInvalid(InvalidationType.STYLES))
			{
				// set the bar size
				setBarSize();
			}
			
			var i:int;
			
			// If icons are invalidated
			if(isInvalid(DockMenuInvalidationType.ICONS))
			{
				// Save currently selected icon
				var savedSelected:int = -1;
				if(_selectedItem != null)
				{
					savedSelected = _dataProvider.toArray().indexOf(_selectedItem.data);
				}
				
				// Remove previous icons
				if(iconsMc != null)
				{
					container.removeChild(iconsMc);
					iconsMc = null;
				}
				
				// Create the icons again
				iconList = new Array();
				
				iconsMc = new Sprite();
				iconsMc.mouseEnabled = false;
				iconsMc.mouseChildren = false;
				container.addChildAt(iconsMc, 2);
				
				var items:int = _dataProvider.length;
				
				for(i = 0; i < items; i++)
				{
					createIcon();
				}
				
				// Try to re-select the previously selected icon
				if(savedSelected != -1)
				{
					_selectedItem = iconsMc.getChildAt(Math.min(savedSelected, _dataProvider.length - 1)) as DockMenuIconWrapper;
				}
				
				// Calculate the new wave length
				waveLength = _minIconSize * _magnificationSpan;
			}
			
			// If cache is invalidated
			if(isInvalid(DockMenuInvalidationType.CACHE))
			{
				// Refresh icon cache for each icon
				for(i = iconList.length - 1; i >= 0; i--)
				{
					iconList[i].setIconCache(_cacheIcons, _minIconSize, _maxIconSize);
				}
			}
			
			// If icon is invalidated
			if(isInvalid(DockMenuInvalidationType.REFLECTION))
			{
				// Refresh icon reflection in each icon
				for(i = iconList.length - 1; i >= 0; i--)
				{
					iconList[i].setReflection(_showReflection, _minIconSize, _maxIconSize, 
						_reflectionAlpha, _reflectionSize);
				}
			}
			
			// If autohide is invalidated
			if(isInvalid(DockMenuInvalidationType.AUTOHIDE))
			{
				// Reset visibility
				container.x = container.y = 0;
				autohideBar.visible = _autoHide;
				
				// And begin animation if needed
				if(_autoHide)
				{
					animateBarVisibility(!_hidden);
				}
			}
			
			// If the wave effect is invalidated
			if(isInvalid(DockMenuInvalidationType.WAVE_EFFECT))
			{
				// Recalculate the wave size
				magnifiedWaveSize = 0;
				var iconx:Number = _minIconSize / 2;
				var midSize:Number = (_maxIconSize - _minIconSize) / 2;
				
				for(i = 0; iconx < waveLength; i++)
				{
					var percent:Number = iconx / waveLength;
					var size:Number = midSize + Math.cos(percent * Math.PI) * midSize;
					magnifiedWaveSize += _minIconSize + size;
					iconx += _minIconSize;
				}
			}
			
			// Position the arrow
			positionArrow();
			// Add the arrow as a child
			container.addChild(arrow);
			
			super.draw();
		}
		
		/**
		 * Draws the selection arrow or custom image if skinnedS
		 */
		private function drawArrow():void
		{
			if(isInvalid(InvalidationType.STYLES))
			{
				// Remove the previous arrow
				if(arrow != null)
				{
					container.removeChild(arrow);
					arrow = null;
				}
				
				// Recreate it
				var arrowStyle:Object = getStyleValue("selectionSkin")
				if (arrowStyle != null) 
				{ 
					arrow = getDisplayObjectInstance(arrowStyle);
				}
	
				arrow.visible = false;
				
				// Prepare arrow properties
				var iArrow:DisplayObjectContainer = arrow as DisplayObjectContainer;
				if(iArrow != null)
				{
					iArrow.mouseEnabled = iArrow.mouseChildren = false;
				}
				container.addChild(arrow);
			}
		}

		/**
		 * The <code>TextFormat</code> to use for the icon caption.
		 * 
		 * @default Arial, 14pt, bold
		 */
		public function get captionFormat():TextFormat
		{
			return textField.getTextFormat();
		}
		/**
		 * @private
		 */
		public function set captionFormat(val:TextFormat):void
		{
			textField.setTextFormat(val);
			textField.defaultTextFormat = val;
			textField.text = " ";
			textField.x = -textField.width / 2;
			textField.y = -textField.height / 2;
		}
		
		/**
		 * Gets the data for a given icon.
		 *  
		 * @param item The icon to get the data from
		 * 
		 * @return The Object data
		 */
		private function getItemData(item:DockMenuIconWrapper):Object
		{
			return (item != null? item.data : null);
		}
		
		/**
		 *  Handles mouse events for the bar hit area to perform magnification algorithms 
		 */
		private function hitAreaMouseHandler(event:MouseEvent):void{
			switch(event.type){
				case MouseEvent.ROLL_OVER:
					startMagnifyingAnim();
					break;
				case MouseEvent.ROLL_OUT:
					stopMagnifyingAnim();
					rollOutIcon();
					break;
				case MouseEvent.MOUSE_MOVE:
					detectRollOver();
					break;
				case MouseEvent.CLICK:
					selectItem();
					break;
			}
		}
		
		/**
		 * Creates the label to be used for the caption.
		 */
		private function createLabel():void
		{
			// Create the label
			labelField = new Sprite();
			labelField.visible = false;
			labelField.mouseEnabled = labelField.mouseChildren = false;
			container.addChild(labelField);
			
			textField = new TextField();
			labelField.addChild(textField);
			
			textField.selectable = false;
			textField.autoSize = TextFieldAutoSize.CENTER;
			textField.textColor = 0xFFFFFF;
					
			var fmt:TextFormat = new TextFormat();
			fmt.bold = true;
			fmt.font = "Arial";
			fmt.size = 14;
			
			// Center it into the container
			textField.defaultTextFormat = fmt;
			textField.text = " ";
			textField.x = -textField.width / 2;
			textField.y = -textField.height / 2;
		}
		
		/**
		 * Handles each mangification animation  tick. 
		 */
		private function animationTimerHandler(event:Event):void
		{
			magnifierAnimTick();
		}
		
		/**
		 * Handles mouse activation of the autoHide behavior 
		 */
		private function autohideBarRollOverHandler(event:MouseEvent):void
		{
			animateBarVisibility(true);
		}
		
		/**
		 * Starts magnification animation. 
		 * 
		 */
		private function startMagnifyingAnim():void
		{
			// Start magnifying anim to 100%
			var posObj:DockMenuPosition = getPositionObject();
			tweenMagnifyingPercent(1);
			magnifyActive = true;
			// Save last mouse position
			lastMousePos = posObj.getXProp("mouse", container);
			// Set the hit area size as maximized
			setHitAreaSize(_maxIconSize);
			// run the first tick
			magnifierAnimTick();
		}
		
		/**
		 * Stops magnification animation
		 * 
		 */
		private function stopMagnifyingAnim():void
		{
			// Start magnifying anim to 0%
			tweenMagnifyingPercent(0);
			magnifyActive = false;
			// Set hit area size as minimized
			setHitAreaSize(_minIconSize);
			// run the last tick
			magnifierAnimTick();
			
			// If the bar autohides animate dissapearance also
			if(_autoHide)
			{
				animateBarVisibility(false);
			}
		}
		
		/**
		 * Sets hit area size based on maximized/minimized state. 
		 * 
		 * @param h The target height
		 */
		private function setHitAreaSize(h:Number):void
		{
			var posObj:DockMenuPosition = getPositionObject();
			
			// Set the height of the hitSprite (depends on padding bottom)
			posObj.setHeight(hitSprite, h + _barPaddingBottom);
			// Set the autoHide bar height to 10 and ensure it is placed on x = 0
			posObj.setHeight(autohideBar, 10);
			posObj.setX(autohideBar, 0);
			
			// If the bar is hidden
			if(_autoHide && _hidden)
			{
				// Set its y position and stop animations
				var dir:Number = (posObj.isInverse? 1 : -1);
				var end:Number = (_hidden? posObj.getHeight(barSprite) * dir : -1);
				posObj.setY(container, end);
				
				if(hideTween)
				{
					hideTween.kill();
				}
				autoHideTimer.stop();
			}
			
			// If bottom or left do a little different algorithm
			if(!posObj.isInverse)
			{
				posObj.setY(barSprite, -1);
				posObj.setY(autohideBar, -1);
				posObj.setY(arrow, -1 + _barPaddingBottom);
				posObj.setY(this, posObj.getYProp("offset", this));
				arrow.rotation = (posObj.position == DockMenuPosition.TOP)? 180 : 90;
			}
			else 
			{
				posObj.setY(barSprite, posObj.getHeight(hitSprite) - posObj.getHeight(barSprite));
				posObj.setY(autohideBar, posObj.getHeight(hitSprite) - posObj.getHeight(autohideBar));
				posObj.setY(arrow, posObj.getHeight(hitSprite) - _barPaddingBottom);
				posObj.setY(this, posObj.getYProp("offset", this) + 
					posObj.getHeightProp("stage", this) - posObj.getHeight(hitSprite));
				arrow.rotation = (posObj.position == DockMenuPosition.BOTTOM)? 0 : -90;
			}
		}
		
		/**
		 * Starts magnification animation from the current magnification value to a target magnification value.
		 * 
		 * @param val The target magnification value.
		 * 
		 */
		private function tweenMagnifyingPercent(val:Number):void
		{
			// Begin magnification tween
			if(magnifyTween)
			{
				magnifyTween.kill();
			}
			
			magnifying = true;
            magnifyTween = new TweenNano(this, 
			                             _magnificationTime / 1000,
										 { magnifyPercent: val, 
										   ease: Quad.easeOut, 
										   onComplete: magnifyMotionFinishHandler });
		}

		/**
		 * Handles magnification animation fisnished event.
		 * @param event
		 * 
		 */
		private function magnifyMotionFinishHandler():void
		{
			magnifying = false;
		}
		
		/**
		 *  Called every time an icon is created for the first time.
		 * 
		 */
		private function createIcon():void
		{
			// Create an icon
			var id:int = iconList.length;
			var iconData:Object = _dataProvider.getItemAt(id);
			
			var posObj:DockMenuPosition = getPositionObject();
			
			// Set the positiion
			var position:Point = new Point();
			posObj.setX(position, _minIconSize * id);
			posObj.setY(position, (posObj.isInverse?
				posObj.getHeight(barSprite) + posObj.getY(barSprite) - _minIconSize - _barPaddingBottom :
				_barPaddingBottom));
			
			// Set cache properties
			var iconWrapper:DockMenuIconWrapper = new DockMenuIconWrapper(iconData, _minIconSize, position, posObj);
			iconWrapper.setIconCache(_cacheIcons, _minIconSize, _maxIconSize);
			iconsMc.addChild(iconWrapper);
			
			iconList.push(iconWrapper);
		}
				
		/**
		 * Performs the action of selecting a icon
		 * 
		 */
		private function selectItem():void
		{
			var posObj:DockMenuPosition = getPositionObject();
			
			var middleNumber:Number = Math.floor(posObj.getXProp("mouse", container) / _minIconSize);
			if(middleNumber >= iconList.length) middleNumber = iconList.length - 1;
			var middleIcon:DockMenuIconWrapper = iconList[middleNumber];
			
			
			var event:DockMenuEvent = new DockMenuEvent(DockMenuEvent.ICON_CLICK, 
														middleNumber, getItemData(middleIcon), true);
			
			dispatchEvent(event);
			
			if(!event.isDefaultPrevented()){
				_selectedItem = middleIcon;
				
				positionArrow();
				arrow.visible = _useSelectedIndicator;
				
				var sel:Object = _selectedItem.data;
				gotoLink(sel.link, sel.target, sel.linkType);
				
				if(_clickEffect != "none")
				{
					_selectedItem.animate(_clickEffect, _clickEffectTime / 1000, _clickEffectAmount);
				}
			}
		}
		
		/**
		 * Determines the icon placed under the cursor.
		 * 
		 */
		private function detectRollOver():void
		{
			var posObj:DockMenuPosition = getPositionObject();
			var middleNumber:Number = Math.floor(posObj.getXProp("mouse", container) / _minIconSize);
			if(middleNumber >= iconList.length) middleNumber = iconList.length - 1;
			var middleIcon:DockMenuIconWrapper = iconList[middleNumber];
			
			if(middleIcon != rolledItem){
				rollOutIcon();
				
				if(middleIcon != null){
					var data:Object = getItemData(middleIcon);
					rolledItem = middleIcon;
					
					dispatchEvent(new DockMenuEvent(DockMenuEvent.ICON_ROLL_OVER, 
													middleNumber, data, false));
				}
			}
		}
		
		/**
		 *  Performs icon roll out actions.
		 * 
		 */
		private function rollOutIcon():void{
			if(rolledItem != null){
				var data:Object = getItemData(rolledItem);
				rolledItem = null;
				
				dispatchEvent(new DockMenuEvent(DockMenuEvent.ICON_ROLL_OUT, 
												iconList.indexOf(rolledItem), data, false));
			}
		}
		
		/**
		 * Handles bar navigation rules depending on the icon link and target values. 
		 * 
		 * @param link The place to go (frame label, frame number, URL, or image/SWF file)
		 * @param target The target where to load the link (frame, movie clip, etc...).
		 * @param type The type of the icon navigation behavior in case of ambiguity.
		 * 
		 */
		private function gotoLink(link:String, target:String, type:String):void{
			if(!link) return;
			if(!target) target = "";
						
			var pnt:String = (target == ""? "" : ".");
			var isAuto:Boolean = Boolean(!type || type == DockMenuLinkType.AUTO);
			
			if(type == DockMenuLinkType.SWF || (isAuto && isLoadableFileType(link)))
			{
				loadSWFFile(link, target);
			}
			else if(type == DockMenuLinkType.WEB_PAGE || (isAuto && (link.indexOf(".") != -1 || link.indexOf("/") != -1)))
			{
				navigateToLink(link, target);
			}
			else
			{
				playMovie(link, target);
			}
		}
		
		/**
		 * Determines if a link can be loaded based on extension (swf, gif, jpg, png files can be loaded). 
		 * @param link
		 * @return 
		 * 
		 */
		private function isLoadableFileType(link:String):Boolean
		{
			link = link.toLowerCase();
			var fileTypes:Array = [".swf", ".jpg", ".gif", ".png"];
			for(var i:int = 0; i < fileTypes.length; i++)
			{
				if(link.toLowerCase().indexOf(fileTypes[i]) != -1)
				{
					return true;
				}
			}
			return false;
		}
		
		private var _commonLoaders:Dictionary = new Dictionary();
		
		/**
		 * Load an SWF file in link on the target movie clip.
		 * 
		 * @param link SWF file URL to load.
		 * @param target Movie clip instance name into which to load the SWF file.
		 * 
		 */
		private function loadSWFFile(link:String, target:String):void
		{
			// If we have an SWF file
			var objDisplay:DisplayObject = getDisplayObject(target);
			
			if(objDisplay)
			{
				var loader:Loader = null;
				
				if(objDisplay is Loader)
				{
					loader = (objDisplay as Loader);
					trace("loader");
				}
				else if(objDisplay is DisplayObjectContainer)
				{
					if(_commonLoaders == null)
					{
						_commonLoaders = new Dictionary();
					}
					
					var displayContainer:DisplayObjectContainer = objDisplay as DisplayObjectContainer;
					
					loader = _commonLoaders[objDisplay];
					
					if(loader == null)
					{
						loader = _commonLoaders[objDisplay] = new Loader();
						displayContainer.addChild(loader);
					}
				}
				
				if(loader)
				{
					var request:URLRequest = new URLRequest(link);
					loader.load(request);
				}
			}
		}
		
		/**
		 * Naviates to an HTTP link.
		 * @param link The HTTP URL link to go to.
		 * @param target The target window or frame into which to load the page.
		 * 
		 */
		private function navigateToLink(link:String, target:String):void
		{
			// If we have an HTML or else web page or object
			if(target == "") target = "_self";
			var request:URLRequest = new URLRequest(link);
			navigateToURL(request, target);
		}
		
		/**
		 * Play a movie clip set by target to a frame or label.
		 * @param link The frame or label to navigate to.
		 * @param target The path of the clip to execute navigation.
		 * 
		 */
		private function playMovie(link:String, target:String):void
		{
			// Else if we have a movieclip
			var objDisplay:MovieClip = getDisplayObject(target) as MovieClip;
			
			if(objDisplay != null)
			{
				var isPlay:Boolean = link.charAt(link.length - 1) == "+";
				
				if(isPlay) link = link.slice(0, -1);
				
				if(isNaN(Number(link)))
				{
					if(isPlay)
					{
						objDisplay.gotoAndPlay(link);
					}
					else
					{
						objDisplay.gotoAndStop(link);
					}
				}
				else
				{
					if(isPlay)
					{
						objDisplay.gotoAndPlay(Number(link));
					}
					else
					{
						objDisplay.gotoAndStop(Number(link));
					}
				}
			} 
		}
		
		/**
		 * Parse a path into a real display object instance
		 * @param str The absolute or relative path of a DisplayOject.
		 * @return The current instance reference or null if not found.
		 * 
		 */
		private function getDisplayObject(str:String):DisplayObject
		{
			if(!str)
			{
				return null;
			}
			
			var strParts:Array = str.split(".");
			var i:int = 0;
			var target:DisplayObject = parent;
			
			do
			{
				var tempTarget:DisplayObject = target[strParts[i]];
				if(tempTarget == null)
				{
					return null;
				}
				target = tempTarget;
				i++;
			}while(i < strParts.length);
			
			return target;
		}
				
		/**
		 * Performs a single magnification animation tick.
		 */
		private function magnifierAnimTick():void{
			var posObj:DockMenuPosition = getPositionObject();
			
			if(magnifyActive || magnifying){
				if(magnifyActive) {
					lastMousePos = posObj.getXProp("mouse", container);
				}
				
				// Limits
				if(lastMousePos < 0) lastMousePos = 0;
				if(lastMousePos > posObj.getWidth(hitSprite) - 1) 
					lastMousePos = posObj.getWidth(hitSprite) - 1;
				
				// Calculate middle size
				var midSize:Number = ((_maxIconSize - _minIconSize) / 2);
				
				// Determines the middle icon and its size
				var middleNumber:Number = Math.floor(lastMousePos / _minIconSize);
				var middleIcon:DockMenuIconWrapper = iconList[middleNumber];
				
				setIconSize(middleIcon, lastMousePos - middleIcon.middlePosition, midSize);
				
				// Determines the position of the middle icon
				var initPos:Number = middleIcon.middlePosition - (_minIconSize / 2);
				posObj.setX(middleIcon, lastMousePos + ((initPos - lastMousePos) * 
								   (middleIcon.width / _minIconSize)));
				
				// New bar width
				var percentWave:Number = magnifiedWaveSize * 2;
				var barW:Number = posObj.getWidth(hitSprite) - (waveLength * 2) + percentWave;
				var initX:Number = (posObj.getWidth(hitSprite) - barW) / 2;
						
				var prevIconPos:Number = posObj.getX(middleIcon);
				var len:Number = iconList.length;
				
				for(var i:Number = middleNumber - 1; i >= 0; i--){
					var dx:Number = lastMousePos - iconList[i].middlePosition;
					
					setIconSize(iconList[i], lastMousePos - iconList[i].middlePosition, midSize);
					
					if(dx > waveLength && !magnifying){
						posObj.setX(iconList[i], initX + (i * _minIconSize));
					}
					else {
						prevIconPos -= iconList[i].width;
						posObj.setX(iconList[i], prevIconPos);
					}
				}
				
				initX += barW;
				prevIconPos = posObj.getX(middleIcon);
				var prevIconSize:Number = middleIcon.width;
				
				for(i = middleNumber + 1; i < len; i++){
					dx = iconList[i].middlePosition - lastMousePos;
					
					setIconSize(iconList[i], lastMousePos - iconList[i].middlePosition, midSize);
					
					if(dx > waveLength && !magnifying){
						posObj.setX(iconList[i], initX - ((len - i) * _minIconSize));
					}
					else {
						prevIconPos += prevIconSize;
						posObj.setX(iconList[i], prevIconPos);
						prevIconSize = iconList[i].width;
					}
				}
				var iconData:Object = middleIcon.data;
				
				// Position label
				var dif:Number = _maxIconSize - _minIconSize;
				labelField.visible = magnifyActive;
				textField.text = iconData.caption;
				textField.x = -textField.width / 2;
				
				posObj.setX(labelField, posObj.getX(middleIcon) + (middleIcon.width / 2));
				posObj.setY(labelField, (posObj.isInverse?
					dif - (dif * magnifyPercent) - (posObj.getHeight(labelField) / 2) :
					_barPaddingBottom + _minIconSize + (dif * magnifyPercent) + 
					(posObj.getHeight(labelField) / 2)));
				
				// Position Arrow
				positionArrow();
				
				// Position Bar
				posObj.setX(barSprite, posObj.getX(iconList[0]) - _barPaddingSides);
				/*posObj.setWidth(barSprite, posObj.getX(iconList[len - 1]) + iconList[len - 1].width - 
								  posObj.getX(barSprite) + _barPaddingSides);*/
				setSkinWidth(posObj.getX(iconList[len - 1]) + iconList[len - 1].width - 
					posObj.getX(barSprite) + _barPaddingSides);
			}
		}
		
		private function setSkinWidth(size:Number):void
		{
			var posObj:DockMenuPosition = getPositionObject();
			
			barSkin.rotation = 0;
			
			barSkin.width = size;
			
			if(posObj.isVertical)
			{
				barSkin.rotation = (posObj.isInverse? 0 : 180);
			}
			else
			{
				barSkin.rotation = (posObj.isInverse? 270 : 90);
			}
			
			barSkin.x = barSkin.y = 0;
			var rect:Rectangle = barSkin.getRect(barSprite);
			barSkin.x = -rect.left;
			barSkin.y = -rect.top;
		}
		
		private function setSkinHeight(size:Number):void
		{
			var posObj:DockMenuPosition = getPositionObject();
			
			barSkin.rotation = 0;
			
			barSkin.height = size;
			
			if(posObj.isVertical)
			{
				barSkin.rotation = (posObj.isInverse? 0 : 180);
			}
			else
			{
				barSkin.rotation = (posObj.isInverse? 270 : 90);
			}
			
			barSkin.height = size;
			
			barSkin.x = barSkin.y = 0;
			var rect:Rectangle = barSkin.getRect(barSprite);
			barSkin.x = -rect.left;
			barSkin.y = -rect.top;
		}
		
		/**
		 * Called for each icon to calculate its size and position based on magnification percent and cursor distance.
		 * @param icon The icon to size.
		 * @param dx The distance from the cursor position to the icon.
		 * @param midSize The size/2 of the icon.
		 * 
		 */
		private function setIconSize(icon:DockMenuIconWrapper, dx:Number, midSize:Number):void{
			var finalSize:Number;
			var absdist:Number = Math.abs(dx);
			var percent:Number = absdist / waveLength;
			var posObj:DockMenuPosition = getPositionObject();
			
			if(percent > 1) {
				finalSize = _minIconSize;
			}
			else {
				var size:Number = midSize * (1 + Math.cos(percent * Math.PI));
				finalSize = _minIconSize + (size * magnifyPercent);
			}
			
			icon.width = icon.height = finalSize;
			
			posObj.setY(icon, (posObj.isInverse? 
				posObj.getHeight(hitSprite) - 
				posObj.getHeight(icon) - _barPaddingBottom :
				_barPaddingBottom));
		}
				
		/**
		 * Positions the arrow correclty.
		 * 
		 */
		private function positionArrow():void{
			var posObj:DockMenuPosition = getPositionObject();
			
			if(_selectedItem != null){
				posObj.setX(arrow, posObj.getX(_selectedItem) + 
					(posObj.getWidth(_selectedItem) / 2));
			}
		}
		
		/**
		 * Sets the bar size.
		 */
		private function setBarSize():void{
			var posObj:DockMenuPosition = getPositionObject();
			
			setSkinHeight(_minIconSize + _barPaddingTop + _barPaddingBottom);
			posObj.setX(barSprite, -_barPaddingSides);
			posObj.setWidth(hitSprite, (_dataProvider.length * _minIconSize));
			posObj.setWidth(autohideBar, posObj.getWidth(hitSprite));
			setSkinWidth(posObj.getWidth(hitSprite) + (_barPaddingSides * 2));
			posObj.setX(this, 
				posObj.getXProp("offset", this) + 
				(posObj.getWidthProp("stage", this) - posObj.getWidth(hitSprite)) / 2);
			setHitAreaSize(_minIconSize);
			
			if(iconsMc != null)
			{
				for(var i:int = 0; i < iconsMc.numChildren; i++)
				{
					posObj.setY(iconsMc.getChildAt(i), (posObj.isInverse? 
						posObj.getHeight(hitSprite) - 
						posObj.getHeight(iconList[i]) - _barPaddingBottom :
						_barPaddingBottom));
				}
			}
		}
		
		/**
		 * Animated bar visibility when autoHide is true.
		 * @param val Whether to show or hide the bar.
		 * 
		 */
		private function animateBarVisibility(val:Boolean):void{
			var posObj:DockMenuPosition = getPositionObject();
			autoHideTimer.stop();
			
			_hidden = !val;
			autohideBar.visible = _hidden;
			
			var dir:Number = (posObj.isInverse? 1 : -1);
			var end:Number = (_hidden? posObj.getHeight(barSprite) * dir : 0);
			var easing:Ease = (_hidden? Quad.easeIn : Quad.easeOut);
			
			if(hideTween){
				hideTween.kill();
			}
			
			var props:Object = {
				ease: easing
			};
			props[posObj.getYName()] = end;
			
			hideTween = new TweenNano(container, _autoHideTime / 1000, props);
			
			if(!_hidden){
				autoHideTimer.reset();
				autoHideTimer.start();
			}
		}
		
		/**
		 * Handles show/hide animation handler.
		 * @param event
		 * 
		 */
		private function autoHideTimerHandler(event:Event):void{
			if(!hitSprite.hitTestPoint(stage.mouseX, stage.mouseY)){
				animateBarVisibility(false);
			}
		}
		
		/**
		 * Draws the bar or its custom skin if defined.
		 * @param newBar Determines whether the method is forced to create a new bar or not.
		 */
		private function drawBar(newBar:Boolean = true):void
		{
			// If forced to create or if skin has not been created create a new one
			if(newBar || barSkin == null)
			{
				// Remove previous skin
				if(barSkin != null)
				{
					barSprite.removeChild(barSkin);
					barSkin = null;
				}
				
				// Create the new skin
				var barStyle:Object = getStyleValue("barSkin");
				if (barStyle != null) 
				{ 
					barSkin = getDisplayObjectInstance(barStyle);
				}
				barSprite.addChild(barSkin);
			}
			
			var rect:Rectangle;
			var posObj:DockMenuPosition = getPositionObject();
			
			try {
				barSkin["drawBar"](_borderColor, _borderAlpha, _barColor, _barAlpha);
			}
			catch(e:Error){}

			if(posObj.isVertical)
			{
				barSkin.rotation = (posObj.isInverse? 0 : 180);
			}
			else
			{
				barSkin.rotation = (posObj.isInverse? 270 : 90);
			}

			barSkin.x = barSkin.y = 0;
			barSkin.scaleX = barSkin.scaleY = 1;
			rect = barSkin.getRect(barSprite);
			barSkin.x = -rect.left;
			barSkin.y = -rect.top;			
		}
		
		/**
		 * When the stage has changed its size.
		 */
		private function stageResizeHandler(event:Event):void{
			// Update stage size values and invalidate the component
			stageWidth = stage.stageWidth;
			stageHeight = stage.stageHeight;
			invalidate(DockMenuInvalidationType.ICONS);
		}
	}
}