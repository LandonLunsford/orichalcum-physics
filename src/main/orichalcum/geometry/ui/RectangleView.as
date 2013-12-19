package orichalcum.geometry.ui 
{
	import flash.geom.Rectangle;
	import orichalcum.geometry.Rectangle2;

	public class RectangleView extends ShapeView
	{
		
		private var _model:Rectangle2;
		
		public function RectangleView(model:Rectangle2 = null, fillColor:uint = 0, lineColor:uint = 0, lineWidth:Number = 1)
		{
			super(fillColor, lineColor, lineWidth);
			_model = model ||= new Rectangle2;
			render();
		}
		
		public function get model():Rectangle2
		{
			return _model;
		}
		
		public function set model(value:Rectangle2):void
		{
			_model = value ||= new Rectangle2;
			render();
		}
		
		override public function render():void
		{
			const halfWidth:Number = model.width * 0.5;
			const halfHeight:Number = model.height * 0.5;
			x = model.x + halfWidth;
			y = model.y + halfHeight;
			graphics.clear();
			graphics.lineStyle(lineWidth, lineColor);
			graphics.lineTo(model.width * 0.5, model.height * 0.5);
			graphics.beginFill(fillColor);
			graphics.drawRect(-halfWidth, -halfHeight, model.width, model.height);
			graphics.endFill();
		}
		
	}

}