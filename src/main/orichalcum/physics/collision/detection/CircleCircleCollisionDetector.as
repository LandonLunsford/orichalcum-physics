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
	import orichalcum.physics.geometry.Circle;
	
	public class CircleCircleCollisionDetector implements ICollisionDetector, IPhysicsContextAware
	{
		
		private var _physicsContext:IPhysicsContext;
		
		public function set physicsContext(value:IPhysicsContext):void
		{
			_physicsContext = value;
		}
		
		public function detect(collidableA:ICollidable, collidableB:ICollidable):ICollision
		{
			const circleA:Circle = collidableA.body.geometry as Circle;
			const circleB:Circle = collidableB.body.geometry as Circle;
			const distanceX:Number = circleB.x - circleA.x;
			const distanceY:Number = circleB.y - circleA.y;
			const squareDistance:Number = distanceX * distanceX + distanceY * distanceY;
			const totalRadii:Number = circleA.radius + circleB.radius;
			
			if (squareDistance > totalRadii * totalRadii) return null;
			
			const distance:Number = Math.sqrt(squareDistance);
			
			 // context.contact(); maybe use IPhysicsContextAware
			const collision:Collision = new Collision;
			const contact:Contact = new Contact;
			
			if (distance == 0)
			{
				return _physicsContext.collision().compose(
					collidableA,
					collidableB,
						contact.compose(
						circleA.x,
						circleA.y,
						1,
						0,
						circleA.radius
					)
				);
			}
			else
			{
				const normalX:Number = distanceX / distance;
				const normalY:Number = distanceY / distance;
				
				return _physicsContext.collision().compose(
					collidableA,
					collidableB,
						contact.compose(
						circleA.x + normalX * circleA.radius,
						circleA.y + normalY * circleA.radius,
						normalX,
						normalY,
						totalRadii - distance
					)
				);
			}
		}
	}

}