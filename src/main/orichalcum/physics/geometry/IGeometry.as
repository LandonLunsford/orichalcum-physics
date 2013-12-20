package orichalcum.physics.geometry 
{
	
	public interface IGeometry 
	{
		
		function get x():Number;
		function set x(value:Number):void;
		function get y():Number;
		function set y(value:Number):void;
		function get centerX():Number;
		function get centerY():Number;
		function get volume():Number;
		function get inertia():Number;
		function get inverseInertia():Number;
		function get bounds():AABB;
		function translate(x:Number, y:Number, rotation:Number = 0):void;
		
	}

}