package orichalcum.physics.ui 
{
	import orichalcum.geometry.Circle2;
	import orichalcum.physics.IBody;
	import orichalcum.physics.ICollidable;

	public class CircleView extends orichalcum.geometry.ui.CircleView implements ICollidable
	{
		
		private var _body:IBody;
		
		public function CircleView(body:IBody) 
		{
			_body = body;
			super(body.geometry as Circle2);
		}
		
		public function get body():IBody 
		{
			return _body;
		}
		
		public function set body(value:IBody):void
		{
			_body = value;
		}
		
		override public function render():void 
		{
			super.render();
		}
		
	}

}