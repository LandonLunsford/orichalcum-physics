/**
 * http://gamedevelopment.tutsplus.com/tutorials/how-to-create-a-custom-2d-physics-engine-the-core-engine--gamedev-7493
 */

package orichalcum.physics.collision.detection 
{
	import orichalcum.mathematics.Mathematics;
	import orichalcum.physics.body.geometry.Circle;
	import orichalcum.physics.collision.Collision;
	import orichalcum.physics.collision.Contact;
	import orichalcum.physics.collision.ICollision;
	import orichalcum.physics.collision.IContact;
	import orichalcum.physics.ICollidable;
	
	public class CircleCircleCollisionDetector implements ICollisionDetector
	{
		
		public function detect(bodyA:ICollidable, bodyB:ICollidable, flyweight:ICollision = null):ICollision 
		{
			const circleA:Circle = bodyA.body.geometry as Circle;
			const circleB:Circle = bodyB.body.geometry as Circle;
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
				return collision.initialize(
					bodyA,
					bodyB,
					contact.initialize(
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
				
				return collision.initialize(
					bodyA,
					bodyB,
					contact.initialize(
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