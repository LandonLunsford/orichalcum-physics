package orichalcum.physics.context 
{
	
	import orichalcum.physics.collision.Collision;
	import orichalcum.physics.collision.Contact;
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.collision.detection.ICollisionDetector;
	import orichalcum.physics.collision.detection.filter.ICollisionFilter;
	import orichalcum.physics.force.IForce;
	import orichalcum.physics.simulation.lifecycle.ILifecyclePhase;
	
	public interface IPhysicsContext
	{
		
		function mapDetector(typeA:Class, typeB:Class, detector:ICollisionDetector):IPhysicsContext;
		function unmapDetector(typeA:Class, typeB:Class):IPhysicsContext;
		function getDetector(collidableA:Object, collidableB:Object, collidableIdGetter:Function = null):ICollisionDetector;
		
		function get lifecycle():Vector.<ILifecyclePhase>;
		function set lifecycle(value:Vector.<ILifecyclePhase>):void;
		
		function get collisionFilters():Vector.<ICollisionFilter>;
		function set collisionFilters(value:Vector.<ICollisionFilter>):void;
		
		function get bodies():Vector.<ICollidable>;
		function set bodies(value:Vector.<ICollidable>):void;
		
		function get forces():Vector.<IForce>;
		function set forces(value:Vector.<IForce>):void;
		
		function play():IPhysicsContext;
		function pause():IPhysicsContext;
		function toggle():IPhysicsContext;
		function get isPlaying():Boolean;
		function get isPaused():Boolean;
		
		/**
		 * Factories for collisions and contacts
		 * User can enable flyweights for tuned performance
		 */
		function contact():Contact;
		function collision():Collision;
		
	}

}