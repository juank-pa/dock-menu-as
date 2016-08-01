package  {
	
	import flash.display.Sprite;
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.geom.Rectangle;
	
	
	public class DockMenu_barSkin extends Sprite {
		
		private var shape:Shape;
		private var shapeMask:Shape;
		
		public function DockMenu_barSkin() 
		{			
			createGlass();
			createMask();
			
			blendMode = BlendMode.LAYER;
		}
		
		private function createMask():void
		{
			shapeMask = new Shape();
			
			var bevel:Number = 15;
			var beginY:Number = 35;
			
			var graph:Graphics = shapeMask.graphics;
			graph.beginFill(0, 0);
			graph.drawRect(0, 0, 100, 100);
			
			graph.beginFill(0xFFFFFF);
			graph.moveTo(bevel, beginY);
			graph.lineTo(100 - bevel, beginY);
			graph.lineTo(100, 100);
			graph.lineTo(0, 100);
			graph.lineTo(bevel, beginY);
			
			shapeMask.scale9Grid = new Rectangle(bevel, 0.25, 100 - (bevel * 2), 100 - 0.5);
			
			shapeMask.blendMode = BlendMode.ALPHA;
			
			addChild(shapeMask);
		}
		
		private function createGlass():void
		{
			shape = new Shape();
			var graph:Graphics = shape.graphics;
			
			graph.beginFill(0, 0);
			graph.drawRect(0, 0, 100, 100);
			
			var curveDist:Number = 30;
			var beginY:Number = 35;
			var middleY:Number = 68;
			var endY:Number = 98;
			
			var beginX:Number = 0;
			var endX:Number = 100;
			var widthQuarter:Number = endX / 4;
			
			graph.beginFill(0xFFFFFF, 0.25);
			graph.moveTo(beginX, beginY);
			graph.lineTo(endX, beginY);
			graph.lineTo(endX, middleY);
			graph.curveTo(widthQuarter * 3, middleY + curveDist, widthQuarter * 2, middleY);
			graph.curveTo(widthQuarter, middleY - curveDist, 0, middleY);
			graph.lineTo(beginX, beginY);
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(endX, endY - beginY, (90 + 30) * Math.PI / 180, 0, beginY + ((endY - beginY) / 2));
			graph.beginGradientFill(GradientType.LINEAR, [0xFFFFFF, 0xFFFFFF],
				[0.6, 0.07], [0, 0xFF], matrix, "pad");
						
			graph.lineTo(beginX, middleY);
			graph.curveTo(widthQuarter, middleY - curveDist, widthQuarter * 2, middleY);
			graph.curveTo(widthQuarter * 3, middleY + curveDist, endX, middleY);
			graph.lineTo(endX, endY);
			graph.lineTo(beginX, endY);
			graph.lineTo(beginX, middleY);
			
			graph.beginFill(0xFFFFFF);
			graph.drawRect(0, endY, endX, 2);
			
			addChild(shape);
		}
		
		override public function get width():Number
		{
			return shape.width;
		}
		override public function set width(val:Number):void
		{
			shape.width = shapeMask.width = val;
		}
		
		override public function get height():Number
		{
			return shape.height;
		}
		override public function set height(val:Number):void
		{
			shape.height = shapeMask.height = val;
		}
		
		override public function get scaleX():Number
		{
			return shape.scaleX;
		}
		override public function set scaleX(val:Number):void
		{
			shape.scaleX = shapeMask.scaleX = val;
		}
		
		override public function get scaleY():Number
		{
			return shape.scaleY;
		}
		override public function set scaleY(val:Number):void
		{
			shape.scaleY = shapeMask.scaleY = val;
		}
	}
	
}
