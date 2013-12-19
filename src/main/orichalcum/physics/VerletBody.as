package orichalcum.physics 
{
	import orichalcum.geometry.IGeometry2;
	import orichalcum.mathematics.Mathematics;
	import orichalcum.physics.body.geometry.Circle;
	import orichalcum.physics.body.geometry.IGeometry;
	import orichalcum.physics.body.material.IMaterial;
	import orichalcum.physics.body.material.Material;
	import orichalcum.physics.force.IForce;


	public class VerletBody implements IBody
	{
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _rotation:Number = 0;
		private var _previousX:Number = 0;
		private var _previousY:Number = 0;
		private var _previousRotation:Number = 0;
		private var _changed:Boolean = true;
		private var _geometry:IGeometry;
		private var _material:IMaterial;
		private var _centerX:Number;
		private var _centerY:Number;
		private var _forces:Vector.<IForce> = new Vector.<IForce>;
		
		public function VerletBody(geometry:IGeometry = null, material:IMaterial = null) 
		{
			this.geometry = geometry ? geometry : new Circle(0,0,1);
			this.material = material ? material : Material.ROCK;
		}
		
		public function get x():Number 
		{
			return _geometry.x;
		}
		
		public function set x(value:Number):void 
		{
			_geometry.x = value;
		}
		
		public function get y():Number 
		{
			return _geometry.y;
		}
		
		public function set y(value:Number):void 
		{
			_geometry.y = value;
		}
		
		public function get rotation():Number 
		{
			return _rotation;
		}
		
		public function set rotation(value:Number):void 
		{
			_rotation = value;
		}
		
		public function get linearVelocityX():Number 
		{
			return _x - _previousX;
		}
		
		public function set linearVelocityX(value:Number):void 
		{
			_previousX = _x - value;
		}
		
		public function get linearVelocityY():Number 
		{
			return _y - _previousY;
		}
		
		public function set linearVelocityY(value:Number):void 
		{
			_previousY = _y - value;
		}
		
		public function get angularVelocity():Number 
		{
			return _rotation - _previousRotation;
		}
		
		public function set angularVelocity(value:Number):void 
		{
			_previousRotation = _rotation - value;
		}
		
		public function get centerX():Number 
		{
			return isNaN(_centerX) ? _geometry.centerX : _centerX;
		}
		
		public function set centerX(value:Number):void 
		{
			_centerX = value;
		}
		
		public function get centerY():Number 
		{
			return isNaN(_centerY) ? _geometry.centerX : _centerY;
		}
		
		public function set centerY(value:Number):void 
		{
			_centerY = value;
		}
		
		public function get mass():Number
		{
			return _geometry.volume * _material.density;
		}
		
		public function get inverseMass():Number
		{
			const mass:Number = this.mass;
			return mass == 0 ? 0 : 1 / mass;
		}
		
		public function get inertia():Number
		{
			return _geometry.inertia;
		}
		
		public function get inverseInertia():Number
		{
			const inertia:Number = this.inertia;
			return inertia == 0 ? 0 : 1 / inertia;
		}
		
		public function get isMoving():Boolean 
		{
			return linearVelocityX != 0 || linearVelocityY != 0 || angularVelocity != 0;
		}
		
		public function get isResting():Boolean 
		{
			return !isMoving;
		}
		
		public function rest():void
		{
			linearVelocityX = 0;
			linearVelocityY = 0;
			angularVelocity = 0;
		}
		
		public function wake():void
		{
			linearVelocityX = Mathematics.EPSILON;
		}
		
		public function get changed():Boolean 
		{
			return _changed;
		}
		
		public function set changed(value:Boolean):void
		{
			_changed = value;
		}
		
		public function get geometry():IGeometry 
		{
			return _geometry;
		}
		
		public function set geometry(value:IGeometry):void
		{
			_geometry = value;
			_changed = true;
		}
		
		public function get material():IMaterial 
		{
			return _material;
		}
		
		public function set material(value:IMaterial):void 
		{
			_material = value;
			_changed = true;
		}
		
		public function get forces():Vector.<IForce> 
		{
			return _forces;
		}
		
		public function set forces(value:Vector.<IForce>):void 
		{
			_forces = value;
		}
		
		public function update():void
		{
			
			/*
				Key to verlet integration
			*/
			const previousX:Number = _x;
			const previousY:Number = _y;
			const previousRotation:Number = _rotation;
			
			const velocityX:Number = this.linearVelocityX;
			const velocityY:Number = this.linearVelocityY;
			const angularVelocity:Number = this.angularVelocity;
			
			_x = _x + velocityX;
			_y = _y + velocityY;
			_rotation = _rotation + angularVelocity;
			
			trace('rotation', _rotation);
			
			_previousX = previousX;
			_previousY = previousY;
			_previousRotation = previousRotation;
			
			/*
				Invalidate for view rendering
			*/
			_changed = _changed || previousX != _x || previousY != _y || previousRotation != _rotation;
			
			/*
				Update geometric position for hit detection
			*/
			_geometry.translate(velocityX, velocityY, angularVelocity);
			
		}
		
	}

}