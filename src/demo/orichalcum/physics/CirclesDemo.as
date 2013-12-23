package orichalcum.physics 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import orichalcum.physics.body.IBody;
	import orichalcum.physics.body.Body;
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.context.IPhysicsContext;
	import orichalcum.physics.context.PhysicsContext;
	import orichalcum.physics.geometry.Circle;
	import orichalcum.physics.geometry.view.CircleView;
	import orichalcum.physics.material.Material;

	public class CirclesDemo extends Sprite
	{
		
		private var _context:IPhysicsContext;
		
		public function CirclesDemo() 
		{
			
			_context = new PhysicsContext();
			
			for (var i:int = 0; i < 20; i++)
			{
				var circle:Circle = new Circle(
					stage.stageWidth * Math.random(),
					stage.stageHeight * Math.random(),
					stage.stageWidth * 0.02 + stage.stageWidth * 0.02 * Math.random()
				);
				var circleBody:IBody = new Body(circle, Material.ROCK);
				var circleView:CircleView = new CircleView(circleBody, 0xabcdef, 0x333333, 1);
				
				addChild(circleView);
				
				_context.bodies.push(circleView);
			}
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
			//stage.addEventListener(MouseEvent.CLICK, onRightClick);
			
		}
		
		private function onClick(event:MouseEvent):void 
		{
			const slow:Number = stage.stageWidth * 0.02;
			const fast:Number = stage.stageWidth * 0.035;
			const speed:Number = slow;
			
			for each(var collidable:ICollidable in _context.bodies)
			{
				collidable.body.linearVelocityX = -speed + speed * 2 * Math.random();
				collidable.body.linearVelocityY = -speed + speed * 2 * Math.random();
				collidable.body.angularVelocity = -speed + speed * 2 * Math.random();
			}
		}
		
		private function onRightClick(event:MouseEvent):void 
		{
			
			const slow:Number = stage.stageWidth * 0.02;
			const fast:Number = stage.stageWidth * 0.035;
			const speed:Number = slow;
			
			for each(var collidable:ICollidable in _context.bodies)
			{
				const dx:Number = stage.mouseX - collidable.body.x;
				const dy:Number = stage.mouseY - collidable.body.y;
				const d:Number = Math.sqrt(dx * dx + dy * dy);
				
				const vx:Number = (dx / d) * speed;
				const vy:Number = (dy / d) * speed;
				
				collidable.body.linearVelocityX = vx;
				collidable.body.linearVelocityY = vy;
			}
		}
		
	}

}