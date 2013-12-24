package orichalcum.physics.collision 
{
	
	import orichalcum.physics.collision.ICollidable;

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
		
		public function compose(collidableA:ICollidable, collidableB:ICollidable, ...contacts):ICollision
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
		
		public function getCollidable(type:Class):*
		{
			if (collidableA is type) return collidableA;
			if (collidableB is type) return collidableB;
			throw new ArgumentError();
		}
		
		public function dispose():void
		{
			_collidableA = null;
			_collidableB = null;
			_contacts = null;
		}
		
		public function inverse():void
		{
			const temporary:ICollidable = _collidableA;
			_collidableA = _collidableB;
			_collidableB = temporary;
			
			for each(var contact:Contact in _contacts)
			{
				contact.inverse();
			}
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
