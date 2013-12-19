package orichalcum.physics.collision 
{
	import orichalcum.geometry.Point2;
	import orichalcum.physics.ICollidable;
	
	public interface ICollision 
	{
		function get collidableA():ICollidable;
		function get collidableB():ICollidable;
		function get contacts():Vector.<IContact>;
	}

}