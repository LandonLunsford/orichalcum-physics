package orichalcum.physics.flyweight 
{
	import orichalcum.physics.collision.Collision;
	
	public interface IFlyweightAware 
	{
		
		function get contact():Contact;
		function get collision():Collision;
	}

}