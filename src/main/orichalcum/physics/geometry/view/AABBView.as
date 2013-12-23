package orichalcum.physics.geometry.view 
{
	import orichalcum.physics.body.IBody;
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.geometry.AABB;

	public class AABBView extends ShapeView implements ICollidable
	{
		
		private var _body:IBody;
		
		public function AABBView(body:IBody, fillColor:uint = 0, lineColor:uint = 0, lineWidth:Number = 1)
		{
			super(fillColor, lineColor, lineWidth);
			this.body = body;
			//trace(this.body)
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
			const model:AABB = body.geometry as AABB;
			const halfWidth:Number = model.width * 0.5;
			const halfHeight:Number = model.height * 0.5;
			this.x = model.x + halfWidth;
			this.y = model.y + halfHeight;
			
			// its an aabb bro
			//this.rotation = body.rotation;
			
			graphics.clear();
			graphics.lineStyle(lineWidth, lineColor);
			graphics.lineTo(model.width * 0.5, model.height * 0.5);
			graphics.beginFill(fillColor);
			graphics.drawRect(-halfWidth, -halfHeight, model.width, model.height);
			graphics.endFill();
		}
		
	}

}