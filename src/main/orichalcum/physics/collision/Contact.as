package orichalcum.physics.collision 
{
	import orichalcum.physics.body.geometry.Point;
	
	public class Contact implements IContact
	{
		private var _point:Point;
		private var _normal:Point;
		private var _penetration:Number;
		
		public function Contact() 
		{
			_point = new Point;
			_normal = new Point;
			_penetration = 0;
		}
		
		public function get point():Point 
		{
			return _point;
		}
		
		public function get normal():Point 
		{
			return _normal;
		}
		
		public function get penetration():Number 
		{
			return _penetration;
		}
		
		public function initialize(pointX:Number, pointY:Number, normalX:Number, normalY:Number, penetration:Number):IContact
		{
			_point.x = pointX;
			_point.y = pointY;
			_normal.x = normalX;
			_normal.y = normalY;
			_penetration = penetration;
			return this;
		}
		
		public function toString():String
		{
			return '{'
				+ 'point:' + point
				+ ', normal:' + normal
				+ ', penetration:' + penetration
				+ '}';
		}
		
	}

}