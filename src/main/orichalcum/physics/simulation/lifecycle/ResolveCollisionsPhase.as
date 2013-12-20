package orichalcum.physics.simulation.lifecycle 
{
	import flash.utils.getQualifiedClassName;
	import orichalcum.physics.collision.detection.CircleCircleCollisionDetector;
	import orichalcum.physics.collision.detection.filter.ICollisionFilter;
	import orichalcum.physics.collision.detection.ICollisionDetector;
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.collision.ICollision;
	import orichalcum.physics.collision.resolution.ICollisionResolver;
	import orichalcum.physics.collision.resolution.LinearAndRotaryCollisionResolver;
	import orichalcum.physics.context.IPhysicsContext;

	public class ResolveCollisionsPhase implements ILifecyclePhase
	{
		
		private var _collidableIdGetter:Function = function(collidable:ICollidable):Object
		{
			return collidable.body.geometry;
		};
		
		public function apply(context:IPhysicsContext):void 
		{
			const bodies:Vector.<ICollidable> = context.bodies;
			const totalBodies:int = bodies.length;
			const collisionFilters:Vector.<ICollisionFilter> = context.collisionFilters;
			
			for (var i:int = 0; i < totalBodies; i++)
			{
				for (var j:int = i + 1; j < totalBodies; j++)
				{
					var collidableA:ICollidable = bodies[i];
					var collidableB:ICollidable = bodies[j];
					
					if (!isCollisionCandidate(collisionFilters, collidableA, collidableB)) continue;
					
					
					
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
					
					
					
					
					trace('collision passed broadphase', collidableA, collidableB);
					
					var detector:ICollisionDetector = context.getDetector(collidableA, collidableB, _collidableIdGetter);
					
					if (!detector)
					{
						trace('collision skipped. no detector is mapped');
						continue;
					}
					
					var collision:ICollision = detector.detect(collidableA, collidableB);
					
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