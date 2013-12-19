package orichalcum.geometry.ui 
{
	import orichalcum.geometry.Point2;

	public class PointView extends ShapeView
	{
		private var _model:Point2;
		
		public function PointView(model:Point2 = null, fillColor:uint = 0, lineColor:uint = 0, lineWidth:Number = 1)
		{
			super(fillColor, lineColor, lineWidth);
			_model = model ||= new Point2;
			render();
		}
		
		public function get model():Point2
		{
			return _model;
		}
		
		public function set model(value:Point2):void
		{
			_model = value ||= new Point2;
			render();
		}
		
		override public function render():void
		{
			x = model.x;
			y = model.y;
			graphics.clear();
			graphics.lineStyle(lineWidth, lineColor);
			graphics.beginFill(fillColor);
			graphics.drawCircle(0, 0, 2);
			graphics.endFill();
		}
		
	}

}