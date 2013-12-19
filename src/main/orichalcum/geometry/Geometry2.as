package orichalcum.geometry 
{
	import orichalcum.datastructure.Pool;
	import orichalcum.mathematics.Mathematics;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Geometry2
	{
		/***************************************************************************************************************************
		 * references:
		 * 	http://www.kevlindev.com/gui/math/intersection/Intersection.js
		 * 
		 **************************************************************************************************************************/
		
		static public const PI:Number = Math.PI;
		static public const TWO_PI:Number = Math.PI * 2;
		static public const RADIANS_TO_DEGREES:Number = 180 / Math.PI;
		static public const DEGREES_TO_RADIANS:Number = Math.PI / 180;
		static public const EPSILON:Number = 0.0001;
		
		/***************************************************************************************************************************
		 * factory
		 **************************************************************************************************************************/
		
		static private var _useFlyweightPoints:Boolean;
		static private var _pointPool:Pool = new Pool(
			function(type:Class):void { return new Point2; },
			function(instance:Point2):void { }
		);
		static private var _pointVector:Vector.<Point2> = new Vector.<Point2>;

		static public function get useFlyweightPoints():Boolean
		{
			return _useFlyweightPoints;
		}
		
		static public function set useFlyweightPoints(value:Boolean):void
		{
			_useFlyweightPoints = value;
		}
		
		static public function createPoint(x:Number = 0, y:Number = 0):Point2
		{
			return new Point2(x, y);
		}
		
		static public function createPointsFromCoordinates(...coordinates):Vector.<Point2>
		{
			while (coordinates.length > 0 && (coordinates[0] is Array || coordinates[0] is Vector.<Number>))
				coordinates = coordinates[0];
				
			const totalCoordinates:int = coordinates.length;
			if (totalCoordinates & 1 == 1)
				throw new ArgumentError('require even number of coordinates');
			
			const points:Vector.<Point2> = new Vector.<Point2>;
			for (var i:int = 0; i < totalCoordinates - 1; i += 2)
				points.push(point(coordinates[i], coordinates[i + 1]));
				
			return points;
		}
		
		static public function createEdge(startX:Number = 0, startY:Number = 0, endX:Number = 0, endY:Number = 0):Edge2
		{
			return new Edge2(startX, startY, endX, endY);
		}
		
		static public function createPolygon(vertices:Vector.<Point2> = null):Polygon2
		{
			return new Polygon2(vertices);
		}
		
		static public function createPolygonFromPoints(...points):Polygon2
		{
			while (points.length > 0 && (points[0] is Array || points[0] is Vector.<Point2>))
				points = points[0];
			const vertices:Vector.<Point2> = new Vector.<Point2>;
			vertices.push.apply(null, points);
			return new Polygon2(vertices);
		}
		
		static public function createPolygonFromCoordinates(...coordinates):Polygon2
		{
			return new Polygon2(createPointsFromCoordinates(coordinates));
		}
		
		static public function createPolygonFromRectangle(rectangle:Rectangle):Polygon2
		{
			return new Polygon2(new <Point2>[
				new Point2(rectangle.x, rectangle.y),
				new Point2(rectangle.x, rectangle.y + rectangle.height),
				new Point2(rectangle.x + rectangle.width, rectangle.y + rectangle.height),
				new Point2(rectangle.x + rectangle.width, rectangle.y)
			]);
		}
		
		static public function createPolygonRectangle(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0):Polygon2
		{
			return new Polygon2(new <Point2>[
				new Point2(x, y),
				new Point2(x, y + height),
				new Point2(x + width, y + height),
				new Point2(x + width, y)
			]);
		}
		
		static public function createPolygonSquare(x:Number = 0, y:Number = 0, width:Number = 0):Polygon2
		{
			return createPolygonRectangle(x, y, width, width);
		}
		
		static public function createRegularPolygon(width:Number = 50, numVertices:int = 3, angleOffset:Number = 0):Polygon2
		{
			const vertices:Vector.<Point2> = new Vector.<Point2>;
			var angle:Number = TWO_PI / numVertices;
                        while(numVertices--)
                        {
				vertices.push(new Point2(Math.cos(angleOffset) * width, Math.sin(angleOffset) * width));
				angleOffset += angle;
                        }
                        return new Polygon2(vertices);
		}
		
		/***************************************************************************************************************************
		 * Utility
		 **************************************************************************************************************************/
		
		static public function toRadians(degrees:Number):Number
		{
			return degrees * DEGREES_TO_RADIANS;
		}
		
		static public function toDegrees(radians:Number):Number
		{
			return radians * RADIANS_TO_DEGREES;
		}
		
		static public function distance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			return Math.sqrt(squareDistance(x1, y1, x2, y2));
		}
		
		static public function squareDistance(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			const dx:Number = x2 - x1;
			const dy:Number = y2 - y1;
			return dx * dx + dy * dy;
		}
		
		static public function rotate(point:Point2, originX:Number, originY:Number, radians:Number):void
		{
			const dx:Number = point.x - originX;
			const dy:Number = point.y - originY;
			const cos:Number = Math.cos(radians);
			const sin:Number = Math.sin(radians);
			point.x = originX + cos * dx - sin * dy;
			point.y = originY + cos * dy + sin * dx;
		}
		
		static public function rectangleContainsPoint(pointX:Number, pointY:Number, left:Number, right:Number, bottom:Number, top:Number):Boolean
		{
			return pointX > left && pointX < right && pointY > bottom && pointY < top;
		}
		
		static public function polygonContainsPoint(pointX:Number, pointY:Number, vertices:Vector.<Point2>):Boolean
		{
			var totalVertices:int = vertices.length, oddNodes:Boolean;
			for (var i:int = 0, j:int = totalVertices - 1; i < totalVertices; j = i++)
			{
				var b:Point2 = vertices[i], a:Point2 = vertices[j];
				if (((b.y > pointY) != (a.y > pointY)) && (pointX < (a.x - b.x) * (pointY - b.y) / (a.y- b.y) + b.x))
					oddNodes = !oddNodes;
			}
			return oddNodes;
		}
		
		static public function circleIntersectsCircle(x1:Number, y1:Number, r1:Number, x2:Number, y2:Number, r2:Number):Boolean
		{
			const radii:Number = r1 + r2;
			return squareDistance(x1, y1, x2, y2) < radii * radii;
		}
		
		/**
		 * http://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection
		 */
		static public function circleIntersectsRectangle(x:Number, y:Number, r:Number, left:Number, right:Number, top:Number, bottom:Number):Boolean
		{
			return squareDistance(x, y, Mathematics.clamp(x, left, right), Mathematics.clamp(y, top, bottom)) < r * r;
		}
		
		/**
		 * http://board.flashkit.com/board/showthread.php?775520-Circle-inside-Circle-collision
		 */
		static public function circleContainsCircle(x1:Number, y1:Number, r1:Number, x2:Number, y2:Number, r2:Number):Boolean
		{
			const dr:Number = r1 - r2;
			return squareDistance(x2, y2, x1, y1) < dr * dr;
		}
		
		static public function polygonIntersectsPolygon(polygon1:Vector.<Point2>, polygon2:Vector.<Point2>):Boolean
		{
			var totalVertices1:int = polygon1.length, totalVertices2:int = polygon2.length,
				vertex1:Point2, vertex2:Point2,
				minimum1:Number, minimum2:Number,
				maximum1:Number, maximum2:Number,
				axisX:Number, axisY:Number,
				i:int, j:int, k:int,
				dotProduct:Number;
				
			for (i = 0, j = totalVertices1 - 1; i < totalVertices1; j = i, i++){
				vertex1 = polygon1[j];
				vertex2 = polygon1[i];
				axisX = vertex1.y - vertex2.y;
				axisY = vertex2.x - vertex1.x;
				dotProduct = minimum1 = maximum1 = polygon1[0].x * axisX + polygon1[0].y * axisY;
				for (k = totalVertices1 - 1; k >= 0; k--){
					dotProduct = polygon1[k].x * axisX + polygon1[k].y * axisY;
					if (dotProduct < minimum1) minimum1 = dotProduct;
					else if (dotProduct > maximum1) maximum1 = dotProduct;
				}
				dotProduct = minimum2 = maximum2 = polygon2[0].x * axisX + polygon2[0].y * axisY;
				for (k = totalVertices2 - 1; k >= 0; k--){
					dotProduct = polygon2[k].x * axisX + polygon2[k].y * axisY;
					if (dotProduct < minimum2) minimum2 = dotProduct;
					else if (dotProduct > maximum2) maximum2 = dotProduct;
				}
				if ((minimum1 < minimum2 ? minimum2 - maximum1 : minimum1 - maximum2) > 0)
					return false;
			}
			
			for (i = 0, j = totalVertices2 - 1; i < totalVertices2; j = i, i++){
				vertex1 = polygon2[j];
				vertex2 = polygon2[i];
				axisX = vertex1.y - vertex2.y;
				axisY = vertex2.x - vertex1.x;
				dotProduct = minimum1 = maximum1 = polygon1[0].x * axisX + polygon1[0].y * axisY;
				for (k = totalVertices1 - 1; k >= 0; k--){
					dotProduct = polygon1[k].x * axisX + polygon1[k].y * axisY;
					if (dotProduct < minimum1) minimum1 = dotProduct;
					else if (dotProduct > maximum1) maximum1 = dotProduct;
				}
				dotProduct = minimum2 = maximum2 = polygon2[0].x * axisX + polygon2[0].y * axisY;
				for (k = totalVertices2 - 1; k >= 0; k--){
					dotProduct = polygon2[k].x * axisX + polygon2[k].y * axisY;
					if (dotProduct < minimum2) minimum2 = dotProduct;
					else if (dotProduct > maximum2) maximum2 = dotProduct;
				}
				if ((minimum1 < minimum2 ? minimum2 - maximum1 : minimum1 - maximum2) > 0)
					return false;
			}
			return true;
		}
		
		static public function edgeIntersectsEdge(ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number, dx:Number, dy:Number):Boolean
		{
			return ((dy - ay) * (cx - ax) > (cy - ay) * (dx - ax)) != ((dy - by) * (cx - bx) > (cy - by) * (dx - bx))
				&& ((cy - ay) * (bx - ax) > (by - ay) * (cx - ax)) != ((dy - ay) * (bx - ax) > (by - ay) * (dx - ax));
		}
		
		static public function edgeEdgeIntersection(ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number, dx:Number, dy:Number):Point2
		{
			const abx:Number = bx - ax;
			const aby:Number = by - ay;
			const cdx:Number = dx - cx;
			const cdy:Number = dy - cy;
			const acx:Number = ax - cx;
			const acy:Number = ay - cy;
			const u:Number = 1 / (-cdx * aby + abx * cdy);
			if (isNaN(u)) return null;
			const s:Number = ( -aby * acx + abx * acy) * u;
			const t:Number = (cdx * acy - cdy * acx) * u;
			return s >= 0 && s <= 1 && t >= 0 && t <= 1
				? point(ax + t * abx, ay + t * aby)
				: null;
		}
		
		static public function lineLineIntersection(ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number, dx:Number, dy:Number):Point2
		{
			const x12:Number = ax - bx;
			const x34:Number = cx - dx;
			const y12:Number = ay - by;
			const y34:Number = cy - dy;
			const c:Number = x12 * y34 - y12 * x34;
			if (Math.abs(c) < 0.01) return null;
			const a:Number = ax * by - ay * bx;
			const b:Number = cx * dy - cy * dx;
			return point((a * x34 - b * x12) / c, (a * y34 - b * y12) / c);
		}
		
		static public function circleCircleIntersectionVector(x1:Number, y1:Number, r1:Number, x2:Number, y2:Number, r2:Number):Point2
		{
			const dx:Number = x2 - x1;
			const dy:Number = y2 - y1;
			const radii:Number = r1 + r2;
			const squareDistance:Number = dx * dx + dy * dy;
			if (squareDistance < radii * radii) return null;
			const distance:Number = Math.sqrt(squareDistance);
			const factor:Number = squareDistance == 0 ? 0 : distance - radii / distance;
			return point(dx * factor, dy * factor);
		}
		
		static public function edgeContainsPoint(pointX:Number, pointY:Number, ax:Number, ay:Number, bx:Number, by:Number, tolerance:Number = EPSILON):Boolean
		{
			return Math.abs((bx - ax) * (pointY - ay) - (by - ay) * (pointX - ax)) < tolerance;
		}
		
		static public function squareDistanceToEdge(pointX:Number, pointY:Number, lineStartX:Number, lineStartY:Number, lineEndX:Number, lineEndY:Number):Number
		{
			const lineX:Number = lineEndX - lineStartX;
			const lineY:Number = lineEndY - lineStartY;
			const lineLengthSquared:Number = lineX * lineX + lineY * lineY;
			const tangent:Number = Mathematics.clamp(lineLengthSquared == 0 ? 0 : ((pointX - lineStartX) * lineX + (pointY - lineStartY) * lineY) / lineLengthSquared, 0.0, 1.0);
			const closestPointX:Number = lineStartX + lineX * tangent;
			const closestPointY:Number = lineStartY + lineY * tangent;
			const dx:Number = pointX - closestPointX;
			const dy:Number = pointY - closestPointY;
			return dx * dx + dy * dy;
		}

		static public function closestPointOnEdge(pointX:Number, pointY:Number, lineStartX:Number, lineStartY:Number, lineEndX:Number, lineEndY:Number):Point2
		{
			const lineX:Number = lineEndX - lineStartX;
			const lineY:Number = lineEndY - lineStartY;
			const lineLengthSquared:Number = lineX * lineX + lineY * lineY;
			const tangent:Number = Mathematics.clamp(lineLengthSquared == 0 ? 0 : ((pointX - lineStartX) * lineX + (pointY - lineStartY) * lineY) / lineLengthSquared, 0.0, 1.0);
			return point(lineStartX + lineX * tangent, lineStartY + lineY * tangent);
		}
		
		// I dont think this works
		static public function rectangleRectangleIntersectionVector(x1:Number, y1:Number, w1:Number, h1:Number, x2:Number, y2:Number, w2:Number, h2:Number):Point2
		{
			const aw2:Number = w1 * 0.5;
			const bw2:Number = w2 * 0.5;
			const ah2:Number = h1 * 0.5;
			const bh2:Number = h2 * 0.5;
			const dx:Number = x2 + bw2 - x1 + aw2;
			const dy:Number = y2 + bh2 - y1 + ah2;
			
			const overlapX:Number = aw2 + bw2 - Math.abs(dx);
			if (overlapX < 0) return null;
			
			const overlapY:Number = ah2 + bh2 - Math.abs(dy);
			if (overlapY < 0) return null;
			
			if (overlapX < overlapY)
			{
				return dx > 0
					? point(-overlapX, 0)
					: point(overlapX, 0);
			}
			else
			{
				return dy > 0
					? point(0, -overlapY)
					: point(0, overlapY);
			}
		}

		static public function circlePolygonIntersection(circleX:Number, circleY:Number, circleRadius:Number, polygon:Vector.<Point2>):Point2
		{
			var totalVertices:int = polygon.length;
			var minimumSquareDistance:Number = Number.MAX_VALUE;
			for (var i:int = 0, j:int = totalVertices - 1; i < totalVertices; j = i, i++)
			{
				var edgeStart:Point2 = polygon[i];
				var edgeEnd:Point2 = polygon[j];
				var edgeStartX:Number = edgeStart.x;
				var edgeStartY:Number = edgeStart.y;
				var edgeX:Number = edgeEnd.x - edgeStartX;
				var edgeY:Number = edgeEnd.y - edgeStartY;
				var squareEdgeLength:Number = edgeX * edgeX + edgeY * edgeY;
				var tangent:Number = Mathematics.clamp(squareEdgeLength == 0 ? 0 : ((circleX - edgeStartX) * edgeX + (circleY - edgeStartY) * edgeY) / squareEdgeLength, 0.0, 1.0);
				var currentClosestPointX:Number = edgeStartX + edgeX * tangent;
				var currentClosestPointY:Number = edgeStartY + edgeY * tangent;
				var dx:Number = circleX - currentClosestPointX;
				var dy:Number = circleY - currentClosestPointY;
				var squareDistance:Number = dx * dx + dy * dy;
				if (squareDistance < minimumSquareDistance)
				{
					minimumSquareDistance = squareDistance;
					var closestPointX:Number = currentClosestPointX;
					var closestPointY:Number = currentClosestPointY;
				}
			}
			return  minimumSquareDistance < circleRadius * circleRadius || polygonContainsPoint(circleX, circleY, polygon)
				? point(closestPointX, closestPointY) // note Math.abs(minimumSquareDistance) is the MTV vector length
				: null;
		}

		static public function circleLineIntersection(circleX:Number, circleY:Number, circleRadius:Number, lineStartX:Number, lineStartY:Number, lineEndX:Number, lineEndY:Number, flyweight:Point2 = null):Point2
		{
			if (!flyweight) flyweight = new Point2;
			const lineX:Number = lineEndX - lineStartX;
			const lineY:Number = lineEndY - lineStartY;
			const lineLengthSquared:Number = lineX * lineX + lineY * lineY;
			const tangent:Number = Mathematics.clamp(lineLengthSquared == 0 ? 0 : ((circleX - lineStartX) * lineX + (circleY - lineStartY) * lineY) / lineLengthSquared, 0.0, 1.0);
			const closestPointX:Number = lineStartX + lineX * tangent;
			const closestPointY:Number = lineStartY + lineY * tangent;
			const dx:Number = circleX - closestPointX;
			const dy:Number = circleY - closestPointY;
			return dx * dx + dy * dy < circleRadius * circleRadius
				? flyweight.setTo(closestPointX, closestPointY)
				: null;
		}
		
		/***************************************************************************************************************************
		 * internal
		 **************************************************************************************************************************/
		
		static internal function point(x:Number = 0, y:Number = 0):Point2
		{
			return useFlyweightPoints
				? (_pointPool.getInstance() as Point2).setTo(x, y)
				: new Point2(x, y);
		}
		
		static internal function points(...coordinates):Vector.<Point2>
		{
			while (coordinates.length > 0 && (coordinates[0] is Array || coordinates[0] is Vector.<Number>))
				coordinates = coordinates[0];
				
			const totalCoordinates:int = coordinates.length;
			if (totalCoordinates & 1 == 1)
				throw new ArgumentError('require even number of coordinates');
			
			var points:Vector.<Point2>;
			if (useFlyweightPoints)
			{
				_pointVector.length = 0;
				points = _pointVector;
			}
			else
			{
				points = new Vector.<Point2>;
			}
			
			for (var i:int = 0; i < totalCoordinates - 1; i += 2)
				points.push(point(coordinates[i], coordinates[i + 1]));
				
			return points;
		}
		
	}

}