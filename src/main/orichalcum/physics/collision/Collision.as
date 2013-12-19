package orichalcum.physics.collision 
{
	import orichalcum.geometry.Point2;
	import orichalcum.physics.ICollidable;

	public class Collision implements ICollision
	{
		private var _collidableA:ICollidable;
		private var _collidableB:ICollidable;
		private var _contacts:Vector.<IContact> = new Vector.<IContact>;
		
		public function get collidableA():ICollidable 
		{
			return _collidableA;
		}
		
		public function get collidableB():ICollidable 
		{
			return _collidableB;
		}
		
		public function get contacts():Vector.<IContact>
		{
			return _contacts;
		}
		
		public function initialize(collidableA:ICollidable, collidableB:ICollidable, ...contacts):ICollision
		{
			_collidableA = collidableA;
			_collidableB = collidableB;
			_contacts.length = 0;
			for each(var contact:IContact in contacts)
			{
				if (contact)
				{
					_contacts[_contacts.length] = contact;
				}
			}
			return this;
		}
		
		public function toString():String
		{
			return '{'
				+ 'collidableA:' + collidableA
				+ ', collidableB:' + collidableB
				+ ', contacts:' + contacts
				+ '}';
		}
		
	}

}