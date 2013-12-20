package orichalcum.physics.material 
{
	
	public interface IMaterial 
	{
		
		/*
		 * Nape uses staticFriction, dynamicFriction, rollingFriction
		 */
		
		function get friction():Number;
		function set friction(value:Number):void;
		
		function get elasticity():Number;
		function set elasticity(value:Number):void;
		
		function get density():Number;
		function set density(value:Number):void;
		
		
		
	}

}