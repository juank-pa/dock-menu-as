package com.jk.controls {
	/**
	 * A class that provides constant values for the <code>DockMenu</code> icons linkType property. 
     * @author Juan Carlos Pazmiño
	 * 
	 * @see DockMenu#dataProvider
	 */
	public class DockMenuLinkType
	{
		private static const typeHash:Object = {
												  auto:1,
												  swf:1,
												  webpage:1,
												  movieclip:1
											   };
		
		/**
		 * Let's the link and target be interpreted by the DockMenu default rules.
		 * 
		 * @see DeockMenu.dataProvider
		 */
		public static const AUTO:String = "auto";
		/**
		 * Interprets the link and target as loading a SWF (link) into a movie clip (target).
		 */
		public static const SWF:String = "swf";
		/**
		 * Interprets the link and target as web page (link) into a window or frame (target).
		 */
		public static const WEB_PAGE:String = "webpage";
		/**
		 * Interprets the link and target as playing moving the playhead to a frame or label (link) inside a movie clip (target).
		 */
		public static const MOVIE_CLIP:String = "movieclip";
		
		/**
		 * @private
		 */
		public static function isValid(type:String):Boolean{
			return (typeHash[type] != null);
		}
	}
}