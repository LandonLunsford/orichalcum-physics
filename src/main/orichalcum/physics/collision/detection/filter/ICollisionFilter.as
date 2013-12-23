package orichalcum.physics.collision.detection.filter 
{
	
	public interface ICollisionFilter 
	{
		
		/**
		 * Return true if bodies are candidates for collision detection analysis
		 * @param	collidableA
		 * @param	collidableB
		 * @return
		 */
		function apply(collidableA:Object, collidableB:Object):Boolean;
		
	}

}