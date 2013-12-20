package orichalcum.physics.simulation.lifecycle 
{
	
	import orichalcum.physics.context.IPhysicsContext
	
	public interface ILifecyclePhase 
	{
		function apply(context:IPhysicsContext):void;
	}

}