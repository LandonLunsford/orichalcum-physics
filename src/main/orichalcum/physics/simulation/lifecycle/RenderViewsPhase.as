package orichalcum.physics.simulation.lifecycle 
{
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.context.IPhysicsContext;

	public class RenderViewsPhase implements ILifecyclePhase
	{
		
		public function apply(context:IPhysicsContext):void 
		{
			for each(var collidable:ICollidable in context.bodies)
			{
				if (collidable.body.changed)
				{
					collidable.onBodyChange();
					collidable.body.changed = false;
					
				}
			}
			trace('rendered.')
		}
		
	}

}