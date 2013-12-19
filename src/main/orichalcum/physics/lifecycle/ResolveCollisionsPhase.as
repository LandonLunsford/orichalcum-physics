package orichalcum.physics.lifecycle 
{
	import orichalcum.physics.collision.detection.CircleCircleCollisionDetector;
	import orichalcum.physics.collision.detection.filter.ICollisionFilter;
	import orichalcum.physics.collision.detection.ICollisionDetector;
	import orichalcum.physics.collision.ICollision;
	import orichalcum.physics.collision.resolution.ICollisionResolver;
	import orichalcum.physics.collision.resolution.LinearAndRotaryCollisionResolver;
	import orichalcum.physics.collision.resolution.LinearCollisionResolver;
	import orichalcum.physics.IBody;
	import orichalcum.physics.ICollidable;
	import orichalcum.physics.IPhysicsContext;

	public class ResolveCollisionsPhase implements ILifecyclePhase
	{
		
		public function apply(context:IPhysicsContext):void 
		{
			const bodies:Vector.<ICollidable> = context.bodies;
			const totalBodies:int = bodies.length;
			const collisionFilters:Vector.<ICollisionFilter> = context.collisionFilters;
			
			for (var i:int = 0; i < totalBodies; i++)
			{
				for (var j:int = i + 1; j < totalBodies; j++)
				{
					var bodyA:ICollidable = bodies[i];
					var bodyB:ICollidable = bodies[j];
					
					if (!isCollisionCandidate(collisionFilters, bodyA, bodyB)) continue;
					
					
					
					// optional
					//if (bodyA.layer != bodyB.layer) continue;
					
					// maybe just make htis part dynamic "collisionFilters"
					/*
						// filter examples
						sameLayerFilter = function(bodyA:IBody, bodyB:IBody):void
						{
							return bodyA.layer == bodyB.layer;
						}
						aabbIntersectionFilter = function(bodyA:IBody, bodyB:IBody):void
						{
							return bodyA.geometry.aabb.intersects(bodyB.geometry.aabb);
						}
					*/
					//if (bodyA.geometry.aabb.intersects(bodyB.geometry.aabb))
					//{
						//bodies.push(bodyA, bodyB);
					//}
					
					
					
					
					trace('collision passed broadphase', bodyA, bodyB);
					
					var detector:ICollisionDetector = new CircleCircleCollisionDetector;
					
					if (!detector)
					{
						trace('collision skipped. no detector is mapped');
						continue;
					}
					
					var collision:ICollision = detector.detect(bodyA, bodyB);
					
					if (!collision)
					{
						trace('collision failed finephase');
						continue;
					}
					else
					{
						trace('collision passed finephase');
					}
					
					trace('collision detected.', collision);
					
					//var resolver:ICollisionResolver = new LinearCollisionResolver;
					var resolver:ICollisionResolver = new LinearAndRotaryCollisionResolver;
					
					if (!resolver)
					{
						trace('collision resolution skipped. no resolver is mapped');
						continue;
					}
					
					resolver.resolve(collision);
					
					trace('collision resolved.');
					
				}
			}
		}
		
		private function isCollisionCandidate(collisionFilters:Vector.<ICollisionFilter>, bodyA:Object, bodyB:Object):Boolean 
		{
			for each(var collisionFilter:ICollisionFilter in collisionFilters)
			{
				if (!collisionFilter.apply(bodyA, bodyB)) return false;
			}
			return true;
		}
		
	}

}