package com.orihalcum.geometry
{
	import com.orihalcum.utility.GeometryUtil;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	public class Vector2 extends Point
	{
		
		public function Vector2(x:Number = 0, y:Number = 0)
		{
			this.x = x;
			this.y = y;
		}
		
		public function init(x:Number = 0, y:Number = 0):Vector2
		{
			this.x = x;
			this.y = y;
			return this;
		}
		
		public function load(vector:Point):Vector2
		{
			this.x = vector.x;
			this.y = vector.y;
			return this;
		}
		
		public function get isZero():Boolean
		{
			return x == y == 0;
		}
		
		public function get lengthSquared():Number
		{
			return x * x + y * y;
		}
		
		override public function get length():Number
		{
			return Math.sqrt(lengthSquared);
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
			x = Math.cos(value) * length;
			y = Math.sin(value) * length;
		}

		override public function equals(vector:Point):Boolean
		{
			return vector && x == vector.x && y == vector.y;
		}
		
		public function plus(vector:Point):Vector2
		{
			return new Vector2(x + vector.x, y + vector.y);
		}
		
		public function plusEquals(vector:Point):Vector2
		{
			x += vector.x;
			y += vector.y;
			return this;
		}
		
		public function minus(vector:Point):Vector2
		{
			return new Vector2(x - vector.x, y - vector.y);
		}
		
		public function minusEquals(vector:Point):Vector2
		{
			x -= vector.x;
			y -= vector.y;
			return this;
		}
		
		public function times(scalar:Number):Vector2
		{
			return new Vector2(x * scalar, y * scalar);
		}
		
		public function timesEquals(scalar:Number):Vector2
		{
			x *= scalar;
			y *= scalar;
			return this;
		}
		
		public function divide(scalar:Number):Vector2
		{
			return times(scalar == 0 ? 0 : 0.0001 / scalar);
		}
		
		public function divideEquals(scalar:Number):Vector2
		{
			return timesEquals(scalar == 0 ? 0.0001 : 1 / scalar);
		}
		
		public function abs():Vector2
		{
			return new Vector2(x < 0 ? -x : x, y < 0 ? -y : y);
		}
		
		public function absEquals():Vector2
		{
			if (x < 0) x = -x;
			if (y < 0) y = -y;
			return this;
		}
		
		public function unit():Vector2
		{
			return divide(length);
		}
		
		public function toUnit():Vector2
		{
			return divideEquals(length);
		}
		
		public function normal():Vector2
		{
			return new Vector2(-y, x);
		}
		
		public function toNormal():Vector2
		{
			const temp:Number = x;
			x = -y;
			y = temp;
			return this;
		}
		
		public function toZero():Vector2
		{
			x = y = 0;
			return this;
		}
		
		/**
		 * @usage usually you want to normalize param "point" before use
		 */
		public function dot(vector:Point):Number 
		{
			return x * vector.x + y * vector.y;
		}
		
		/**
		 * @usage usually you want to normalize param "point" before use
		 */
		public function perpDot(vector:Point):Number 
		{
			return -y * vector.x + x * vector.y;
		}
		
		public function cross(vector:Point):Number
		{
			return x * vector.y - y * vector.x;
		}
		
		/**
		 * @usage usually you want to normalize param "target" before use
		 */
		public function project(target:Point, damping:Number = 1):Vector2
		{
			const dotProduct:Number = dot(target) * damping;
			x = target.x * dotProduct;
			y = target.y * dotProduct;
			return this;
		}
		
		public function projectOnto(vector:Point):Vector2
		{
			const dotProduct:Number = dot(vector);
			const f:Number = dotProduct / (vector.x * vector.x + vector.y * vector.y);
			return new Vector2(f * vector.x, f * vector.y);
		}
		
		public static function projectOntoAngle(theta:Number, magnitude:Number):Vector2
		{
			return new Vector2(Math.cos(theta) * magnitude, Math.sin(theta) * magnitude);
		}
		
		public function reflect(vector:Point, damping:Number = 1):Vector2
		{
			const dotProduct:Number =  dot(vector) * 2;
			x = (dotProduct * vector.x - x) * damping;
			y = (dotProduct * vector.y - y) * damping;
			return this;
		}
		
		public function crossScalar(scalar:Number):Vector2
		{
			return new Vector2(-scalar * y, scalar * x);
		}
		
		public function angleWith(v:Vector2):Number
		{
			//return Math.acos(dotProduct(point) / (length * point.length));
			return Math.atan2(v.y - y, v.x - x);
		}
		
		public function distance(v:Vector2):Number
		{
			return Math.sqrt(squareDistance(v));
		}

		public function squareDistance(vector:Point):Number
		{
			const dx:Number = vector.x - x;
			const dy:Number = vector.y - y;
			return dx * dx + dy * dy;
		}

		public function trap(maximumLength:Number):Vector2
		{
			if (length > maximumLength)
				length = maximumLength;
			return this;
		}
		
		public function interpolate(progress:Number, vector:Vector2):Vector2
		{
			return new Vector2(x + (vector.x - x) * progress, y + (vector.y - y) * progress);
		}

		public function interpolateEquals(progress:Number , vector:Vector2):Vector2
		{
			x = x + (vector.x - x) * progress;
			y = y + (vector.y - y) * progress;
			return this;
		}
		
		public function rotate(degrees:Number):Vector2
		{
			const radians:Number = GeometryUtil.toRadians(degrees);
			const cos:Number = Math.cos(radians);
			const sin:Number = Math.sin(radians);
			return new Vector2(cos * x - sin * y, cos * y + sin * x);
		}

		public function rotateEquals(degrees:Number):Vector2
		{
			const radians:Number = GeometryUtil.toRadians(degrees);
			const cos:Number = Math.cos(radians);
			const sin:Number = Math.sin(radians);
			this.x = cos * x - sin * y;
			this.y = cos * y + sin * x;
			return this;
		}
		
		public function rotateAbout(point:Point, degrees:Number):Vector2
		{
			const dx:Number = x - point.x;
			const dy:Number = y - point.y;
			const radians:Number = GeometryUtil.toRadians(degrees);
			const cos:Number = Math.cos(radians);
			const sin:Number = Math.sin(radians);
			return new Vector2(point.x + cos * dx - sin * dy, point.y + cos * dy + sin * dx);
		}
		
		public function rotateAboutEquals(point:Point, degrees:Number):Vector2
		{
			const dx:Number = x - point.x;
			const dy:Number = y - point.y;
			const radians:Number = GeometryUtil.toRadians(degrees);
			const cos:Number = Math.cos(radians);
			const sin:Number = Math.sin(radians);
			this.x = point.x + cos * dx - sin * dy;
			this.y = point.y + cos * dy + sin * dx;
			return this;
		}
		
		public function toXML(numberPrecision:uint = 2):String
		{
			return '<' + getQualifiedClassName(this)
				+ ' x="' + x.toFixed(numberPrecision)
				+ '" y="' + y.toFixed(numberPrecision)
				+ '"/>';
		}
		
		//public function toPoint():Point
		//{
			//return new Point(x, y);
		//}
		
	}

}