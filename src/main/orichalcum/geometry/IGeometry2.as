package orichalcum.geometry 
{
	import flash.geom.Point;

	public interface IGeometry2 
	{
		function get x():Number;
		function set x(value:Number):void;
		function get y():Number;
		function set y(value:Number):void;
		function getCenter(flyweight:Point2 = null):Point2;
		
		
		
		function get area():Number;
		//function position(x:Number, y:Number):void;
		function translate(x:Number, y:Number, rotation:Number = 0):void;
		
		
		
		
		
		
		
		
		
		/*
			Final interface will be
			
			Geometry
				x	:Number /get,set
				y	:Number
				center	:Point2
				volume	:Number
				bounds	:AABB
			
			
			Mass // may want to join with Body
				x	// usually center of geometry
				y	
				mass,inverseMass	// mass = geometry.volume * material.density, set both to 0 to simulate static objects
				I,inverseI		// purely based on geometry not mass
				
				update(geometry, material)
				
			Material
				friction
				elasticity
				density
				
			// broadphase
				
				
			
		 */
		
		
		
		
		
		
		
		
	}
	
}