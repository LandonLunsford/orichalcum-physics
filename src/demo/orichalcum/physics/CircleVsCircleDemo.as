package orichalcum.physics 
{
	import flash.display.Sprite;
	import orichalcum.physics.body.IBody;
	import orichalcum.physics.body.Body;
	import orichalcum.physics.context.PhysicsContext;
	import orichalcum.physics.geometry.Circle;
	import orichalcum.physics.geometry.view.CircleView;
	import orichalcum.physics.material.Material;
	import orichalcum.physics.context.IPhysicsContext;
	import orichalcum.physics.force.RadialRotationForce;

	public class CircleVsCircleDemo extends Sprite
	{
		
		private var _context:IPhysicsContext;
		
		public function CircleVsCircleDemo() 
		{
			const slow:Number = stage.stageWidth * 0.02;
			const fast:Number = stage.stageWidth * 0.035;
			
			const circleA:Circle = new Circle(stage.stageWidth * 0.1, stage.stageHeight * 0.48, stage.stageWidth * 0.05);
			const circleBodyA:IBody = new Body(circleA, Material.METAL);
			const circleViewA:CircleView = new CircleView(circleBodyA, 0xabcdef, 0x333333, 1);
			circleBodyA.linearVelocityX = fast;
			
			const circleB:Circle = new Circle(stage.stageWidth * 0.9, stage.stageHeight * 0.5, stage.stageWidth * 0.05);
			const circleBodyB:IBody = new Body(circleB, Material.BOUNCY_BALL);
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