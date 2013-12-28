package orichalcum.physics.simulation.lifecycle 
{
	import orichalcum.physics.body.BodyType;
	import orichalcum.physics.collision.Collision;
	import orichalcum.physics.collision.detection.filter.ICollisionFilter;
	import orichalcum.physics.collision.detection.ICollisionDetector;
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.collision.ICollision;
	import orichalcum.physics.collision.resolution.ICollisionResolver;
	import orichalcum.physics.collision.resolution.ImpulseCollisionResolver;
	import orichalcum.physics.collision.resolution.PositionalCollisionResolver;
	import orichalcum.physics.collision.resolution.RotationlessImpulseCollisionResolver;
	import orichalcum.physics.context.IPhysicsContext;
	import orichalcum.physics.geometry.IGeometry;

	/**
	 * Ideally bodytypes hould be separated into different datastructures for optimal looping
	 * With this however you would loose the flexibility of simply assigning bodies different types on the fly
	 */
	public class ResolveCollisionsPhase implements ILifecyclePhase
	{
		
		private var _passedLastPhase:Boolean;
		
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
				 */
				//if (collidableB.body.type & BodyType.KINETIC) continue;
				
				for (var j:int = i + 1; j < totalCollidables; j++)
				{
					
					var collidableB:ICollidable = collidables[j];
					
					/**
					 * Kinetics do not obey the laws of physics
					 * Only check dynamics against statics
					 * 
					 * NOT WORKING AS EXPECTED....
					 */
					//if (collidableA.body.type & BodyType.KINETIC || collidableA.body.type & BodyType.STATIC) continue;
					//if (collidableB.body.type & BodyType.STATIC) continue;
					
					
					/**
					 * Apply user filters beyond body type combination filters
					 * Additionally broadphases can be implemented here
					 */
					if (!isCollisionCandidate(collisionFilters, collidableA, collidableB))
					{
						trace('collision failed broadphase')
						if (_passedLastPhase)
						{
							trace('SHOULD PASS - INSPECT STATE');
						}
						_passedLastPhase = false
						continue;
					}
					
					
					trace('collision passed broadphase', collidableA, collidableB);
					
					var geometryA:IGeometry = collidableA.body.geometry;
					var geometryB:IGeometry = collidableB.body.geometry;
					var detector:ICollisionDetector = context.getDetector(geometryA, geometryB);
					var reverseCollision:Boolean;
					
					if (detector == null)
					{
						detector = context.getDetector(geometryB, geometryB);
						if (detector == null)
						{
							trace('collision skipped. no detector is mapped');
							_passedLastPhase = false
							continue;
						}
						trace('reverse geometry mapping found.');
						reverseCollision = true;
					}
					
					var collision:Collision =
					(
						reverseCollision
						? detector.detect(collidableB, collidableA)
						: detector.detect(collidableA, collidableB)
					) as Collision;
					
					if (collision == null)
					{
						trace('collision failed finephase');
						if (_passedLastPhase)
						{
							trace('SHOULD PASS - INSPECT STATE');
						}
						_passedLastPhase = false
						continue;
					}
					
					reverseCollision && collision.inverse();
					
					trace('collision detected.', collision);
					
					/**
					 * Later allow for context level configuration and possibly conditional mapping to type combos
					 */
					var resolver:ICollisionResolver = new RotationlessImpulseCollisionResolver;
					//var resolver:ICollisionResolver = new PositionalCollisionResolver;
					//var resolver:ICollisionResolver = new ImpulseCollisionResolver;
					
					if (resolver == null)
					{
						//trace('collision resolution skipped. no resolver is mapped');
						_passedLastPhase = false
						continue;
					}
					
					resolver.resolve(collision);
					
					//trace('collision resolved.');
					_passedLastPhase = true;
				}
			}
		}
		
		private function isCollisionCandidate(collisionFilters:Vector.<ICollisionFilter>, bodyA:Object, bodyB:Object):Boolean 
		{
			for each(var collisionFilter:ICollisionFilter in collisionFilters)
			{
				if (!collisionFilter.apply(bodyA, bodyB))
				{
					return false;
				}
			}
			return true;
		}
		
	}

}