package orichalcum.physics.simulation.lifecycle 
{
	import orichalcum.physics.body.BodyType;
	import orichalcum.physics.collision.detection.filter.ICollisionFilter;
	import orichalcum.physics.collision.detection.ICollisionDetector;
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.collision.ICollision;
	import orichalcum.physics.collision.resolution.ICollisionResolver;
	import orichalcum.physics.collision.resolution.ImpulseCollisionResolver;
	import orichalcum.physics.collision.resolution.PositionalCollisionResolver;
	import orichalcum.physics.collision.resolution.RotationlessImpulseCollisionResolver;
	import orichalcum.physics.context.IPhysicsContext;

	/**
	 * Ideally bodytypes hould be separated into different datastructures for optimal looping
	 * With this however you would loose the flexibility of simply assigning bodies different types on the fly
	 */
	public class ResolveCollisionsPhase implements ILifecyclePhase
	{
		
		public function apply(context:IPhysicsContext):void 
		{
			const collidables:Vector.<ICollidable> = context.bodies;
			const totalCollidables:int = collidables.length;
			const collisionFilters:Vector.<ICollisionFilter> = context.collisionFilters;
			
			for (var i:int = 0; i < totalCollidables; i++)
			{
				
				var collidableA:ICollidable = collidables[i];
				
				/**
				 * Kinetics do not obey the laws of physics
				 * Only check dynamics against statics
				 */
				if (collidableA.body.type & BodyType.KINETIC & BodyType.STATAIC) continue;
				
				
				for (var j:int = i + 1; j < totalCollidables; j++)
				{
					
					var collidableB:ICollidable = collidables[j];
					
					/**
					 * Kinetics do not obey the laws of physics
					 */
					if (collidableB.body.type & BodyType.KINETIC) continue;
					
					/**
					 * Apply user filters beyond body type combination filters
					 * Additionally broadphases can be implemented here
					 */
					if (!isCollisionCandidate(collisionFilters, collidableA, collidableB))
						continue;
					
					
					//trace('collision passed broadphase', collidableA, collidableB);
					
					var detector:ICollisionDetector = context.getDetector(collidableA.body.geometry, collidableB.body.geometry);
					
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
					
					//trace('collision detected.', collision);
					
					//var resolver:ICollisionResolver = new RotationlessImpulseCollisionResolver;
					var resolver:ICollisionResolver = new PositionalCollisionResolver;
					//var resolver:ICollisionResolver = new ImpulseCollisionResolver;
					
					if (!resolver)
					{
						//trace('collision resolution skipped. no resolver is mapped');
						continue;
					}
					
					resolver.resolve(collision);
					
					//trace('collision resolved.');
					
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