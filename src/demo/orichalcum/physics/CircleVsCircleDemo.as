package orichalcum.physics 
{
	import flash.display.Sprite;
	import orichalcum.physics.body.geometry.AABB;
	import orichalcum.physics.body.geometry.Circle;
	import orichalcum.physics.body.geometry.Point;
	import orichalcum.physics.body.geometry.ui.AABBView;
	import orichalcum.physics.body.geometry.ui.CircleView;
	import orichalcum.physics.body.geometry.ui.PointView;
	import orichalcum.physics.body.material.Material;
	import orichalcum.physics.force.GravitationalRotationForce;

	public class CircleVsCircleDemo extends Sprite
	{
		
		private var _context:IPhysicsContext;
		
		public function CircleVsCircleDemo() 
		{
			const slow:Number = stage.stageWidth * 0.02;
			const fast:Number = stage.stageWidth * 0.035;
			
			const circleA:Circle = new Circle(stage.stageWidth * 0.1, stage.stageHeight * 0.48, stage.stageWidth * 0.05);
			const circleBodyA:IBody = new VerletBody(circleA, Material.METAL);
			const circleViewA:CircleView = new CircleView(circleBodyA, 0xabcdef, 0x333333, 1);
			circleBodyA.linearVelocityX = fast;
			
			const circleB:Circle = new Circle(stage.stageWidth * 0.9, stage.stageHeight * 0.5, stage.stageWidth * 0.05);
			const circleBodyB:IBody = new VerletBody(circleB, Material.BOUNCY_BALL);
			const circleViewB:CircleView = new CircleView(circleBodyB, 0xabcdef, 0x333333, 1);
			circleBodyB.linearVelocityX = -slow;
			
			addChild(circleViewA);
			addChild(circleViewB);
			
			_context = new PhysicsContext();
			_context.bodies.push(circleViewA);
			_context.bodies.push(circleViewB);
			
			
			
		}
		
	}

}