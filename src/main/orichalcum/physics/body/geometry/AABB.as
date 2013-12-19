package orichalcum.physics.body.geometry 
{
	import orichalcum.geometry.Geometry2;

	public class AABB implements IGeometry
	{
		protected var _x:Number;
		protected var _y:Number;
		protected var _width:Number;
		protected var _height:Number;
		
		public function AABB(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0) 
		{
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
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
		
		public function get centerX():Number 
		{
			return x + halfWidth;
		}
		
		public function get centerY():Number 
		{
			return y + halfHeight;
		}
		
		public function get volume():Number 
		{
			return _width * _height;
		}
		
		public function get inertia():Number 
		{
			return _width * _height * _height * _height / 12;
		}
		
		public function get inverseInertia():Number 
		{
			if (_width == 0 || _height == 0) return 0;
			return 1 / inertia;
		}
		
		public function get bounds():AABB 
		{
			return this;
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
		
		public function get halfWidth():Number
		{
			return _width * 0.5;
		}
		
		public function set halfWidth(value:Number):void
		{
			_width = value * 2;
		}
		
		public function get halfHeight():Number
		{
			return _height * 0.5;
		}
		
		public function set halfHeight(value:Number):void
		{
			_height = value * 2;
		}
		
		public function get top():Number
		{
			return _y;
		}
		
		public function get bottom():Number
		{
			return _y + _height;
		}
		
		public function get left():Number
		{
			return _x;
		}
		
		public function get right():Number
		{
			return _x + _width;
		}
		
		public function translate(x:Number, y:Number, rotation:Number = 0):void 
		{
			this.x += x;
			this.y += y;
		}
		
		public function intersects(aabb:AABB):Boolean
		{
			return right >= aabb.left
				&& left <= aabb.right
				&& bottom >= aabb.top
				&& top <= aabb.bottom;
		}
		
	}

}