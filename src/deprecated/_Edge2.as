package com.orihalcum.geometry.model
{
	import flash.geom.Point;

	public class Edge2 
	{
		public var ax:Number;
		public var ay:Number;
		public var bx:Number;
		public var by:Number;
		
		public function set x(value:Number):void { bx = ax + value; }
		public function set y(value:Number):void { by = ay + value; }		
		public function get x():Number { return bx - ax; }
		public function get y():Number { return by - ay; }
		public function get m():Number { return Math.sqrt(m2); }
		public function get m2():Number { return x * x + y * y; }
		public function get nx():Number { return n(x); }
		public function get ny():Number { return n(y); }
		public function get lx():Number { return -y; }
		public function get ly():Number { return x; }
		public function get lnx():Number { return n(-y); }
		public function get lny():Number { return n(x); }
		public function get angle():Number { return Math.atan2(y,x); }

		public function angleWith(v:Vector2):Number { return Math.acos(nx * v.nx + ny * v.ny); }
		public function dp(v:Vector2):Number { return x * v.nx + y * v.ny; }
		public function pdp(v:Vector2):Number { return lx * v.nx + ly * v.ny; }
		public function px(v:Vector2):Number { return dp(v) * v.nx; }
		public function py(v:Vector2):Number { return dp(v) * v.ny; }
		public function zero():void { ax = ay = bx = by = 0;  }
		
		public function Edge2(ax:Number=0, ay:Number=0, bx:Number=0, by:Number=0)
		{
			this.ax = ax;
			this.ay = ay;
			this.bx = bx;
			this.by = by;
		}
		
		public function init(ax:Number=0, ay:Number=0, bx:Number=0, by:Number=0):void
		{
			this.ax = ax;
			this.ay = ay;
			this.bx = bx;
			this.by = by;
		}
		
		public function load(v:Edge2):void
		{
			this.ax = v.ax;
			this.ay = v.ay;
			this.bx = v.bx;
			this.by = v.by;
		}
		
		public function normalize(scale:Number=1):void
		{
			var im:Number = 1/m;
			if (!isFinite(im)) im = 0;
			bx = ax + x * scale * im;
			by = ax + y * scale * im;
		}
		
		public function project(v:Vector2, c:Number=1):void
		{
			var dp:Number = dp(v) * c;
			bx = ax + dp * v.nx;
			by = ay + dp * v.ny;
		}
		
		public function reflect(v:Vector2, c:Number=1):void
		{
			var dp2:Number =  2 * dp(v);
			bx = ax + ( dp2 * v.nx - x ) * c;
			by = ay + ( dp2 * v.ny - y ) * c;
		}
		
		public function reverse():void
		{
			var tx:Number = bx;
			var ty:Number = by;
			bx = ax;
			by = ay;
			ax = tx;
			ay = ty;
		}
		
		public function negate():void
		{
			ax = -ax;
			ay = -ay;
			bx = -bx;
			by = -by;
		}
		
		public function t(v:Vector2):Number
		{
			var pdp:Number = -(by - ay) * v.nx + (bx - ax) * v.ny;
			if (pdp == 0) return 0.0001;
			return ( -(v.ay - ay) * v.nx + (v.ax - ax) * v.ny) / pdp;
		}
		
		//private function n(n:Number):Number
		//{
			//var im:Number = 1 / m;
			//return isFinite(im) ? n * im : 0.0001;
		//}
		
		public function collisionM(v:Vector2):Number
		{
			return (v.ax - ax) * v.lnx + (v.ay - ay) * v.lny;
		}
		
		public function crossed(v:Vector2):Boolean
		{
			//var v3ax = ax;
			//var v3ay = ay;
			//var v3bx = v.ax;
			//var v3by = v.ay;
			//var v3x = v.ax - ax;
			//var v3y = v.ay - ay;
			//v3.x * edge.lnx + v3.y * edge.lny
			// evaluates true when on right side of vector // does not consider scope
			return (v.ax - ax) * v.lnx + (v.ay - ay) * v.lny < 0; 
		}

	}

}