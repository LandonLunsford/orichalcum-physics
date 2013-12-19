package orichalcum.physics.ui 
{
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import orichalcum.geometry.Circle2;
	import orichalcum.geometry.Edge2;
	import orichalcum.geometry.Point2;
	import orichalcum.geometry.Polygon2;
	import orichalcum.geometry.Rectangle2;
	import orichalcum.geometry.ui.CircleView;
	import orichalcum.geometry.ui.PointView;
	import orichalcum.geometry.ui.PolygonView;
	import orichalcum.geometry.ui.RectangleView;
	import orichalcum.physics.IBody;
	import orichalcum.physics.ICollidable;

	public class GeometricBodyView extends Sprite implements ICollidable
	{
		
		static private const _viewByGeometry:Dictionary = new Dictionary(true);
		{
			_viewByGeometry[Circle2] = CircleView;
			_viewByGeometry[Point2] = PointView;
			_viewByGeometry[Edge2] = Edge2;
			_viewByGeometry[Polygon2] = PolygonView;
			_viewByGeometry[Rectangle2] = RectangleView;
		}
		
		
		public function GeometricBodyView(body:IBody) 
		{
			addChild(
				new (_viewByGeometry[ApplicationDomain.currentDomain.getDefinition(getQualifiedClassName(body.geometry))])(body.geometry)
			);
		}
		
	}

}