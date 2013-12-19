package orichalcum.physics.lifecycle 
{
	
	import orichalcum.physics.IPhysicsContext
	
	public interface ILifecyclePhase 
	{
		function apply(context:IPhysicsContext):void;
	}

}