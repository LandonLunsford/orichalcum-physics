package orichalcum.physics 
{
	
	import orichalcum.physics.force.IForce;
	import orichalcum.physics.lifecycle.ILifecyclePhase;
	import orichalcum.physics.collision.detection.filter.ICollisionFilter;
	
	public interface IPhysicsContext
	{
		
		function get lifecycle():Vector.<ILifecyclePhase>;
		function set lifecycle(value:Vector.<ILifecyclePhase>):void;
		
		function get collisionFilters():Vector.<ICollisionFilter>;
		function set collisionFilters(value:Vector.<ICollisionFilter>):void;
		
		function get bodies():Vector.<ICollidable>;
		function set bodies(value:Vector.<ICollidable>):void;
		
		function get forces():Vector.<IForce>;
		function set forces(value:Vector.<IForce>):void;
		
		function get isPlaying():Boolean;
		function set isPlaying(value:Boolean):void;
		function get isPaused():Boolean;
		function set isPaused(value:Boolean):void;
		function toggle():Boolean;
		
	}

}