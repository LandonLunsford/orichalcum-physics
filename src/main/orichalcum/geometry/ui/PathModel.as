package orichalcum.geometry.ui 
{
	import orichalcum.geometry.Path2;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	/**
	 * Uses decorator pattern to intercept calls on methods
	 * which change the data model so it can effectively notify
	 * listeners such as views
	 */

	public class PathModel extends ShapeModel
	{
		private var _path:Path2;
		
		public function PathModel(path:Path2) 
		{
			_path = path;
			dispatchChangeEvent();
		}
		
		public function get path():Path2
		{
			return _path;
		}
		
		public function get first():Point
		{
			return _path.first;
		}
		
		public function get last():Point
		{
			return _path.last;
		}
		
		public function get length():Number 
		{
			return _path.length;
		}
		
		public function get resolution():int 
		{
			return _path.resolution;
		}
		
		public function normalize(scalar:Number = 1):void 
		{
			_path.normalize(scalar);
			dispatchChangeEvent();
		}
		
		public function simplify(resolution:int):void 
		{
			if (this.resolution == resolution) return;
			_path.simplify(resolution);
			dispatchChangeEvent();
		}
		
		public function clear():void 
		{
			if (resolution == 0) return;
			_path.clear();
			dispatchChangeEvent();
		}
		
		public function add(x:Number, y:Number):void 
		{
			_path.add(x, y);
			dispatchChangeEvent();
		}
		
		public function interpolate(progress:Number):Point
		{
			return _path.interpolate(progress);
		}
		
		public function get points():Vector.<Point>
		{
			return _path.points;
		}
		
		public function delta(path:Path2):Number
		{
			return _path.delta(path);
		}
		
	}

}