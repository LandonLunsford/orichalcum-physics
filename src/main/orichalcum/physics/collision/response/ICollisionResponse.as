package orichalcum.physics.collision.response 
{

	public interface ICollisionResponse 
	{
		
		function handle(collision:ICollision):void;
		
	}

}