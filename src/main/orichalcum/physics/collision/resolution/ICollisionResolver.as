package orichalcum.physics.collision.resolution 
{
	import orichalcum.physics.collision.ICollision;
	
	public interface ICollisionResolver 
	{
		/**
		 * 
		 */
		function resolve(collision:ICollision):void;
		
	}

}