package orichalcum.physics.collision.detection.filter 
{
	import flash.display.DisplayObject;

	public class SameLayerCollisionFilter implements ICollisionFilter
	{
		
		public function apply(collidableA:Object, collidableB:Object):Boolean 
		{
			// anything reaching to the user api needs wildcards...
			// implementation ideas
			//return bodyA.isSiblingOf(bodyB);
			//return bodyA.layer == bodyB.layer;
			
			return collidableA is DisplayObject
				&& collidableB is DisplayObject
				&& collidableA.parent != null
				&& collidableA.parent == collidableB.parent
				&& collidableA.z == collidableB.z;
		}
		
	}

}