package orichalcum.physics.collision.resolution 
{
	import orichalcum.physics.collision.ICollision;
	import orichalcum.physics.collision.IContact;
	import orichalcum.physics.IBody;

	public class LinearCollisionResolver implements ICollisionResolver
	{
		
		public function LinearCollisionResolver() 
		{
			
		}
		
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
			const t:Number = contact.penetration / totalInverseMass;
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
			
			bodyA.linearVelocityX -= inverseMassA * normalX * impulse;
			bodyA.linearVelocityY -= inverseMassA * normalY * impulse;
			bodyB.linearVelocityX += inverseMassB * normalX * impulse;
			bodyB.linearVelocityY += inverseMassB * normalY * impulse;
			
			//bodyA.rest();
			//bodyB.rest();
		}
		
	}

}