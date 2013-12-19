package orichalcum.geometry.ui 
{
	import orichalcum.geometry.Path2;
	import orichalcum.geometry.ui.PathModel;
	import flash.events.Event;
	import flash.geom.Point;

	public class PathView extends ShapeView
	{
		private var _model:PathModel;
		private var _resolution:int;
		
		public function PathView(model:PathModel = null, lineColor:uint = 0, lineWidth:Number = 1) 
		{
			super(lineColor, lineColor, lineWidth);
			this.resolution = 20;
			this.model = model ||= new PathModel(new Path2);
		}
		
		public function get resolution():int
		{
			return _resolution;
		}
		
		public function set resolution(value:int):void
		{
			if (_resolution == value) return;
			_resolution = value < 1 ? 1 : value;
			render();
		}
		
		public function get model():PathModel
		{
			return _model;
		}
		
		public function set model(model:PathModel):void
		{
			if (_model === model) return;
			if (_model) _model.removeEventListener(Event.CHANGE, render);
			if (model) model.addEventListener(Event.CHANGE, render);
			_model = model;
			render();
		}
		
		private function render(event:Event = null):void
		{
			graphics.clear();
			
			if (!_model || _model.resolution < 1) return;
			
			const points:Array = _model.points;
			const first:Point = _model.first;
			graphics.moveTo(first.x, first.y);
			graphics.lineStyle(lineWidth, lineColor);
			for each(var point:Point in points)
			{
				var x:Number = point.x;
				var y:Number = point.y;
				graphics.lineTo(x, y);
				graphics.beginFill(_color);
				graphics.drawCircle(x, y, 3);
				graphics.endFill();
			}

		}

	}

}