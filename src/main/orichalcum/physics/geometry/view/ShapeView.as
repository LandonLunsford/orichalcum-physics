package orichalcum.physics.geometry.view 
{
	import flash.display.Sprite;

	internal class ShapeView extends Sprite 
	{
		private var _fillColor:uint;
		private var _lineColor:uint;
		private var _lineWidth:Number;
		
		public function ShapeView(fillColor:* = 0, lineColor:* = 0, lineWidth:Number = 1)
		{
			_fillColor = fillColor ||= randomColor;
			_lineColor = lineColor ||= fillColor;
			_lineWidth = lineWidth;
		}
		
		public function render():void
		{
			// Abstract
		}
		
		public function get lineWidth():Number 
		{
			return _lineWidth;
		}
		
		public function set lineWidth(value:Number):void 
		{
			_lineWidth = value;
			render();
		}
		
		public function get lineColor():uint 
		{
			return _lineColor;
		}
		
		public function set lineColor(value:uint):void 
		{
			_lineColor = value;
			render();
		}
		
		public function get fillColor():uint 
		{
			return _fillColor;
		}
		
		public function set fillColor(value:uint):void 
		{
			_fillColor = value;
			render();
		}
		
		protected function get randomColor():uint
		{
			return uint(uint.MAX_VALUE * 0.25 + Math.random() * uint.MAX_VALUE * 0.75);
		}
		
	}

}