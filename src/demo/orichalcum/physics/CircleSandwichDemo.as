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
	import orichalcum.physics.force.GravitationalRotationForce;

	public class CircleSandwichDemo extends Sprite
	{
		
		private var _context:IPhysicsContext;
		
		public function CircleSandwichDemo() 
		{
			const radius:Number = stage.stageWidth * 0.05;
			const slow:Number = stage.stageWidth * 0.02;
			const fast:Number = stage.stageWidth * 0.035;
			
			const circleA:Circle = new Circle(stage.stageWidth * 0.9, stage.stageHeight * 0.5, radius);
			const circleBodyA:IBody = new Body(circleA, Material.METAL);
			const circleViewA:CircleView = new CircleView(circleBodyA, 0xabcdef, 0x333333, 1);
			circleBodyA.linearVelocityX = -slow;
			
			const circleB:Circle = new Circle(stage.stageWidth * 0.1, stage.stageHeight * 0.5, radius);
			const circleBodyB:IBody = new Body(circleB, Material.BOUNCY_BALL);
			const circleViewB:CircleView = new CircleView(circleBodyB, 0xabcdef, 0x333333, 1);
			circleBodyB.linearVelocityX = slow;
			
			const circleC:Circle = new Circle(stage.stageWidth * 0.5, stage.stageHeight * 0.5, radius);
			const circleBodyC:IBody = new Body(circleC, Material.BOUNCY_BALL);
			const circleViewC:CircleView = new CircleView(circleBodyC, 0xabcdef, 0x333333, 1);
			
			addChild(circleViewA);
			addChild(circleViewB);
			addChild(circleViewC);
			
			_context = new PhysicsContext();
			_context.bodies.push(circleViewA);
			_context.bodies.push(circleViewB);
			_context.bodies.push(circleViewC);
			
			
			
		}
		
	}

}