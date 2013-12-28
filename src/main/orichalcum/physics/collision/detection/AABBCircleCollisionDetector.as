package orichalcum.physics.collision.detection 
{
	import orichalcum.datastructure.ICollection;
	import orichalcum.physics.collision.Collision;
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.collision.ICollision;
	import orichalcum.physics.context.IPhysicsContext;
	import orichalcum.physics.context.IPhysicsContextAware;
	import orichalcum.physics.geometry.AABB;
	import orichalcum.physics.geometry.Circle;
	import orichalcum.utility.MathUtil;
	
	public class AABBCircleCollisionDetector implements ICollisionDetector, IPhysicsContextAware
	{
		
		private var _physicsContext:IPhysicsContext;
		
		public function set physicsContext(value:IPhysicsContext):void
		{
			_physicsContext = value;
		}
		
		
		/**
		 * http://gamedevelopment.tutsplus.com/tutorials/create-custom-2d-physics-engine-aabb-circle-impulse-resolution--gamedev-6331
		 * http://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection/402010#402010
		 */
		public function detect(collidableA:ICollidable, collidableB:ICollidable):ICollision
		{
			
			const aabb:AABB = collidableA.body.geometry as AABB;
			const circle:Circle = collidableB.body.geometry as Circle;
			
			const circleCenterX:Number = circle.x;
			const circleCenterY:Number = circle.y;
			const circleRadius:Number = circle.radius;
			
			const aabbX:Number = aabb.centerX;
			const aabbY:Number = aabb.centerY;
			const aabbHalfWidth:Number = aabb.halfWidth;
			const aabbHalfHeight:Number = aabb.halfHeight;
			
			const displacementX:Number = circleCenterX - aabbX;
			const displacementY:Number = circleCenterY - aabbY;
			
			// usable failfast
			//if (displacementX > aabbHalfWidth + circleRadius
			//|| displacementY > aabbHalfHeight + circleRadius
			//|| displacementX > aabbHalfWidth
			//|| displacementY > aabbHalfHeight)
			//{
				//return null;
			//}
			
			var closestX:Number = MathUtil.limit(displacementX, -aabbHalfWidth, aabbHalfWidth)
			var closestY:Number = MathUtil.limit(displacementY, -aabbHalfHeight, aabbHalfHeight)
			
			const isInside:Boolean = displacementX == closestX && displacementY == closestY
			if (isInside)
			{
				if (Math.abs(displacementX) > Math.abs(displacementY))
				{
					closestX = closestX > 0 ? aabbHalfWidth : -aabbHalfWidth;
				}
				else
				{
					closestY = closestY > 0 ? aabbHalfHeight : -aabbHalfHeight;
				}
			}
			
			const distanceX:Number = displacementX - closestX;
			const distanceY:Number = displacementY - closestY;
			const squareDistance:Number = distanceX * distanceX + distanceY * distanceY;
			
			if (distanceX + distanceY == 0) return null;
			
			if (!isInside && squareDistance > circleRadius * circleRadius) return null;
			
			const distance:Number = Math.sqrt(squareDistance);
			const normalX:Number = distanceX / distance;
			const normalY:Number = distanceY / distance;
			const penetration:Number = circleRadius - distance;
			
			const collision:ICollision = _physicsContext.collision().compose(
				collidableA,
				collidableB,
				//_physicsContext.contact().compose(0, 0, normalX, normalY, penetration)
				isInside
					? _physicsContext.contact().compose(0, 0, -normalX, -normalY, penetration)
					:_physicsContext.contact().compose(0, 0, normalX, normalY, penetration)
			)
			
			//trace('returning collision', collision)
			
			return collision;
		}
		
	}

}