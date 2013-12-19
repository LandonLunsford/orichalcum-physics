package orichalcum.geometry 
{
	import orichalcum.mathematics.Mathematics;
	import flash.geom.Point;

	public class Edge2 implements IGeometry2
	{
		private var _start:Point2;
		private var _end:Point2;
		
		public function Edge2(startX:Number = 0, startY:Number = 0, endX:Number = 0, endY:Number = 0)
		{
			_start = new Point2(startX, startY);
			_end = new Point2(endX, endY);
		}
		
		public function get x():Number 
		{
			return _start.x;
		}
		
		public function set x(value:Number):void 
		{
			_start.x = value;
		}
		
		public function get y():Number 
		{
			return _start.y;
		}
		
		public function set y(value:Number):void 
		{
			_start.y = value;
		}
		
		public function get start():Point2
		{
			return _start;
		}
		
		public function set start(value:Point2):void
		{
			_start = value ||= new Point2;
		}
		
		public function get end():Point2
		{
			return _end;
		}
		
		public function set end(value:Point2):void 
		{
			_end = value ||= new Point2;
		}
		
		public function get slopeX():Number
		{
			return end.x - start.x;
		}
		
		public function get slopeY():Number
		{
			return end.y - start.y;
		}
		
		public function get width():Number
		{
			return Math.abs(slopeX);
		}
		
		public function get height():Number
		{
			return Math.abs(slopeY);
		}
		
		public function get squareLength():Number
		{
			return slopeX * slopeX + slopeY * slopeY;
		}
		
		public function get length():Number
		{
			return Math.abs(squareLength);
		}
		
		public function contains(x:Number, y:Number):Boolean
		{
			return Geometry2.edgeContainsPoint(x, y, start.x, start.y, end.x, end.y);
		}
		
		public function containsPoint(point:Point2):Boolean
		{
			return Geometry2.edgeContainsPoint(point.x, point.y, start.x, start.y, end.x, end.y);
		}
		
		public function intersects(edge:Edge2):Boolean
		{
			return Geometry2.edgeIntersectsEdge(start.x, start.y, end.x, end.y, edge.start.x, edge.start.y, edge.end.x, edge.end.y);
		}
		
		public function intersection(edge:Edge2):Point2
		{
			return Geometry2.edgeEdgeIntersection(start.x, start.y, end.x, end.y, edge.start.x, edge.start.y, edge.end.x, edge.end.y);
		}
		
		public function intersectionPoints():Vector.<Point2>
		{
			throw new ArgumentError();
		}
		
		public function rotateEquals(degrees:Number):Edge2
		{
			return rotateAboutEquals(start.x + slopeX * 0.5, start.y + slopeY * 0.5, degrees);
		}
		
		public function rotateAboutEquals(x:Number, y:Number, degrees:Number):Edge2
		{
			start.rotateAboutEquals(x, y, degrees);
			end.rotateAboutEquals(x, y, degrees);
			return this;
		}
		
		public function getCenter(flyweight:Point2 = null):Point2
		{
			if (!flyweight) flyweight = new Point2;
			return flyweight.setTo(start.x + slopeX * 0.5, start.y + slopeY * 0.5);
		}
		
		public function get area():Number 
		{
			return 0;
		}
		
		public function position(x:Number, y:Number):void
		{
			const lengthX:Number = this.slopeX;
			const lengthY:Number = this.slopeY;
			_start.x = x - lengthX * 0.5;
			_start.y = y - lengthY * 0.5;
			_end.x = _start.x + lengthX;
			_end.y = _start.y + lengthY;
		}
		
		public function translate(x:Number, y:Number, rotation:Number = 0):void
		{
			_start.x += x;
			_start.y += y;
			_end.x += x;
			_end.y += y;
			rotation == 0 || rotateEquals(rotation);
		}
	}

}