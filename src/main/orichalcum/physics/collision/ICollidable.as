package orichalcum.physics.collision 
{
	
	import orichalcum.physics.body.IBody
	
	public interface ICollidable 
	{
		
		function get body():IBody;
		function set body(value:IBody):void;
		
		function onBodyChange():void;
		
	}

}