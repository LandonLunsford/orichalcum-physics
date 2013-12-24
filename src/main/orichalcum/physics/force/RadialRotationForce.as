package orichalcum.physics.force 
{
	import orichalcum.mathematics.Mathematics;
	import orichalcum.physics.body.geometry.IGeometry;
	import orichalcum.physics.body.geometry.Point;
	import orichalcum.physics.IBody;
	import orichalcum.utility.MathUtil;

	public class RadialRotationForce implements IForce
	{
		
		private var _point:Point;
		
		public function RadialRotationForce(point:Point) 
		{
			_point = point;
		}
		
		public function get point():Point 
		{
			return _point;
		}
		
		public function apply(body:IBody):void 
		{
			body.rotation = Math.atan2(point.y - body.centerY, point.x - body.centerX) * Mathematics.RADIAN_TO_DEGREE - 90;
			body.angularVelocity = 0;
		}
		
	}

}