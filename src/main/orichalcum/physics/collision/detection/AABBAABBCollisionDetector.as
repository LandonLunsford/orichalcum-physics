/**
 * http://gamedevelopment.tutsplus.com/tutorials/how-to-create-a-custom-2d-physics-engine-the-core-engine--gamedev-7493
 */

package orichalcum.physics.collision.detection 
{
	import orichalcum.physics.body.IBody;
	import orichalcum.physics.collision.Collision;
	import orichalcum.physics.collision.Contact;
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.collision.ICollision;
	import orichalcum.physics.context.IPhysicsContext;
	import orichalcum.physics.context.IPhysicsContextAware;
	import orichalcum.physics.geometry.AABB;
	import orichalcum.physics.geometry.Circle;
	
	public class AABBAABBCollisionDetector implements ICollisionDetector, IPhysicsContextAware
	{
		
		private var _physicsContext:IPhysicsContext;
		
		public function set physicsContext(value:IPhysicsContext):void
		{
			_physicsContext = value;
		}
		
		public function detect(collidableA:ICollidable, collidableB:ICollidable):ICollision
		{
			const a:AABB = collidableA.body.geometry as AABB;
			const b:AABB = collidableB.body.geometry as AABB;
			const distanceX:Number = b.x - a.x;
			const distanceY:Number = b.y - a.y;
			
			const overlapX:Number = a.halfWidth + b.halfWidth - Math.abs(distanceX);
			if (overlapX <= 0) return null;
			
			const overlapY:Number = a.halfHeight + b.halfHeight - Math.abs(distanceY);
			if (overlapY <= 0) return null;
			
			//if (collidableA.body.linearVelocityX * collidableB.body.linearVelocityX
			//+ collidableA.body.linearVelocityY * collidableB.body.linearVelocityY > 0)
				//return null;
			
			if (overlapX < overlapY)
			{
				if (distanceX < 0)
				{
					return _physicsContext.collision().compose(
						collidableA,
						collidableB,
						_physicsContext.contact().compose(0, 0, -1, 0, overlapX)
					);
				}
				else
				{
					return _physicsContext.collision().compose(
						collidableA,
						collidableB,
						_physicsContext.contact().compose(0, 0, 1, 0, overlapX)
					);
				}
			}
			else
			{
				if (distanceY < 0)
				{
					return _physicsContext.collision().compose(
						collidableA,
						collidableB,
						_physicsContext.contact().compose(0, 0, 0, -1, overlapY)
					);
				}
				else
				{
					return _physicsContext.collision().compose(
						collidableA,
						collidableB,
						_physicsContext.contact().compose(0, 0, 0, 1, overlapY)
					);
				}
			}
			//return null;
		}
	}

}