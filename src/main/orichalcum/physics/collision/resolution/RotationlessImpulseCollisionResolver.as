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
			const contact:IContact = collision.contacts[0];
			const normalX:Number = contact.normal.x;
			const normalY:Number = contact.normal.y;
			
			const totalInverseMass:Number = inverseMassA + inverseMassB;
			const totalInverseMassInversed:Number = totalInverseMass == 0 ? 0 : 1 / totalInverseMass;
			const t:Number = Math.max(contact.penetration - slop, 0) * totalInverseMassInversed * percent;
			//const t:Number = contact.penetration * totalInverseMassInversed * percent;
			const separationX:Number = normalX * t;
			const separationY:Number = normalY * t;
						
			bodyA.x -= separationX * inverseMassA;
			bodyA.y -= separationY * inverseMassA;
			bodyB.x += separationX * inverseMassB;
			bodyB.y += separationY * inverseMassB;
			
			const relativeVelocityX:Number = bodyB.linearVelocityX - bodyA.linearVelocityX;
			const relativeVelocityY:Number = bodyB.linearVelocityY - bodyA.linearVelocityY;
			const velocityAlongNormal:Number = relativeVelocityX * normalX + relativeVelocityY * normalY;
			if (velocityAlongNormal > 0) return;
			
			const restitution:Number = Math.min(bodyA.material.elasticity, bodyB.material.elasticity)
			const impulse:Number = ( -(1 + restitution) * velocityAlongNormal ) / totalInverseMass;
			
			// how does this work with verlet integration. I forsee issues
			bodyA.linearVelocityX -= inverseMassA * normalX * impulse;
			bodyA.linearVelocityY -= inverseMassA * normalY * impulse;
			bodyB.linearVelocityX += inverseMassB * normalX * impulse;
			bodyB.linearVelocityY += inverseMassB * normalY * impulse;
			
		}
		
	}

}