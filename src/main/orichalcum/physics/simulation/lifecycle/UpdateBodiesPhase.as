package orichalcum.physics.simulation.lifecycle 
{
	import orichalcum.physics.force.IForce;
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.context.IPhysicsContext;

	public class UpdateBodiesPhase implements ILifecyclePhase
	{
		
		public function apply(context:IPhysicsContext):void 
		{
			
			for each(var bodyView:ICollidable in context.bodies)
			{
				// does this go here?
				for each (var force:IForce in bodyView.body.forces)
				{
					force.apply(bodyView.body);
				}
				
				bodyView.body.update();
			}
		}
		
	}

}