package orichalcum.physics.collision.resolution 
{
	import orichalcum.mathematics.Mathematics;
	import orichalcum.physics.collision.ICollision;
	import orichalcum.physics.collision.IContact;
	import orichalcum.physics.body.IBody;


	public class LinearAndRotaryCollisionResolver implements ICollisionResolver
	{
		
		public function LinearAndRotaryCollisionResolver() 
		{
			
		}
		
		public function resolve(collision:ICollision):void 
		{
			
			const bodyA:IBody = collision.collidableA.body;
			const bodyB:IBody = collision.collidableB.body;
			const contact:IContact = collision.contacts[0];
			const normalX:Number = contact.normal.x;
			const normalY:Number = contact.normal.y;
			const inverseMassA:Number = bodyA.inverseMass;
			const inverseMassB:Number = bodyB.inverseMass;
			const inverseIA:Number = bodyA.geometry.inverseInertia;
			const inverseIB:Number = bodyB.geometry.inverseInertia;
			const frictionA:Number = bodyA.material.friction;
			const frictionB:Number = bodyB.material.friction;
			const elasticityA:Number = bodyA.material.elasticity;
			const elasticityB:Number = bodyB.material.elasticity;
			
			const totalInverseMass:Number = inverseMassA + inverseMassB;
			const totalInverseMassInversed:Number = 1 / totalInverseMass;
			const t:Number = contact.penetration * totalInverseMassInversed;
			const separationX:Number = normalX * t;
			const separationY:Number = normalY * t;
			
			/**
			 * works only when there is one contact point... what about 2 ?
			 */
			const contactNormalX1:Number = bodyA.y - contact.point.y;
			const contactNormalY1:Number = contact.point.x - bodyA.x;
			const contactNormalX2:Number = bodyB.y - contact.point.y;
			const contactNormalY2:Number = contact.point.x - bodyB.x;
			
			bodyA.x -= separationX * inverseMassA;
			bodyA.y -= separationY * inverseMassA;
			bodyB.x += separationX * inverseMassB;
			bodyB.y += separationY * inverseMassB;
			
			const relativeVelocityX:Number = (contactNormalX2 * bodyB.angularVelocity + bodyB.linearVelocityX)
				- (contactNormalX1 * bodyA.angularVelocity + bodyA.linearVelocityX);
			const relativeVelocityY:Number = (contactNormalY2 * bodyB.angularVelocity + bodyB.linearVelocityY)
				- (contactNormalY1 * bodyA.angularVelocity + bodyA.linearVelocityY);
			
			const velocityAlongNormal:Number = relativeVelocityX * normalX + relativeVelocityY * normalY;
			
			if (velocityAlongNormal > 0) return;
			
			const tangentX:Number = -normalY;
			const tangentY:Number = normalX;
			
			const contactPerpNormal1:Number = contactNormalX1 * normalX + contactNormalY1 * normalY;
			const contactPerpNormal2:Number = contactNormalX2 * normalX + contactNormalY2 * normalY;
			const contactPerpTangent1:Number = contactNormalX1 * tangentX + contactNormalY1 * tangentY;
			const contactPerpTangent2:Number = contactNormalX2 * tangentX + contactNormalY2 * tangentY;
			
			const impulseDenominator1:Number = (normalX * normalX + normalY * normalY) * totalInverseMass
				+ contactPerpNormal1 * contactPerpNormal1 * inverseIA
				+ contactPerpNormal2 * contactPerpNormal2 * inverseIB;
			const impulseDenominator2:Number = (tangentX * tangentX + tangentY * tangentY) * totalInverseMass
				+ contactPerpTangent1 * contactPerpTangent1 * inverseIA
				+ contactPerpTangent2 * contactPerpTangent2 * inverseIB;
			
			const restitution:Number = Math.min(elasticityA, elasticityB);//var restitution = (body1.elasticity + body2.elasticity) * 0.5;
			const friction:Number = (frictionA + frictionB) * 0.5;

			const impulse1:Number = (-(1 + restitution) * velocityAlongNormal) / impulseDenominator1;
			const impulse2:Number = friction * -(relativeVelocityX * tangentX + relativeVelocityY * tangentY) / impulseDenominator2;

			const a:Number = impulse1 * inverseMassA;
			const b:Number = -impulse1 * inverseMassB;
			const c:Number = impulse2 * inverseMassA;
			const d:Number = -impulse2 * inverseMassB;
			
			bodyB.linearVelocityX += normalX * a + tangentX * c;
			bodyB.linearVelocityY += normalY * a + tangentY * c;
			bodyB.angularVelocity -= (contactPerpNormal1 * impulse1 * inverseIA + contactPerpTangent1 * impulse2 * inverseIA) * Mathematics.RADIAN_TO_DEGREE;
				
			bodyA.linearVelocityX += normalX * b + tangentX * d;
			bodyA.linearVelocityY += normalY * b + tangentY * d;
			bodyA.angularVelocity -= (contactPerpNormal2 * -impulse1 * inverseIB + contactPerpTangent2 * -impulse2 * inverseIB) * Mathematics.RADIAN_TO_DEGREE;
				
			//trace('i2', impulse2)
			
		}
		
	}

}