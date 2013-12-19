package orichalcum.geometry 
{
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;

	public class Circle2 extends Point2 implements IGeometry2
	{
		public var radius:Number;
		
		public function Circle2(x:Number = 0, y:Number = 0, radius:Number = 0)
		{
			super(x, y);
			this.radius = radius;
		}
		
		public function get diameter():Number
		{
			return radius * 2;
		}
		
		public function set diameter(value:Number):void
		{
			radius = diameter * 0.5;
		}
		
		public function intersects(circle:Circle2):Boolean
		{
			return Geometry2.circleIntersectsCircle(x, y, radius, circle.x, circle.y, circle.radius);
		}
		
		public function intersectsRectangle(rectangle:Rectangle2):Boolean
		{
			return Geometry2.circleIntersectsRectangle(x, y, radius, rectangle.left, rectangle.right, rectangle.top, rectangle.bottom);
		}
		
		public function contains(x:Number, y:Number):Boolean
		{
			return Geometry2.squareDistance(this.x, this.y, x, y) < radius * radius;
		}
		
		public function containsPoint(point:Point2):Boolean
		{
			return Geometry2.squareDistance(x, y, point.x, point.y) < radius * radius;
		}
		
		public function containsCircle(circle:Circle2):Boolean
		{
			return Geometry2.circleContainsCircle(x, y, radius, circle.x, circle.y, circle.radius);
		}
		
		public function containsRectangle(rectangle:Rectangle2):Boolean
		{
			throw new IllegalOperationError();
		}
		
		public function containsPolygon(polygon:Polygon2):Boolean
		{
			throw new IllegalOperationError();
		}
		
		override public function get area():Number
		{
			return Math.PI * radius * radius;
		}
		
	}

}