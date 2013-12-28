package orichalcum.physics.simulation.lifecycle 
{
	import orichalcum.physics.force.IForce;
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.context.IPhysicsContext;

	public class UpdateBodiesPhase implements ILifecyclePhase
	{
		
		public function apply(context:IPhysicsContext):void 
		{
			
			for each(var collidable:ICollidable in context.bodies)
			{
				
				
				
				
				// does this go here?
				for each (var force:IForce in collidable.body.forces)
				{
					force.apply(collidable.body);
				}
				
				// hotfix?? - put here for dragforce
				//if (!collidable.body.isDynamic) continue;
				
				collidable.body.update();
				
			}
			trace('updated')
		}
		
	}

}