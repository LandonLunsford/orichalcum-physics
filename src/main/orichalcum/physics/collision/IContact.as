package orichalcum.physics.collision 
{
	import orichalcum.physics.geometry.Point;
	
	public interface IContact 
	{
		function get point():Point;
		function get normal():Point;
		function get penetration():Number;
	}

}