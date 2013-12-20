package orichalcum.physics.geometry.view 
{
	import orichalcum.physics.body.IBody;
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.geometry.Circle;

	public class CircleView extends ShapeView implements ICollidable
	{
		
		private var _body:IBody;
		
		public function CircleView(body:IBody, fillColor:uint = 0, lineColor:uint = 0, lineWidth:Number = 1) 
		{
			super(fillColor, lineColor, lineWidth);
			this.body = body;
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
			const model:Circle = body.geometry as Circle;
			this.x = model.x;
			this.y = model.y;
			this.rotation = body.rotation;
			
			graphics.clear();
			graphics.beginFill(fillColor);
			graphics.lineStyle(lineWidth, lineColor);
			graphics.moveTo(0,0)
			graphics.lineTo(0, model.radius);
			graphics.drawCircle(0, 0, model.radius);
			graphics.endFill();
		}
		
	}

}