package orichalcum.physics.body.geometry 
{

	public class Circle extends Point
	{
		
		protected var _radius:Number;
		
		public function Circle(x:Number = 0, y:Number = 0, radius:Number = 0) 
		{
			this.x = x; 
			this.y = y;
			this.radius = radius;
		}
		
		public function get radius():Number 
		{
			return _radius;
		}
		
		public function set radius(value:Number):void 
		{
			_radius = value;
		}
		
		public function get diameter():Number
		{
			return _radius * 2;
		}
		
		public function set diameter(value:Number):void
		{
			_radius = value * 0.5;
		}
		
		override public function get volume():Number 
		{
			return Math.PI * _radius * _radius;
		}
		
		override public function get inertia():Number 
		{
			return Math.PI * 0.25 * _radius * _radius * _radius * _radius;
		}
		
		override public function get inverseInertia():Number 
		{
			if (_radius == 0) return 0;
			return 1 / inertia;
		}
		
		override public function get bounds():AABB 
		{
			_bounds.x = x - radius;
			_bounds.y = y - radius;
			_bounds.width = diameter;
			_bounds.height = _bounds.width;
			return _bounds;
		}
		
	}

}