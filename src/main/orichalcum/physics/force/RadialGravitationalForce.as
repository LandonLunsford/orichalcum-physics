package orichalcum.physics.force 
{
	import orichalcum.physics.IBody;

	public class RadialGravitationalForce implements IForce
	{
		
		private var _value:Number;
		
		public function RadialGravitationalForce(value:Number = 1) 
		{
			_value = value;
		}
		
		public function get value():Number 
		{
			return _value;
		}
		
		public function set value(value:Number):void 
		{
			_value = value;
		}
		
		public function apply(body:IBody):void 
		{
			
		}
		
	}

}