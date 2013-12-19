package orichalcum.physics.body.geometry.ui 
{
	import flash.geom.Point;
	import orichalcum.physics.body.geometry.Circle;
	import orichalcum.physics.IBody;
	import orichalcum.physics.ICollidable;
	import orichalcum.physics.VerletBody;

	public class PointView extends ShapeView implements ICollidable
	{
		
		private var _body:IBody;
		public var radius:Number;
		
		public function PointView(body:IBody, radius:Number = 4, fillColor:uint = 0, lineColor:uint = 0, lineWidth:Number = 1) 
		{
			super(fillColor, lineColor, lineWidth);
			this.body = body;
			this.radius = radius;
		}
		
		public function get body():IBody 
		{
			return _body;
		}
		
		public function set body(value:IBody):void 
		{
			_body = value;
		}
		
		public function onBodyChange():void
		{
			render();
		}
		
		override public function render():void 
		{
			const model:Point = body.geometry as Point;
			this.x = model.x;
			this.y = model.y;
			this.rotation = body.rotation;
			graphics.clear();
			graphics.lineStyle(lineWidth, lineColor);
			graphics.lineTo(0, radius);
			graphics.beginFill(fillColor);
			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
		}
		
	}

}