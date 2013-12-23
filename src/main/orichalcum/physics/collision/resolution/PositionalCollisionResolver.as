package orichalcum.physics.collision.resolution 
{
	import orichalcum.physics.collision.ICollision;
	import orichalcum.physics.collision.IContact;
	import orichalcum.physics.body.IBody;

	public class PositionalCollisionResolver implements ICollisionResolver
	{
		
		/**
		 * Refactor to physicsContext.settings
		 */
		private var slop:Number = 0.01;
		private var percent:Number = 0.8;
		//private var percent:Number = 2; // why does 2 look right
		
		public function resolve(collision:ICollision):void 
		{
			const bodyA:IBody = collision.collidableA.body;
			const bodyB:IBody = collision.collidableB.body;
			const inverseMassA:Number = bodyA.inverseMass;
			const inverseMassB:Number = bodyB.inverseMass;
			const contact:IContact = collision.contacts[0];
			const normalX:Number = contact.normal.x;
			const normalY:Number = contact.normal.y;
			
			const totalInverseMass:Number = inverseMassA + inverseMassB;
			const totalInverseMassInversed:Number = totalInverseMass == 0 ? 0 : 1 / totalInverseMass;
			const t:Number = Math.max(contact.penetration - slop, 0) / totalInverseMass * percent;
			//const t:Number = contact.penetration * totalInverseMassInversed;
			const separationX:Number = normalX * t;
			const separationY:Number = normalY * t;
			
			//trace('separation',separationX, separationY, 't', t, 'p', contact.penetration);
			
			/**
			 * This algorithm is deficient and needs to be percent based.
			 * If the other object is static it does not move, and the other needs to move the full separation
			 */
			//if (bodyA.mass == 0)
			//{
				//bodyB.x += separationX;
				//bodyB.y += separationY;
			//}
			//else if (bodyB.mass == 0)
			//{
				//bodyA.x -= separationX;
				//bodyA.y -= separationY;
			//}
			//else
			//{
				bodyA.x -= separationX * inverseMassA;
				bodyA.y -= separationY * inverseMassA;
				bodyB.x += separationX * inverseMassB;
				bodyB.y += separationY * inverseMassB;
			//}
			
			bodyA.rest();
			bodyB.rest();
		}
		
	}

}