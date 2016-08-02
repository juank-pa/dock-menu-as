/**
 * @exampleText The following code creates 15 icons (by repeating only 3 different types of icon).
 * For this example to work you need a movie clip in the library exported for ActionScript with a
 * class name of MyIconClass and a PNG file called iconsBig.png with a size of is 48x48 pixels. 
 * If you prefer you can change the corresponding data with whatever suites your needs.
 */
package
{
	import com.jk.controls.DockMenu;
	
	import flash.display.GradientType;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	
	public class DockMenuSample extends Sprite
	{
		public var my_menu:DockMenu;
		
		public function DockMenuSample():void{
			my_menu = new DockMenu();
			
			for(var i:int = 0; i < 5; i++)
			{
				// Add an icon from an item in the Library (use the Class or class name)
				my_menu.dataProvider.addItem({icon:MyIconClass, caption:"Class Icon", link:"http://www.google.com"});
				
				// Add an icon from an instance of a Shape
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
				my_menu.dataProvider.addItem({icon:sp, caption:"Shape Icon", link:"http://www.google.com", target:"_blank"});
				
				
				// Add an icon from a Loader
				var container:Sprite = new Sprite();
				// Draw an invisible shape the size of the image
				// The DockMenu needs to know the size ahead of time but Loader
				// will not know it until the image is loaded.
				with(container.graphics)
				{
					beginFill(0, 0);
					drawRect(0, 0, 48, 48);
				}
				var loader:Loader = new Loader();
				loader.load(new URLRequest("iconsBig.png"));
				container.addChild(loader);
				my_menu.dataProvider.addItem({icon:container, caption:"Shape Icon", link:"http://www.your_site.com"});
			}
			
			addChild(my_menu);
		}
	}
}