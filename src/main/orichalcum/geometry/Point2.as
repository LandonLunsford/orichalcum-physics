package orichalcum.geometry
{
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	public class Point2 implements IGeometry2
	{
		private var _x:Number;
		private var _y:Number;
		
		public function Point2(x:Number = 0, y:Number = 0)
		{
			this.x = x;
			this.y = y;
		}
		
		public function get x():Number 
		{
			return _x;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
		}
		
		public function setTo(x:Number = 0, y:Number = 0):Point2
		{
			this.x = x;
			this.y = y;
			return this;
		}
		
		public function copyFrom(point:Point2):Point2
		{
			return setTo(point.x, point.y);
		}
		
		public function get isZero():Boolean
		{
			return x == y == 0;
		}
		
		public function get squareLength():Number
		{
			return x * x + y * y;
		}
		
		public function get length():Number
		{
			return Math.sqrt(squareLength);
		}
		
		public function set length(value:Number):void
		{
			timesEquals(isZero == 0 ? 0 : value / length);
		}
		
		public function get angle():Number
		{
			return Math.atan2(y, x);
		}
		
		public function set angle(value:Number):void
		{
			const length:Number = this.length;
			setTo(Math.cos(value) * length, Math.sin(value) * length);
		}

		public function equals(point:Point2):Boolean
		{
			return point && x == point.x && y == point.y;
		}
		
		public function plus(point:Point2):Point2
		{
			return new Point2(x + point.x, y + point.y);
		}
		
		public function plusEquals(point:Point2):Point2
		{
			return setTo(x + point.x, y + point.y);
		}
		
		public function minus(point:Point2):Point2
		{
			return new Point2(x - point.x, y - point.y);
		}
		
		public function minusEquals(point:Point2):Point2
		{
			return setTo(x - point.x, y - point.y);
		}
		
		public function times(scalar:Number):Point2
		{
			return new Point2(x * scalar, y * scalar);
		}
		
		public function timesEquals(scalar:Number):Point2
		{
			return setTo(x * scalar, y * scalar);
		}
		
		public function divide(scalar:Number):Point2
		{
			return times(scalar == 0 ? 0 : 0.0001 / scalar);
		}
		
		public function divideEquals(scalar:Number):Point2
		{
			return timesEquals(scalar == 0 ? 0.0001 : 1 / scalar);
		}
		
		public function abs():Point2
		{
			return new Point2(x < 0 ? -x : x, y < 0 ? -y : y);
		}
		
		public function absEquals():Point2
		{
			return setTo(x < 0 ? -x : x, y < 0 ? -y : y);
		}
		
		public function unit():Point2
		{
			return divide(length);
		}
		
		public function toUnit():Point2
		{
			return divideEquals(length);
		}
		
		public function normal():Point2
		{
			return new Point2(-y, x);
		}
		
		public function toNormal():Point2
		{
			return setTo(-y, x);
		}
		
		public function toZero():Point2
		{
			return setTo(0, 0);
		}
		
		/**
		 * @usage usually you want to normalize param "point" before use
		 */
		public function dot(vector:Point2):Number 
		{
			return x * vector.x + y * vector.y;
		}
		
		/**
		 * @usage usually you want to normalize param "point" before use
		 */
		public function perpDot(vector:Point2):Number 
		{
			return -y * vector.x + x * vector.y;
		}
		
		public function cross(vector:Point2):Number
		{
			return x * vector.y - y * vector.x;
		}
		
		/**
		 * @usage usually you want to normalize param "target" before use
		 */
		public function project(vector:Point2, damping:Number = 1):Point2
		{
			const dotProduct:Number = dot(vector) * damping;
			return setTo(vector.x * dotProduct, vector.y * dotProduct);
		}
		
		public function projectOnto(vector:Point2):Point2
		{
			const dotProduct:Number = dot(vector);
			const f:Number = dotProduct / (vector.x * vector.x + vector.y * vector.y);
			return new Point2(f * vector.x, f * vector.y);
		}
		
		public static function projectOntoAngle(theta:Number, magnitude:Number):Point2
		{
			return new Point2(Math.cos(theta) * magnitude, Math.sin(theta) * magnitude);
		}
		
		public function reflect(vector:Point2, damping:Number = 1):Point2
		{
			const dotProduct:Number =  dot(vector) * 2;
			return setTo((dotProduct * vector.x - x) * damping, (dotProduct * vector.y - y) * damping);
		}
		
		public function crossScalar(scalar:Number):Point2
		{
			return new Point2(-scalar * y, scalar * x);
		}
		
		public function angleWith(vector:Point2):Number
		{
			//return Math.acos(dotProduct(point) / (length * point.length));
			return Math.atan2(vector.y - y, vector.x - x);
		}
		
		public function distance(point:Point2):Number
		{
			return Math.sqrt(squareDistance(point));
		}

		public function squareDistance(point:Point2):Number
		{
			const dx:Number = point.x - x;
			const dy:Number = point.y - y;
			return dx * dx + dy * dy;
		}

		public function trap(maximumLength:Number):Point2
		{
			if (length > maximumLength)
				length = maximumLength;
			return this;
		}
		
		public function interpolate(progress:Number, pointX:Number, pointY:Number):Point2
		{
			return new Point2(x + (pointX - x) * progress, y + (pointY - y) * progress);
		}

		public function interpolateEquals(progress:Number , pointX:Number, pointY:Number):Point2
		{
			return setTo(x + (pointX - x) * progress, y + (pointY - y) * progress);
		}
		
		public function rotate(degrees:Number):Point2
		{
			const radians:Number = degrees * Geometry2.DEGREES_TO_RADIANS;
			const cos:Number = Math.cos(radians);
			const sin:Number = Math.sin(radians);
			return new Point2(cos * x - sin * y, cos * y + sin * x);
		}

		public function rotateEquals(degrees:Number):Point2
		{
			const radians:Number = degrees * Geometry2.DEGREES_TO_RADIANS;
			const cos:Number = Math.cos(radians);
			const sin:Number = Math.sin(radians);
			return this.setTo(cos * x - sin * y, cos * y + sin * x);
		}
		
		public function rotateAbout(pointX:Number, pointY:Number, degrees:Number):Point2
		{
			const dx:Number = x - pointX;
			const dy:Number = y - pointY;
			const radians:Number = degrees * Geometry2.DEGREES_TO_RADIANS;
			const cos:Number = Math.cos(radians);
			const sin:Number = Math.sin(radians);
			return new Point2(pointX + cos * dx - sin * dy, pointY + cos * dy + sin * dx);
		}
		
		public function rotateAboutEquals(pointX:Number, pointY:Number, degrees:Number):Point2
		{
			const dx:Number = x - pointX;
			const dy:Number = y - pointY;
			const radians:Number = degrees * Geometry2.DEGREES_TO_RADIANS;
			const cos:Number = Math.cos(radians);
			const sin:Number = Math.sin(radians);
			return setTo(pointX + cos * dx - sin * dy, pointY + cos * dy + sin * dx);
		}
		
		public function toXML(numberPrecision:uint = 2):String
		{
			return '<' + getQualifiedClassName(this)
				+ ' x="' + x.toFixed(numberPrecision)
				+ '" y="' + y.toFixed(numberPrecision)
				+ '"/>';
		}
		
		public function toJSON(k:*):*
		{
			return { x:x, y:y };
		}
		
		public function toString():String
		{
			return toXML();
		}
		
		public function toPoint(flyweight:Point = null):Point
		{
			const point:Point = flyweight || new Point;
			point.x = x;
			point.y = y;
			return point;
		}
		
		/* INTERFACE orihalcum.geometry.IGeometry */
		
		public function getCenter(flyweight:Point2 = null):Point2
		{
			if (!flyweight) flyweight = new Point2;
			return flyweight.setTo(x, y);
		}
		
		public function get area():Number 
		{
			return 0;
		}
		
		public function position(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
		}
		
		public function translate(x:Number, y:Number, rotation:Number = 0):void
		{
			this.x += x;
			this.y += y;
		}
		
	}

}