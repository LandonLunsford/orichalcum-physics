package orichalcum.physics 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import orichalcum.animation.Animation;
	import orichalcum.physics.collision.detection.filter.AABBIntersectionCollisionFilter;
	import orichalcum.physics.collision.detection.filter.ICollisionFilter;
	import orichalcum.physics.collision.detection.filter.SameLayerCollisionFilter;
	import orichalcum.physics.force.IForce;
	import orichalcum.physics.lifecycle.ILifecyclePhase;
	import orichalcum.physics.lifecycle.RenderViewsPhase;
	import orichalcum.physics.lifecycle.ResolveCollisionsPhase;
	import orichalcum.physics.lifecycle.UpdateBodiesPhase;


	public class PhysicsContext implements IPhysicsContext
	{
		
		private var _isPlaying:Boolean;
		private var _dispatcher:IEventDispatcher;
		private var _lifecycle:Vector.<ILifecyclePhase>;
		private var _bodies:Vector.<ICollidable>;
		private var _forces:Vector.<IForce>;
		private var _collisionFilters:Vector.<ICollisionFilter>;
		
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
		
		public function toggle():Boolean 
		{
			return isPlaying = !isPlaying;
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