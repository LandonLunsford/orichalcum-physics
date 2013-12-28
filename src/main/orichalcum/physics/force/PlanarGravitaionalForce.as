package orichalcum.physics.force 
{
	import orichalcum.physics.body.IBody;
	import orichalcum.physics.geometry.Point;

	public class PlanarGravitaionalForce implements IForce
	{
		
		private var _value:Point;
		
		public function PlanarGravitaionalForce(value:Point) 
		{
			_value = value;
		}
		
		public function get value():Point 
		{
			return _value;
		}
		
		public function set value(value:Point):void 
		{
			_value = value;
		}
		
		public function apply(body:IBody):void 
		{
			body.linearVelocityX += value.x;
			body.linearVelocityY += value.y;
			trace('gravity application')
		}
		
	}

}