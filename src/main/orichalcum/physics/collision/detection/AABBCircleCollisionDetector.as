package orichalcum.physics.collision.detection 
{
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.collision.ICollision;
	import orichalcum.physics.context.IPhysicsContext;
	import orichalcum.physics.context.IPhysicsContextAware;
	import orichalcum.physics.geometry.AABB;
	import orichalcum.physics.geometry.Circle;
	
	public class AABBCircleCollisionDetector implements ICollisionDetector, IPhysicsContextAware
	{
		
		private var _physicsContext:IPhysicsContext;
		
		public function set physicsContext(value:IPhysicsContext):void
		{
			_physicsContext = value;
		}
		
		/**
		 * Algorithm assumes the circle center does not pass into the AABB
		 */
		public function detect2(collidableA:ICollidable, collidableB:ICollidable):ICollision
		{
			const aabb:AABB = collidableA.body.geometry as AABB;
			const circle:Circle = collidableB.body.geometry as Circle;
			const circleCenterX:Number = circle.x;
			const circleCenterY:Number = circle.y;
			const circleRadius:Number = circle.radius;
			
			var closestPointX:Number, closestPointY:Number;
			
			if (circleCenterX < aabb.left)
			{
				closestPointX = aabb.left;
			}
			else if (circleCenterX > aabb.right)
			{
				closestPointX = aabb.right;
			}
			if (circleCenterY < aabb.top)
			{
				closestPointY = aabb.top;
			}
			else if (circleCenterY > aabb.bottom)
			{
				closestPointY = aabb.bottom;
			}
			/*
			 * Also normal
			 */
			const distanceX:Number = circle.x - aabb.x;
			const distanceY:Number = circle.y - aabb.y;
			const squareDistance:Number = distanceX * distanceX + distanceY * distanceY;
			if (squareDistance > circleRadius * circleRadius) return null;
			
			const distance:Number = Math.abs(squareDistance);
			
			/**
			 * Dangerous division?
			 */
			const normalX:Number = distanceX / distance;
			const normalY:Number = distanceY / distance;
			
			return _physicsContext.contact().compose(
				collidableA,
				collidableB,
				_physicsContext.contact(
					0,
					0,
					normalX,
					normalY,
					distance - circleRadius
				)
			)
		}
		
		/**
		 * Fail fast
		 * Algorithm assumes the circle center does not pass into the AABB
		 * http://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection/402010#402010
		 */
		public function detect(collidableA:ICollidable, collidableB:ICollidable):ICollision
		{
			
			const aabb:AABB = collidableA.body.geometry as AABB;
			const circle:Circle = collidableB.body.geometry as Circle;
			const circleX:Number = circle.x;
			const circleY:Number = circle.y;
			const circleRadius:Number = circle.radius;
			
			const deltaX:Number = Math.abs(circleX - aabb.x);
			const deltaY:Number = Math.abs(circleY - aabb.y);
			
			if (deltaX > aabb.halfWidth + circleRadius
			|| deltaY > aabb.halfHeight + circleRadius
			|| deltaX <= aabb.halfWidth
			|| deltaY <= aabb.halfHeight)
			{
				return null;
			}
			
			const distanceX:Number = deltaX - aabb.halfWidth;
			const distanceY:Number = deltaY - aabb.halfHeight;
			const squareDistance:Number = distanceX * distanceX + distanceY * distanceY;
			
			if (squareDistance > circleRadius * circleRadius)
				return null;
			
			const distance:Number = Math.sqrt(squareDistance);
			const normalX:Number = distanceX / distance;
			const normalY:Number = distanceY / distance;
			
			return _physicsContext.collision();
			
			//circleDistance.x = abs(circle.x - rect.x);
			//circleDistance.y = abs(circle.y - rect.y);
			//if (circleDistance.x > (rect.width/2 + circle.r)) { return false; }
			//if (circleDistance.y > (rect.height/2 + circle.r)) { return false; }
			//if (circleDistance.x <= (rect.width/2)) { return true; } 
			//if (circleDistance.y <= (rect.height/2)) { return true; }
			//cornerDistance_sq = (circleDistance.x - rect.width/2)^2 +
			//(circleDistance.y - rect.height/2)^2;
			//return (cornerDistance_sq <= (circle.r^2));
		}
		
	}

}