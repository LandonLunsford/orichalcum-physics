package orichalcum.physics 
{
	
	import orichalcum.physics.body.geometry.IGeometry;
	import orichalcum.physics.body.material.IMaterial;
	import orichalcum.physics.force.IForce;
	
	public interface IBody
	{
		
		function get x():Number;
		function set x(value:Number):void;
		function get y():Number;
		function set y(value:Number):void;
		function get rotation():Number;
		function set rotation(value:Number):void;
		
		function get linearVelocityX():Number;
		function set linearVelocityX(value:Number):void;
		function get linearVelocityY():Number;
		function set linearVelocityY(value:Number):void;
		function get angularVelocity():Number;
		function set angularVelocity(value:Number):void;
		
		// refers to center of mass
		function get centerX():Number;
		function set centerX(value:Number):void;
		function get centerY():Number;
		function set centerY(value:Number):void;
		
		function get inverseMass():Number;
		function get inverseInertia():Number;
		
		
		function get isMoving():Boolean;
		function get isResting():Boolean;
		
		function rest():void;
		function wake():void;
		
		function get geometry():IGeometry;
		function set geometry(value:IGeometry):void;
		
		function get material():IMaterial;
		function set material(value:IMaterial):void;
		
		function get forces():Vector.<IForce>;
		function set forces(value:Vector.<IForce>):void;
		
		function update():void;
		
		function get changed():Boolean;
		function set changed(value:Boolean):void;
		
	}

}