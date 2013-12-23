package orichalcum.physics.context 
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.getQualifiedClassName;
	import orichalcum.animation.Animation;
	import orichalcum.physics.collision.Collision;
	import orichalcum.physics.collision.Contact;
	import orichalcum.physics.collision.detection.AABBAABBCollisionDetector;
	import orichalcum.physics.collision.detection.CircleCircleCollisionDetector;
	import orichalcum.physics.collision.detection.filter.AABBIntersectionCollisionFilter;
	import orichalcum.physics.collision.detection.filter.ICollisionFilter;
	import orichalcum.physics.collision.detection.ICollisionDetector;
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.datastructure.CombinationMap;
	import orichalcum.physics.force.IForce;
	import orichalcum.physics.geometry.AABB;
	import orichalcum.physics.geometry.Circle;
	import orichalcum.physics.simulation.lifecycle.ILifecyclePhase;
	import orichalcum.physics.simulation.lifecycle.RenderViewsPhase;
	import orichalcum.physics.simulation.lifecycle.ResolveCollisionsPhase;
	import orichalcum.physics.simulation.lifecycle.UpdateBodiesPhase;
	import orichalcum.utility.FunctionUtil;

	/**
	 * The Physics Engine Facade
	 */
	public class PhysicsContext implements IPhysicsContext
	{
		
		private var _isPlaying:Boolean;
		private var _dispatcher:IEventDispatcher;
		private var _lifecycle:Vector.<ILifecyclePhase>;
		private var _bodies:Vector.<ICollidable>;
		private var _forces:Vector.<IForce>;
		private var _collisionFilters:Vector.<ICollisionFilter>;
		
		private var _collisionFlyweight:Collision;
		private var _contactFlyweight:Contact;
		private var _detectors:CombinationMap;
		
		public function PhysicsContext() 
		{
			_dispatcher = Animation.eventDispatcher;
			_lifecycle = new <ILifecyclePhase>[
				new UpdateBodiesPhase(),
				new ResolveCollisionsPhase(),
				new RenderViewsPhase()
			];
			_bodies = new Vector.<ICollidable>;
			_forces = new Vector.<IForce>;
			_collisionFilters = new <ICollisionFilter>[
				//new SameLayerCollisionFilter(),
				new AABBIntersectionCollisionFilter()
			]
			_collisionFlyweight = new Collision;
			_contactFlyweight = new Contact;
			
			_detectors = new CombinationMap;
			
			mapDetector(AABB, AABB, new AABBAABBCollisionDetector)
			mapDetector(Circle, Circle, new CircleCircleCollisionDetector)
			
			this.isPlaying = true;
		}
		
		public function dispose():void
		{
			this.isPlaying = false;
			_dispatcher = null;
			_lifecycle = null;
			_bodies = null;
			_forces = null;
			_collisionFilters = null;
		}
		
		public function get isPlaying():Boolean 
		{
			return _isPlaying;
		}
		
		public function set isPlaying(value:Boolean):void 
		{
			if (_isPlaying == value) return;
			_isPlaying = value;
			if (value)
			{
				_dispatcher.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
			}
			else
			{
				_dispatcher.removeEventListener(Event.ENTER_FRAME, _onEnterFrame);
			}
		}
		
		public function get isPaused():Boolean 
		{
			return !isPlaying;
		}
		
		public function set isPaused(value:Boolean):void 
		{
			_isPlaying = !value;
		}
		
		public function play():IPhysicsContext
		{
			isPlaying = true;
			return this;
		}
		
		public function pause():IPhysicsContext
		{
			isPlaying = false;
			return this;
		}
		
		public function toggle():IPhysicsContext 
		{
			isPlaying = !isPlaying;
			return this;
		}
		
		public function get bodies():Vector.<ICollidable> 
		{
			return _bodies;
		}
		
		public function set bodies(value:Vector.<ICollidable>):void 
		{
			_bodies = value;
		}
		
		public function get lifecycle():Vector.<ILifecyclePhase> 
		{
			return _lifecycle;
		}
		
		public function set lifecycle(value:Vector.<ILifecyclePhase>):void 
		{
			_lifecycle = value;
		}
		
		public function get forces():Vector.<IForce> 
		{
			return _forces;
		}
		
		public function set forces(value:Vector.<IForce>):void 
		{
			_forces = value;
		}
		
		public function get collisionFilters():Vector.<ICollisionFilter> 
		{
			return _collisionFilters;
		}
		
		public function set collisionFilters(value:Vector.<ICollisionFilter>):void 
		{
			_collisionFilters = value;
		}
		
		public function contact():Contact 
		{
			return _contactFlyweight;
		}
		
		public function collision():Collision 
		{
			return _collisionFlyweight;
		}
		
		public function mapDetector(geometryTypeA:Class, geometryTypeB:Class, detector:ICollisionDetector):IPhysicsContext
		{
			if (detector is IPhysicsContextAware)
			{
				(detector as IPhysicsContextAware).physicsContext = this;
			}
			
			/**
			 * This key generation should be standard and then the getDetector one should be custom perhaps
			 */
			_detectors.map(
				getQualifiedClassName(geometryTypeA),
				getQualifiedClassName(geometryTypeB),
				detector
			);
			return this;
		}
		
		public function unmapDetector(geometryTypeA:Class, geometryTypeB:Class):IPhysicsContext
		{
			
			const a:String = getQualifiedClassName(geometryTypeA);
			const b:String = getQualifiedClassName(geometryTypeB);
			const detector:ICollisionDetector = _detectors.at(a, b);
			if (detector is IPhysicsContextAware)
			{
				(detector as IPhysicsContextAware).physicsContext = null;
			}
			_detectors.unmap(a, b);
			return this;
		}
		
		public function getDetector(geometryA:Object, geometryB:Object):ICollisionDetector
		{
			return _detectors.at(
				getQualifiedClassName(geometryA),
				getQualifiedClassName(geometryB)
			);
		}
		
		/** PRIVATE PARTS **/
		
		private function _onEnterFrame(event:Event):void
		{
			for each(var phase:ILifecyclePhase in _lifecycle)
			{
				phase.apply(this);
			}
		}
		
	}

}