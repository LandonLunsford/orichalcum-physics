package orichalcum.physics.body.geometry
{
	import orichalcum.physics.collision.detection.filter.AABBIntersectionCollisionFilter;
	
	public class Point implements IGeometry
	{
		protected var _x:Number;
		protected var _y:Number;
		protected var _bounds:AABB = new AABB;
		
		public function Point(x:Number = 0, y:Number = 0)
		{
			this.x = x;
			this.y = y;
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
			return _x;
		}
		
		public function get centerY():Number
		{
			return _y;
		}
		
		public function get volume():Number
		{
			return 0;
		}
		
		public function get inertia():Number
		{
			return 0;
		}
		
		public function get inverseInertia():Number
		{
			return 0;
		}
		
		public function get bounds():AABB
		{
			_bounds.x = x;
			_bounds.y = y;
			_bounds.width = 0;
			_bounds.height = 0;
			return _bounds;
		}
	
		public function translate(x:Number, y:Number, rotation:Number = 0):void 
		{
			this.x += x;
			this.y += y;
		}
		
		public function toString():String
		{
			return '{'
				+ 'x:"' + x.toFixed(1)
				+ ', y:' + y.toFixed(1)
				+ '}';
		}
		
	}

}