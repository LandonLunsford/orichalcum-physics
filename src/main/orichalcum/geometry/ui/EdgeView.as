package orichalcum.geometry.ui 
{
	import orichalcum.geometry.Edge2;

	public class EdgeView extends ShapeView
	{
		private var _model:Edge2;
		
		public function EdgeView(model:Edge2 = null, lineColor:uint = 0, lineWidth:Number = 1) 
		{
			super(lineColor, lineColor, lineWidth);
			_model = model ||= new Edge2;
			render();
		}
		
		public function get model():Edge2
		{
			return _model;
		}
		
		public function set model(value:Edge2):void
		{
			_model = value ||= new Edge2;
			render();
		}
		
		override public function render():void
		{
			this.x = model.start.x;
			this.y = model.start.y;
			graphics.clear();
			graphics.lineStyle(lineWidth, lineColor);
			graphics.lineTo(model.end.x - x, model.end.y - y);
		}
		
	}

}