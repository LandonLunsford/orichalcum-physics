package orichalcum.physics.collision.resolution 
{
	import orichalcum.physics.collision.ICollision;
	import orichalcum.physics.collision.IContact;
	import orichalcum.physics.body.IBody;

	public class RotationlessImpulseCollisionResolver implements ICollisionResolver
	{
		
		/**
		 * Refactor to physicsContext.settings
		 */
		private var slop:Number = 0.01;
		private var percent:Number = 0.8;
		
		public function resolve(collision:ICollision):void 
		{
			const bodyA:IBody = collision.collidableA.body;
			const bodyB:IBody = collision.collidableB.body;
			const inverseMassA:Number = bodyA.inverseMass;
			const inverseMassB:Number = bodyB.inverseMass;
			
			const totalInverseMass:Number = inverseMassA + inverseMassB;
			if (totalInverseMass == 0) return;
			
			const contact:IContact = collision.contacts[0];
			const normalX:Number = contact.normal.x;
			const normalY:Number = contact.normal.y;
			const totalInverseMassInversed:Number = totalInverseMass == 0 ? 0 : 1 / totalInverseMass;
			
			/**
			 * Allow for slop
			 */
			//const t:Number = Math.max(contact.penetration - slop, 0) * totalInverseMassInversed * percent;
			
			/**
			 * Slopless precision!
			 */
			const t:Number = contact.penetration * totalInverseMassInversed * percent;
			
			const separationX:Number = normalX * t;
			const separationY:Number = normalY * t;
			
			/**
			 * Because I am verlet integrated this should truly be a view correction not a data correction...
			 * This will lead to inaccurate velocities otherwise
			 */
			const prevousLinearVelocityXA:Number = bodyA.linearVelocityX;
			const prevousLinearVelocityYA:Number = bodyA.linearVelocityY;
			const prevousLinearVelocityXB:Number = bodyB.linearVelocityX;
			const prevousLinearVelocityYB:Number = bodyB.linearVelocityY;
			 
			const inverseMassPortionA:Number = totalInverseMass - inverseMassB;
			const inverseMassPortionB:Number = totalInverseMass - inverseMassA;
			
			const relativeVelocityX:Number = prevousLinearVelocityXB - prevousLinearVelocityXA;
			const relativeVelocityY:Number = prevousLinearVelocityYB - prevousLinearVelocityYA;
			const velocityAlongNormal:Number = relativeVelocityX * normalX + relativeVelocityY * normalY;
			if (velocityAlongNormal > 0) return;
			
			//const restitution:Number = Math.min(bodyA.material.elasticity, bodyB.material.elasticity)
			const restitution:Number = (bodyA.material.elasticity + bodyB.material.elasticity) * 0.5
			
			// hot fixerupper (2 statics may not collide)
			
			const impulse:Number = ( -(1 + restitution) * velocityAlongNormal ) / totalInverseMass;
			
			
			// these need to be above the velocity changes because of verlet integration
			bodyA.x -= separationX * inverseMassPortionA;
			bodyA.y -= separationY * inverseMassPortionA;
			bodyB.x += separationX * inverseMassPortionB;
			bodyB.y += separationY * inverseMassPortionB;
			
			// how does this work with verlet integration. I forsee issues
			bodyA.linearVelocityX = prevousLinearVelocityXA - inverseMassPortionA * normalX * impulse;
			bodyA.linearVelocityY = prevousLinearVelocityYA - inverseMassPortionA * normalY * impulse;
			bodyB.linearVelocityX = prevousLinearVelocityXB + inverseMassPortionB * normalX * impulse;
			bodyB.linearVelocityY = prevousLinearVelocityYB + inverseMassPortionB * normalY * impulse;
			
			
			
		}
		
	}

}