package com.jk.controls
{
	/**
	 * A class that provides constant values for the <code>DockMenu</code> clickEffect property. 
     * @author Juan Carlos Pazmiño
	 * 
	 * @see DockMenu#clickEffect
	 */
	public class DockMenuClickEffect
	{
		private static const clickEffectHash:Object = {
														  none:1,
														  glow:1,
														  fade:1,
														  jump:1,
														  shine:1,
														  blur:1,
														  bevel:1
													   };
		
		/**
		 * Prevents an effect from playing when an icon is clicked.
		 */
		public static const NONE:String = "none";
		
		/**
		 * Plays an glowing effect when an icon is clicked.
		 */
		public static const GLOW:String = "glow";
		
		/**
		 * Plays an fading effect when an icon is clicked.
		 */
		public static const FADE:String = "fade";
		
		/**
		 * Makes the icon jump when it is clicked.
		 */
		public static const JUMP:String = "jump";
		
		/**
		 * Makes the icon shine when it is clicked.
		 */
		public static const SHINE:String = "shine";
		
		/**
		 * Plays an blur effect when an icon is clicked.
		 */
		public static const BLUR:String = "blur";
		
		/**
		 * Plays an bevel effect when an icon is clicked.
		 */
		public static const BEVEL:String = "bevel";
		
		/**
		 *  @private
		 */
		public static function isValid(effect:String):Boolean{
			return (clickEffectHash[effect] != null);
		}
	}
}