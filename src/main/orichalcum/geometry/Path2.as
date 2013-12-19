package orichalcum.geometry 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @todo add different interpolation strategies
	 * http://www.antigrain.com/research/bezier_interpolation/index.html
	 * aspline, bspline, xspline, bezier(quadratic), bezier(cubic)
	 * 
	 * 
	 * @todo Program Imple which uses points optimal condition and make all things points
	 * @todo Consider using linked list if random access is not necessary
	 * 
	 * Length calculation, can be paralellized with add if you cannot modify the points later
	 * Min/Max can be parallelized with add if you cannot modify the points later
	 * Table can be kept of each segment length for quick lookup on interpolate if the above
	 * 
	 * Currently no interpolation blending
	 * 
	 * All the direct accessing of _x,_y Path1's is so I can splice on simplify -- implement remove algo
	 * 
	 * 
	 * This class is a discrete path made up of a series of points
	 * 
	 * @author Landon Lunsford
	 */

	public class Path2
	{
		private var _points:Vector.<Point>;
		private var _length:Number;
		
		public function Path2()
		{
			_points = new Vector.<Point>();
		}
		
		public function get points():Vector.<Point>
		{
			return _points;
		}
		
		public function set points(points:Vector.<Point>):void
		{
			_points = points ||= new Vector.<Point>();
		}
		
		public function get first():Point
		{
			return isEmpty ? null : _points[0];
		}

		public function get last():Point
		{
			return isEmpty ? null : _points[resolution-1];
		}
		
		public function get length():Number 
		{
			if (resolution < 2) return 0;
			var length:Number = 0;
			for (var i:int = 1; i < resolution; i++)
				length += Point.distance(_points[i - 1], _points[i]);
			return length;
		}
		
		public function get resolution():int 
		{
			return isEmpty ? 0 : _points.length;
		}
		
		public function get bounds():Rectangle
		{
			if (isEmpty) return new Rectangle();
			
			var left:Number = Number.MAX_VALUE;
			var right:Number = Number.MIN_VALUE;
			var top:Number = Number.MAX_VALUE;
			var bottom:Number = Number.MIN_VALUE;
			for each(var point:Point in points)
			{
				if (point.x < left) left = point.x;
				else if (point.x > right) right = point.x;
				if (point.y < top) top = point.y;
				else if (point.y > bottom) bottom = point.y;
			}
			return new Rectangle(left, top, right - left, bottom - top);
		}
		
		public function normalize(scalar:Number = 1):void 
		{
			if (isEmpty) return;
			
			var bounds:Rectangle = bounds;
			var left:Number = bounds.left;
			var top:Number = bounds.top;
			var width:Number = bounds.width;
			var height:Number = bounds.height;
			var factor:Number = width > height ? scalar / width : scalar / height;
			for each(var point:Point in points)
			{
				point.x = (point.x - left) * factor;
				point.y = (point.y - top) * factor;
			}
		}
		
		/**
		 * Works best when drawing circles and points are widely spaced
		 * Works worst when very close points are made and zig zags
		 * May be a good idea to scale up before simplifying for more accurate results
		 */
		public function simplify(resolution:int):void 
		{
			if (isEmpty) return;
			
			var currentResolution:Number = this.resolution;
			if (currentResolution < 2 || currentResolution == resolution) return;
			if (resolution < 2) resolution = 1;
			const cr:Number = (length-1) / resolution; // make radius slightly smaller to compensate for inpresice end
			const cr2:Number = cr * cr;
			var cx:Number = first.x;
			var cy:Number = first.y;
			
			for (var i:int = 1; i < currentResolution; i++)
			{
				var dx:Number = _points[i].x - cx;
				var dy:Number = _points[i].y - cy;
				var a:Number = dx * dx + dy * dy;
				var d:Number = 4 * a * cr2;
				if (d <= 0) continue;
				var u:Number = Math.sqrt(d) / (2 * a);
				if (u < 0 || u > 1) continue;
				cx = cx + u * dx;
				cy = cy + u * dy;
				_points.push(new Point(cx, cy));
			}
			_points.splice(0, currentResolution);
		}
		
		public function clear():void 
		{
			points.length = 0;
		}
		
		public function add(x:Number, y:Number):void 
		{
			points.push(new Point(x, y));
		}
		
		public function remove(index:int, count:int = 1):void
		{
			points.splice(index, count);
		}

		public function interpolate(progress:Number):Point
		{
			if (isEmpty) throw new Error('Path2 cannot be interpolated when empty');
			/**
			 * Bezeir curve
			 * var x:Number = (x3 - 2 * x2 + x1) * t * t + (2 * x2 -2 * x1) * t + x1;
			 * var y:Number = (y3 - 2 * y2 + y1) * t * t + (2 * y2 -2 * y1) * t + y1;
			 */
			
			/**
			 * Discrete nearest index approximation
			 * accurate when points are uniformly distributed
			 */
			//var index:int = int(resolution * progress);
			//return index < resolution ?
				//new Point(_points[index].x, _points[index].y) :
				//new Point(last.x, last.y);
			
			/**
			 * Linear approximation
			 * O(n) because must calculate running length up to progress
			 */
			if (progress <= 0) return first.clone();
			if (progress >= 1) return last.clone();
			var endPosition:Number = length * progress;
			var currPosition:Number = 0;
			for (var i:int = 1; i < resolution && currPosition < endPosition; i++)
			{
				var previous:Point = _points[i - 1];
				var current:Point = _points[i];
				var distance:Number = Point.distance(previous, current);
				currPosition += distance;
			}
			return Point.interpolate(current, previous, (currPosition - endPosition) / distance);
		}
		
		/*
		var count		:uint = 0;
		var avgDistSquared	:Number = 0;
		var max			:int = (path.length*2 < raw_data[i].length)? path.length : raw_data[i].length*.5;
		
		for (var j:uint = 0; j<max; j++) {
			var dx:Number = raw_data[i][count] - path[j].x;
			count ++;
			var dy:Number = raw_data[i][count] - path[j].y;
			count ++;
			var distSquared:Number = dx*dx + dy*dy;
			avgDistSquared += distSquared;
		}
		avgDistSquared /= max;
		
		*/
		
		/**
		 * This is applicable when generating a path comparison index
		 * @param	path the path to compare points with
		 * @return	the point sum of point to point distances between two paths squared
		 */
		public function deltaIndex(path:Path2):Number
		{
			var deltaIndex:Number = 0;
			var end:int = resolution < path.resolution? resolution : path.resolution;
			for (var i:int = 0; i < end; i++)
			{
				var dx:Number = points[i].x - path.points[i].x;
				var dy:Number = points[i].y - path.points[i].y;
				deltaIndex += dx * dx + dy * dy;
			}
			return deltaIndex;
		}
		
		/**
		 * This is applicable when generating a path comparison index
		 * @return Vector of length 16 where each index corresponds to a direction to which a line segment in the path points
		 * These values are normalized with the overall point count
		 */
		public function vectorIndex():Vector.<Number>
		{
			return null;
		}
		
		public function clone():Path2
		{
			const clone:Path2 = new Path2();
			for each(var point:Point in _points)
				clone.add(point.x, point.y);
			return clone;
		}
		
		public function get isEmpty():Boolean
		{
			return _points == null || _points.length == 0;
		}
		
		private function reverse():Path2
		{
			const clone:Path2 = clone();
			clone.points.reverse();
			return clone;
		}
	
	}

}