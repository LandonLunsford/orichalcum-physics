package orichalcum.physics.collision.detection 
{
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
			
			if (!isInside && squareDistance > circleRadius * circleRadius) return null;
			
			const distance:Number = Math.sqrt(squareDistance);
			const normalX:Number = distanceX / distance;
			const normalY:Number = distanceY / distance;
			const penetration:Number = circleRadius - distance;
			
			return _physicsContext.collision().compose(
				collidableA,
				collidableB,
				isInside
					? _physicsContext.contact().compose(0, 0, -normalX, -normalY, penetration)
					:_physicsContext.contact().compose(0, 0, normalX, normalY, penetration)
			)
			
		}
		/**
		 * Algorithm assumes the circle center does not pass into the AABB
		 */
		public function detect_a(collidableA:ICollidable, collidableB:ICollidable):ICollision
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
			const distanceX:Number = circle.x - aabb.centerX;
			const distanceY:Number = circle.y - aabb.centerY;
			const squareDistance:Number = distanceX * distanceX + distanceY * distanceY;
			if (squareDistance > circleRadius * circleRadius) return null;
			
			const distance:Number = Math.abs(squareDistance);
			
			/**
			 * Dangerous division?
			 */
			const normalX:Number = distanceX / distance;
			const normalY:Number = distanceY / distance;
			
			return _physicsContext.collision().compose(
				collidableA,
				collidableB,
				_physicsContext.contact().compose(
					0,
					0,
					normalX,
					normalY,
					circleRadius + aabb.halfHeight - distance
				)
			)
		}
		
		/**
		 * Fail fast
		 * Algorithm assumes the circle center does not pass into the AABB
		 * http://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection/402010#402010
		 */
		public function detect_b(collidableA:ICollidable, collidableB:ICollidable):ICollision
		{
			
			const aabb:AABB = collidableA.body.geometry as AABB;
			const circle:Circle = collidableB.body.geometry as Circle;
			const circleX:Number = circle.x;
			const circleY:Number = circle.y;
			const circleRadius:Number = circle.radius;
			const aabbHalfWidth:Number = aabb.halfWidth;
			const aabbHalfHeight:Number = aabb.halfHeight;
			
			const relativeX:Number = circleX - aabb.centerX;
			const relativeY:Number = circleY - aabb.centerY;
			const deltaX:Number = Math.abs(relativeX);
			const deltaY:Number = Math.abs(relativeY);
			//const deltaX:Number = circleX - aabb.centerX;
			//const deltaY:Number = circleY - aabb.centerY;
			
			if (deltaX > aabbHalfWidth + circleRadius
			|| deltaY > aabbHalfHeight + circleRadius
			|| deltaX > aabbHalfWidth	// failing too fast
			|| deltaY > aabbHalfHeight)	// failing too fast
			{
				trace('exit A')
				return null;
			}
			
			const distanceX:Number = deltaX;
			const distanceY:Number = deltaY;
			
			//const distanceX:Number = relativeX - aabbHalfWidth;
			//const distanceY:Number = relativeY - aabbHalfHeight;
			
			const squareDistance:Number = distanceX * distanceX + distanceY * distanceY;
			if (squareDistance > circleRadius * circleRadius)
			{
				trace('exit B', squareDistance, circleRadius * circleRadius)
				return null;
			}
			
			//trace('pass')
			
			const distance:Number = Math.sqrt(squareDistance);
			
			// wrong -- needs to be the line from the closest point
			const normalX:Number = relativeX / distance;
			const normalY:Number = relativeY / distance;
			
			trace('normal', normalX, normalY);
			
			return _physicsContext.collision().compose(
				collidableA,
				collidableB,
				_physicsContext.contact().compose(
					0,
					0,
					normalX,
					normalY,
					circleRadius
				)
			)
			
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
		
//public boolean intersects(float cx, float cy, float radius, float left, float top, float right, float bottom)
//{
   //float closestX = (cx < left ? left : (cx > right ? right : cx));
   //float closestY = (cy < top ? top : (cy > bottom ? bottom : cy));
   //float dx = closestX - cx;
   //float dy = closestY - cy;
//
   //return ( dx * dx + dy * dy ) <= radius * radius;
//}
		public function detect_c(collidableA:ICollidable, collidableB:ICollidable):ICollision
		{
			
			const aabb:AABB = collidableA.body.geometry as AABB;
			const circle:Circle = collidableB.body.geometry as Circle;
			
			const circleX:Number = circle.x;
			const circleY:Number = circle.y;
			const circleRadius:Number = circle.radius;
			const left:Number = aabb.left;
			const top:Number = aabb.top;
			const right:Number = aabb.right;
			const bottom:Number = aabb.bottom;
			
			const closestX:Number = circleX < left ? left : (circleX > right ? right : circleX);
			const closestY:Number = circleY < top ? top : (circleY > bottom ? bottom : circleY);
			
			const distanceX:Number = closestX - circleX;
			const distanceY:Number = closestY - circleY;
			
			const squareDistance:Number = distanceX * distanceX + distanceY * distanceY;
			
			
			
			if (squareDistance == 0
			|| squareDistance > circleRadius * circleRadius)
			{
				return null;
			}
			
			const distance:Number = Math.sqrt(squareDistance);
			const normalX:Number = distanceX / distance;
			const normalY:Number = distanceY / distance;
			const penetration:Number = circleRadius + aabb.halfHeight - distance;
			trace('normal', normalX, normalY, penetration);
			
			return _physicsContext.collision().compose(
				collidableA,
				collidableB,
				_physicsContext.contact().compose(
					0,
					0,
					normalX,
					-normalY,
					penetration // this is not right... I need to know what side on on
				)
			)
			
			
			//return null;
		}
	}

}