package orichalcum.physics.material 
{
	import orichalcum.mathematics.Mathematics;

	public class Material implements IMaterial
	{
		static public const friction:Number = 0.9
		static public const STATIC:IMaterial = new Material(0, 0.4, 0);
		static public const ROCK:IMaterial = new Material(friction, 0.1, 0.6);
		static public const WOOD:IMaterial = new Material(friction, 0.2, 0.3);
		static public const METAL:IMaterial = new Material(friction, 0.05, 1.2);
		static public const BOUNCY_BALL:IMaterial = new Material(friction, 0.8, 0.3);
		static public const SUPER_BALL:IMaterial = new Material(friction, 0.95, 0.3);
		static public const PILLOW:IMaterial = new Material(friction, 0.2, 0.1);
		
		private var _friction:Number;
		private var _elasticity:Number;
		private var _density:Number;
		
		public function Material(friction:Number = 1, elasticity:Number = 0, density:Number = 1) 
		{
			this.friction = friction;
			this.elasticity = elasticity;
			this.density = density;
		}
		
		public function get friction():Number 
		{
			return _friction;
		}
		
		public function set friction(value:Number):void 
		{
			_friction = Mathematics.clamp(value, 0, Number.MAX_VALUE);
		}
		
		public function get elasticity():Number 
		{
			return _elasticity;
		}
		
		public function set elasticity(value:Number):void 
		{
			_elasticity = Mathematics.clamp(value, 0, Number.MAX_VALUE);
		}
		
		public function get density():Number 
		{
			return _density;
		}
		
		public function set density(value:Number):void 
		{
			_density = Mathematics.clamp(value, 0, Number.MAX_VALUE);
		}
		
	}

}