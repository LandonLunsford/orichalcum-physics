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
			
			/**
			 * Allow for slop
			 */
			//const t:Number = Math.max(contact.penetration - slop, 0) / totalInverseMass * percent;
			/**
			 * Slopless precision!
			 */
			const t:Number = contact.penetration * totalInverseMassInversed;
			
			const separationX:Number = normalX * t;
			const separationY:Number = normalY * t;
			
			//trace('separation',separationX, separationY, 't', t, 'p', contact.penetration);
			
			/**
			 * This is a utility function used among different resolvers and should be refactored outward
			 * 
			 */
			const inverseMassPortionA:Number = totalInverseMass - inverseMassB;
			const inverseMassPortionB:Number = totalInverseMass - inverseMassA;
			bodyA.x -= separationX * inverseMassPortionA;
			bodyA.y -= separationY * inverseMassPortionA;
			bodyB.x += separationX * inverseMassPortionB;
			bodyB.y += separationY * inverseMassPortionB;
			
			bodyA.rest();
			bodyB.rest();
		}
		
	}

}