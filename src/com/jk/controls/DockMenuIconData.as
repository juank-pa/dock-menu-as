package com.jk.controls{
	
	/**
	 * This class allows setting DockMenu data easily from the Component Inspector panel.
	 * For more information see the DockMenu.dataProvider description.
     * @author Juan Carlos Pazmiño
	 * @private
	 */
	dynamic public class DockMenuIconData
	{
		private var _class:Object = "";
		
		/**
		 * Is the Class name of a movie clip (DisplayObject) in the library that will be used as the icon image 
		 * (for information on creating you icons see Using the DockMenu component). 
		 * The icon can be also set to a <code>DisplayObject</code> instance using ActionScript code (see <code>DockMenu.dataProvider</code>).
		 */
		[Inspectable(name="icon", defaultValue="", type="String")]
		public function get icon():Object
		{
			return _class;
		}
		/**
		 * @private
		 */
		public function set icon(val:Object):void
		{
			if(val != null) _class = val;
		}
		
		private var _caption:String = "";
		
		/**
		 * Is the label that will appear near the icon. You can omit this value if you don't want any label.
		 */
		[Inspectable(name="caption", defaultValue="")]
		public function get caption():String
		{
			return _caption;
		}
		/**
		 * @private
		 */
		public function set caption(val:String):void
		{
			if(val != null) _caption = val;
		}
		
		private var _link:String = "";
		
		/**
		 * Specifies the action to be performed when a button is clicked. 
		 * What the menu will do depends on this value and the target property also. If no link is specified no 
		 * action will be accomplished but you can still listen to the <code>click</code> event programmatically.
		 */
		[Inspectable(name="link", defaultValue="")]
		public function get link():String
		{
			return _link;
		}
		/**
		 * @private
		 */
		public function set link(val:String):void
		{
			if(val != null) _link = val;
		}
		
		private var _target:String = "";
		
		/**
		 * Is the object that will perform the action specified by link:
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
		 */
		[Inspectable(name="target", defaultValue="")]
		public function get target():String
		{
			return _target;
		}
		/**
		 * @private
		 */
		public function set target(val:String):void
		{
			if(_target != null) _target = val;
		}
		
		private var _linkType:String = DockMenuLinkType.AUTO;

		/**
		 * Is the link type that allows changing how the link and target data are interpreted 
		 * by <code>DockMenu</code>. Normally you would not change this property but sometimes this property allows <code>DockMenu</code> to 
		 * choose the right behavior when in doubt.
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
		 */
		[Inspectable(name="linkType", defaultValue="auto", enumeration="auto,swf,webpage,movieclip")]
		public function get linkType():String
		{
			return _linkType;
		}
		/**
		 * @private
		 */
		public function set linkType(val:String):void
		{
			if(DockMenuLinkType.isValid(val))
			{
				_linkType = val;
			}
		}
		
		/**
		 * Creates a DockMenuIconData instance and initializes the object with all data 
		 * @param icon
		 * @param caption
		 * @param link
		 * @param target
		 * @param linkType
		 */
		public function DockMenuIconData(icon:Object = null, caption:String = "", link:String = "",
										 target:String = "", linkType:String = "auto"):void
		{
			this.icon = icon;
			this.caption = caption;
			this.link = link;
			this.target = target;
			this.linkType = linkType;
		}
		
		/**
		 * Converts the object to its String representation 
		 * @return A String representing the object
		 */
		public function toString():String {
			var str:String = "[DockMenuIconData icon=" + icon + ", caption=" + caption + 
				", link=" + link + ", linkType=" + linkType + ", target=" + target + "]";
			return str;
		}
	}
}