package orichalcum.physics.collision.detection 
{
	
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.collision.ICollision;
	
	public interface ICollisionDetector
	{
		
		/**
		 * @return Collision if detected and null if no collision was detected.
		 */
		function detect(collisionA:ICollidable, collisionB:ICollidable):ICollision;
		
	}

}