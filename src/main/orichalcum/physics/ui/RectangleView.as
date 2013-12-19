package orichalcum.physics.ui 
{
	import flash.display.Sprite;
	import orichalcum.geometry.Rectangle2;
	import orichalcum.physics.IBody;
	import orichalcum.physics.ICollidable;

	public class RectangleView extends Sprite implements ICollidable
	{
		
		private var _body:IBody;
		private var _color:uint = 0xffffff * Math.random();
		
		public function RectangleView(body:IBody) 
		{
			this.body = body;
		}
		
		public function get body():IBody 
		{
			return _body;
		}
		
		public function set body(value:IBody):void
		{
			_body = value;
			render();
		}
		
		public function render():void
		{
			const rectangle:Rectangle2 = body.geometry as Rectangle2;
			const halfWidth:Number = rectangle.width * 0.5;
			const halfHeight:Number = rectangle.height * 0.5;
			x = rectangle.x + halfWidth;
			y = rectangle.y + halfHeight;
			rotation = body.rotation;
			graphics.clear();
			graphics.lineTo(rectangle.width * 0.5, rectangle.height * 0.5);
			graphics.beginFill(_color);
			graphics.drawRect(-halfWidth, -halfHeight, rectangle.width, rectangle.height);
			graphics.endFill();
		}
		
	}

}