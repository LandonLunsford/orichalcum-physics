package orichalcum.physics.lifecycle 
{
	import orichalcum.physics.ICollidable;
	import orichalcum.physics.IPhysicsContext;

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
		}
		
	}

}