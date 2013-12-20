package orichalcum.physics.force 
{
	
	import orichalcum.physics.body.IBody
	
	public interface IForce 
	{
		function apply(body:IBody):void;
	}

}