package orichalcum.geometry.ui 
{
	
	import orichalcum.geometry.Circle2;

	public class CircleView extends ShapeView
	{
		private var _model:Circle2;
		
		public function CircleView(model:Circle2 = null, fillColor:uint = 0, lineColor:uint = 0, lineWidth:Number = 1)
		{
			super(fillColor, lineColor, lineWidth);
			_model = model ||= new Circle2;
			render();
		}
		
		public function get model():Circle2
		{
			return _model;
		}
		
		public function set model(value:Circle2):void
		{
			_model = value ||= new Circle2;
			render();
		}
		
		override public function render():void
		{
			x = model.x;
			y = model.y;
			graphics.clear();
			graphics.lineStyle(lineWidth, lineColor);
			graphics.lineTo(0, model.radius);
			graphics.beginFill(fillColor);
			graphics.drawCircle(0, 0, model.radius);
			graphics.endFill();
		}
		
	}

}