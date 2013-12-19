package orichalcum.physics.collision.detection 
{
	import orichalcum.physics.collision.ICollision;
	import orichalcum.physics.ICollidable;
	
	public interface ICollisionDetector 
	{
		
		/**
		 * @return Collision if detected. Null if no collision was detected.
		 */
		function detect(bodyA:ICollidable, bodyB:ICollidable, flyweight:ICollision = null):ICollision;
		
	}

}