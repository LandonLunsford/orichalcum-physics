package orichalcum.geometry 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Rectangle2 implements IGeometry2
	{
		private var _x:Number;
		private var _y:Number;
		private var _width:Number;
		private var _height:Number;
		
		public function Rectangle2(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0)
		{
			this.height = height;
			this.width = width;
			this.y = y;
			this.x = x;
		}
		
		public function get x():Number 
		{
			return _x;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
		}
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function set width(value:Number):void 
		{
			_width = value;
		}
		
		public function get height():Number 
		{
			return _height;
		}
		
		public function set height(value:Number):void 
		{
			_height = value;
		}
		
		public function getCenter(flyweight:Point2 = null):Point2
		{
			if (!flyweight) flyweight = new Point2;
			return flyweight.setTo(x + width * 0.5, y + height * 0.5);
		}
		
		public function get area():Number
		{
			return height * width;
		}
		
		public function translate(x:Number, y:Number, rotation:Number = 0):void
		{
			this.x += x;
			this.y += y;
		}
		
	}
}