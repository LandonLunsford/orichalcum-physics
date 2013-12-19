package orichalcum.geometry 
{
	import orichalcum.geometry.Circle2;
	import orichalcum.geometry.ui.CircleView;
	import orichalcum.geometry.ui.EdgeView;
	import orichalcum.geometry.ui.PointView;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class CircleViewExample extends Sprite
	{
		private var _circleModel:Circle2;
		private var _circleView:CircleView;
		
		private var _circleModel2:Circle2;
		private var _circleView2:CircleView;
		
		private var _edgeModel:Edge2;
		private var _edgeView:EdgeView;
		
		private var _pointModel:Point2;
		private var _pointView:PointView;
		
		public function CircleViewExample()
		{
			_circleModel = new Circle2(stage.stageWidth * 0.25, stage.stageHeight * 0.5, 80);
			_circleView = new CircleView(_circleModel);
			_circleModel2 = new Circle2(stage.stageWidth * 0.75, stage.stageHeight * 0.5, 70);
			_circleView2 = new CircleView(_circleModel2);
			_edgeModel = Geometry2.createEdge(stage.stageWidth * 0.5, 0, stage.stageWidth * 0.5, stage.stageHeight);
			_edgeView = new EdgeView(_edgeModel);
			_pointModel = new Point2;
			_pointView = new PointView(_pointModel);
			
			addChild(_circleView);
			addChild(_circleView2);
			addChild(_edgeView);
			addChild(_pointView);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_circleView2.addEventListener(MouseEvent.MOUSE_DOWN, view_onMouseDown);
			_circleView2.addEventListener(MouseEvent.MOUSE_UP, view_onMouseUp);
			
			//trace(JSON.parse(_pointModel.toJSON()));
			//trace(JSON.stringify(_pointModel));
			//trace(_pointModel.toJSON());
			//trace(JSON.stringify(_circleModel));
		}
		
		private function view_onMouseUp(event:MouseEvent):void 
		{
			event.target.stopDrag();
		}
		
		private function view_onMouseDown(event:Event):void 
		{
			event.target.startDrag();
		}
		
		private function onEnterFrame(event:Event):void 
		{
			_circleModel2.x = _circleView2.x;
			_circleModel2.y = _circleView2.y;
			_circleView.alpha = _circleView2.alpha = _circleModel.intersects(_circleModel2) ? 0.5: 1;
			
			//_circleModel.rotateAboutEquals(stage.stageWidth * 0.5, stage.stageHeight * 0.5, 1);
			
			//_edgeModel.rotateAbout(stage.stageWidth * 0.5, 0, -2);
			//_edgeModel.rotate(-1);
			//_pointModel = _pointView.model = Geometry.circleLineIntersection(_circleModel.x, _circleModel.y, _circleModel.radius, _edgeModel.start.x, _edgeModel.start.y, _edgeModel.end.x, _edgeModel.end.y);
			//
			//if (_pointModel)
			//{
				//_circleModel.x = _pointModel.x;
				//_circleModel.y = _pointModel.y;
			//}
//
			//_circleView.alpha = _pointModel ? 0.5 : 1;
			//
			
			_circleView.render();
			_circleView2.render();
			_edgeView.render();
			_pointView.render();
		}
		
		
	}

}