package orichalcum.physics.collision.detection.filter 
{
	
	public interface ICollisionFilter 
	{
		
		/**
		 * Return true if bodies are candidates for collision detection analysis
		 * @param	bodyA
		 * @param	bodyB
		 * @return
		 */
		function apply(bodyViewA:Object, bodyViewB:Object):Boolean;
		
	}

}