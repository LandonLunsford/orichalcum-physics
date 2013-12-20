package orichalcum.physics.flyweight
{

	public class Flyweights
	{
	
		private var _collision:Collision;
		private var _contact:Contact;
		
		public function Flyweights()
		{
			_collision = new Collision;
			_contact = new Contact;
		}
		
		public function get collision():Collision
		{
			return _collision;
		}
		
		public function get contact():Contact
		{
			return _contact;
		}
		
	}
	
}
