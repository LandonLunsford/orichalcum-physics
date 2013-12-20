package orichalcum.physics.collision 
{
	
	import orichalcum.physics.collision.ICollidable;
	
	public interface ICollision 
	{
		function get collidableA():ICollidable;
		function get collidableB():ICollidable;
		function get contacts():Vector.<IContact>;
	}

}