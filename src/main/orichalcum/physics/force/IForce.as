package orichalcum.physics.force 
{
	import orichalcum.physics.IBody;
	
	public interface IForce 
	{
		function apply(body:IBody):void;
	}

}