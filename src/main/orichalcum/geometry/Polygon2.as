package orichalcum.geometry 
{
	public class Polygon2 implements IGeometry2
	{
		private var _vertices:Vector.<Point2>;
		
		public function Polygon2(vertices:Vector.<Point2> = null) 
		{
			_vertices = vertices ||= new Vector.<Point2>;
		}
		
		public function get x():Number 
		{
			return left;
		}
		
		public function get y():Number 
		{
			return top;
		}
		
		public function set x(value:Number):void 
		{
			/**
			 * Update center??
			 */
			if (x == value) return;
			const delta:Number = value - x;
			for each(var vertex:Point2 in _vertices)
				vertex.x += delta;
		}
		
		public function set y(value:Number):void 
		{
			/**
			 * Update center??
			 */
			if (y == value) return;
			const delta:Number = value - y;
			for each(var vertex:Point2 in _vertices)
				vertex.y += delta;
		}
		
		public function get left():Number
		{
			var left:Number = isEmpty ? NaN : _vertices[0].x;
			for (var i:int = vertices.length - 1; i > 0; i--)
				if (vertices[i].x < left) left = vertices[i].x;
			return left;
		}
		
		public function get right():Number
		{
			var right:Number = isEmpty ? NaN : _vertices[0].x;
			for (var i:int = vertices.length - 1; i > 0; i--)
				if (vertices[i].x > right) right = vertices[i].x;
			return right;
		}
		
		public function get top():Number
		{
			var top:Number = isEmpty ? NaN : _vertices[0].y;
			for (var i:int = vertices.length - 1; i > 0; i--)
				if (vertices[i].y < top) top = vertices[i].y;
			return top;
		}
		
		public function get bottom():Number
		{
			var bottom:Number = isEmpty ? NaN : _vertices[0].y;
			for (var i:int = vertices.length - 1; i > 0; i--)
				if (vertices[i].y > bottom) bottom = vertices[i].y;
			return bottom;
		}
		
		public function get vertices():Vector.<Point2>
		{
			return _vertices;
		}
		
		public function set vertices(vertices:Vector.<Point2>):void
		{
			_vertices = vertices ||= new Vector.<Point2>();
		}
		
		public function get isEmpty():Boolean
		{
			return _vertices.length == 0;
		}
		
		public function containsPoint(x:Number, y:Number):Boolean
		{
			return Geometry2.polygonContainsPoint(x, y, vertices);
		}
		
		public function intersects(polygon:Polygon2):Boolean
		{
			return Geometry2.polygonIntersectsPolygon(vertices, polygon.vertices);
		}
		
		public function rotateEquals(degrees:Number):Polygon2
		{
			const center:Point2 = this.center;
			return rotateAboutEquals(center.x, center.y, degrees);
		}
		
		public function rotateAboutEquals(x:Number, y:Number, degrees:Number):Polygon2
		{
			for each(var vertex:Point2 in vertices)
				vertex.rotateAboutEquals(x, y, degrees);
			return this;
		}
		
		/* INTERFACE orihalcum.geometry.IGeometry */
		
		public function get center():Point2
		{
			if (isEmpty) return Geometry2.point();
			const totalVertices:Number = vertices.length;
			const center:Point2 = Geometry2.point(vertices[0].x, vertices[0].y);
			for (var i:int = vertices.length - 1; i > 0; i--)
				center.plusEquals(vertices[i]);
			return center.timesEquals(1 / totalVertices);
		}
		
		public function getCenter(flyweight:Point2 = null):Point2
		{
			if (!flyweight) flyweight = new Point2;
			
			if (isEmpty) return flyweight;
			
			flyweight.setTo(vertices[0].x, vertices[0].y);
			
			const totalVertices:Number = vertices.length;
			for (var i:int = vertices.length - 1; i > 0; i--)
			{
				flyweight.plusEquals(vertices[i]);
			}
			
			return flyweight.timesEquals(1 / totalVertices);
		}
		
		public function get area():Number
		{
			var area:Number = 0.0, totalVertices:int = vertices.length;
			for (var i:int = 0, j:int = totalVertices - 1; i < totalVertices; j = i, i++)
				area += vertices[i].x * vertices[j].y - vertices[j].x * vertices[i].y;
			return Math.abs(area * 0.5); // Math.abs not necessary when points go ccw
		}
		
		public function translate(x:Number, y:Number, rotation:Number = 0):void
		{
			/*
				0(2n)
			*/
			
			for each(var vertex:Point2 in vertices)
			{
				vertex.x += x;
				vertex.y += y;
			}
			
			rotation == 0 || rotateEquals(rotation);
		}

	}

}

