package orichalcum.physics 
{
	import flash.display.Sprite;
	import orichalcum.physics.body.geometry.AABB;
	import orichalcum.physics.body.geometry.Point;
	import orichalcum.physics.body.geometry.ui.AABBView;
	import orichalcum.physics.body.geometry.ui.PointView;
	import orichalcum.physics.force.GravitationalRotationForce;

	public class PhysicsDemo extends Sprite
	{
		
		private var _context:IPhysicsContext;
		
		public function PhysicsDemo() 
		{
			
			const rectangleGeometry:AABB = new AABB(0, 0, 200, 50);
			const rectangleBody:IBody = new VerletBody(rectangleGeometry);
			const rectangleView:AABBView = new AABBView(rectangleBody);
			
			const gravityCenter:Point = new Point(stage.stageWidth * 0.5, stage.stageHeight * 0.5)
			const gravityCenterBody:IBody = new VerletBody(gravityCenter);
			const gravityCenterView:PointView = new PointView(gravityCenterBody);
			
			trace(rectangleBody as IBody, gravityCenterBody as IBody)
			
			
			_context = new PhysicsContext();
			_context.bodies.push(rectangleView);
			
			rectangleBody.forces.push(new GravitationalRotationForce(gravityCenter));
			rectangleBody.x = stage.stageWidth * 0.5;
			rectangleBody.y = stage.stageHeight * 0.25;
			rectangleBody.rest();
			rectangleBody.linearVelocityX = -2;
			//rectangleBody.linearVelocityY = 4;
			//rectangle.angularVelocity = -0.1
			
			graphics.beginFill(0);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			addChild(gravityCenterView);
			addChild(rectangleView);
			
			
		}
		
	}

}