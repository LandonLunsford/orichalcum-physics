package orichalcum.physics.lifecycle 
{
	import orichalcum.physics.force.IForce;
	import orichalcum.physics.ICollidable;
	import orichalcum.physics.IPhysicsContext;

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