package orichalcum.physics 
{
	
	public interface ICollidable 
	{
		
		function get body():IBody;
		function set body(value:IBody):void;
		
		function onBodyChange():void;
		
	}

}