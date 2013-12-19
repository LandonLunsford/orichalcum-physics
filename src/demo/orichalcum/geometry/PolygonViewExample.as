package orichalcum.geometry 
{
	import orichalcum.geometry.Polygon2;
	import orichalcum.geometry.Point2;
	import orichalcum.geometry.ui.PointView;
	import orichalcum.geometry.ui.PolygonView;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class PolygonViewExample extends Sprite
	{
		private var _model1:Polygon2;
		private var _model2:Polygon2;
		private var _model3:Polygon2;
		private var _view1:PolygonView;
		private var _view2:PolygonView;
		private var _view3:PolygonView;
		
		public function PolygonViewExample()
		{
			_model1 = Geometry2.createPolygonFromCoordinates(
				0, 0,
				0, 100,
				50, 150,
				100, 100,
				125, 50
			);
			_model1.x += 50;
			_model1.y += 50;
			_view1 = new PolygonView(_model1);
			addChild(_view1);
			
			_model2 = Geometry2.createRegularPolygon(120, 10, 0);
			_model2.x = stage.stageWidth * 0.5;
			_model2.y = stage.stageHeight * 0.5;
			_model2.rotateEquals(15);
			_view2 = new PolygonView(_model2);
			addChild(_view2);
			
			_model3 = Geometry2.createPolygonRectangle(500, 400, 100, 150);
			_model3.rotateEquals(50);
			_view3 = new PolygonView(_model3);
			addChild(_view3);
		
			addChild(new PointView(_model1.center));
			addChild(new PointView(_model2.center));
			addChild(new PointView(_model3.center));
			
			//trace(JSON.stringify(model2));
			//trace(JSON.stringify(new Point));
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_view1.addEventListener(MouseEvent.MOUSE_DOWN, view_onMouseDown);
			_view2.addEventListener(MouseEvent.MOUSE_DOWN, view_onMouseDown);
			_view3.addEventListener(MouseEvent.MOUSE_DOWN, view_onMouseDown);
			_view1.addEventListener(MouseEvent.MOUSE_UP, view_onMouseup);
			_view2.addEventListener(MouseEvent.MOUSE_UP, view_onMouseup);
			_view3.addEventListener(MouseEvent.MOUSE_UP, view_onMouseup);
		}
		
		private function onEnterFrame(event:Event):void 
		{
			_model1.x = _view1.x;
			_model2.x = _view2.x;
			_model3.x = _view3.x;
			_model1.y = _view1.y;
			_model2.y = _view2.y;
			_model3.y = _view3.y;
			_view1.alpha = _model1.intersects(_model2) || _model1.intersects(_model3) ? 0.5 : 1.0;
			_view2.alpha = _model2.intersects(_model1) || _model2.intersects(_model3) ? 0.5 : 1.0;
			_view3.alpha = _model3.intersects(_model1) || _model3.intersects(_model2) ? 0.5 : 1.0;
		}
		
		private function view_onMouseDown(event:MouseEvent):void 
		{
			event.target.startDrag();
		}
		
		private function view_onMouseup(event:MouseEvent):void 
		{
			event.target.stopDrag();
		}
		
	}

}