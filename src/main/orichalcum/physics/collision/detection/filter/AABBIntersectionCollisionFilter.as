package orichalcum.physics.collision.detection.filter 
{

	public class AABBIntersectionCollisionFilter implements ICollisionFilter
	{
		
		public function apply(collidableA:Object, collidableB:Object):Boolean 
		{
			return collidableA.body.geometry.bounds.intersects(collidableB.body.geometry.bounds);
		}
		
	}

}