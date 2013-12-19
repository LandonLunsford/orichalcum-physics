package orichalcum.geometry.ui 
{
	import orichalcum.geometry.Point2;
	import orichalcum.geometry.Polygon2;

	public class PolygonView extends ShapeView 
	{
		private var _model:Polygon2;
		private var _thickness:Number;
		private var _color:uint;
		
		public function PolygonView(model:Polygon2 = null, fillColor:uint = 0, lineColor:uint = 0, lineWidth:Number = 1)
		{
			super(fillColor, lineColor, lineWidth);
			_model = model ||= new Polygon2;
			render();
		}
		
		public function get model():Polygon2
		{
			return _model;
		}
		
		public function set model(value:Polygon2):void
		{
			_model = value ||= new Polygon2;
			render();
		}
		
		override public function render():void
		{
			x = model.x;
			y = model.y;
			const vertices:Vector.<Point2> = model.vertices;
			graphics.clear();
			graphics.lineStyle(lineWidth, lineColor);
			graphics.beginFill(fillColor, 0);
			graphics.moveTo(0, 0);
			for each(var vertex:Point2 in vertices)
			{
				graphics.lineTo(vertex.x - x, vertex.y - y);
			}
			graphics.lineTo(0, 0);
			graphics.endFill();
			const center:Point2 = model.center;
			graphics.lineTo(center.x - x, center.y - y);
			trace(center);
		}
	}

}