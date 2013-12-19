package orichalcum.geometry 
{
	import orichalcum.geometry.Edge2;
	import orichalcum.geometry.ui.EdgeView;
	import orichalcum.geometry.ui.PointView;
	import flash.display.Sprite;

	public class EdgeViewExample extends Sprite
	{
		private var _model1:Edge2;
		private var _model2:Edge2;
		private var _view1:EdgeView;
		private var _view2:EdgeView;
		
		public function EdgeViewExample()
		{
			_model1 = new Edge2(0, 0, 8, 8);
			_view1 = new EdgeView(_model1, 0xabcdef, 2);
			addChild(_view1);
			
			_model2 = new Edge2(80, 50, 80, 160);
			_view2 = new EdgeView(_model2, 0xabcdef, 2);
			addChild(_view2);
			
			trace(_model1.contains(5, 5.00000001));
			addChild(new PointView(_model1.intersection(_model2)));
			
			trace(_model1.intersection(_model2));
			
			trace(_model1.intersection(_model2));
		}
		
	}

}