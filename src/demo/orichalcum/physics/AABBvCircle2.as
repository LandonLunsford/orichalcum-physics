package orichalcum.physics 
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import orichalcum.physics.body.Body;
	import orichalcum.physics.body.BodyType;
	import orichalcum.physics.body.IBody;
	import orichalcum.physics.collision.ICollidable;
	import orichalcum.physics.context.IPhysicsContext;
	import orichalcum.physics.context.PhysicsContext;
	import orichalcum.physics.force.DragForce;
	import orichalcum.physics.force.IForce;
	import orichalcum.physics.force.PlanarGravitaionalForce;
	import orichalcum.physics.geometry.AABB;
	import orichalcum.physics.geometry.Circle;
	import orichalcum.physics.geometry.Point;
	import orichalcum.physics.geometry.view.AABBView;
	import orichalcum.physics.geometry.view.CircleView;
	import orichalcum.physics.material.Material;

	public class AABBvCircle2 extends Sprite
	{
		
		private var _context:IPhysicsContext;
		private var _player:ICollidable;
		private var _playerSpeed:Number = 24;
		private var _playerMouseX:Number;
		private var _playerMouseY:Number;
		private var _gravity:IForce = new PlanarGravitaionalForce(new Point(0, 1));
		
		public function AABBvCircle2() 
		{
			const aabb_A:AABB = new AABB(0, 0, stage.stageWidth * 0.2, stage.stageHeight * 0.8);
			const aabbBody_A:IBody = new Body(aabb_A, Material.WOOD);
			const aabbView_A:AABBView = new AABBView(aabbBody_A, 0xabcdef, 0x333333, 1);
			aabbBody_A.type = BodyType.STATIC;
			
			const aabb_B:AABB = new AABB(0, stage.stageHeight * 0.8, stage.stageWidth, stage.stageHeight * 0.2);
			const aabbBody_B:IBody = new Body(aabb_B, Material.WOOD);
			const aabbView_B:AABBView = new AABBView(aabbBody_B, 0xabcdef, 0x333333, 1);
			aabbBody_B.type = BodyType.STATIC;
			
			const aabb_C:AABB = new AABB(stage.stageWidth * 0.8, 0, stage.stageWidth * 0.2, stage.stageHeight * 0.8);
			const aabbBody_C:IBody = new Body(aabb_C, Material.WOOD);
			const aabbView_C:AABBView = new AABBView(aabbBody_C, 0xabcdef, 0x333333, 1);
			aabbBody_C.type = BodyType.STATIC;
			
			//const circleA:Circle = new Circle(stage.stageWidth * 0.5, stage.stageHeight * 0.2, stage.stageWidth * 0.05);
			//const circleBodyA:IBody = new Body(circleA, Material.BOUNCY_BALL);
			//const circleViewA:CircleView = new CircleView(circleBodyA, 0xabcdef, 0x333333, 1);
			
			
			
			addChild(aabbView_A);
			addChild(aabbView_B);
			addChild(aabbView_C);
			
			
			_context = new PhysicsContext();
			_context.bodies.push(aabbView_A);
			_context.bodies.push(aabbView_B);
			_context.bodies.push(aabbView_C);
			
			for (var i:int = 0; i < 10; i++)
			{
				var circleGeometry:Circle = new Circle(stage.stageWidth * 0.5, stage.stageHeight * 0.2, stage.stageWidth * 0.05);
				var circleBody:IBody = new Body(circleGeometry, Material.WOOD);
				var circleView:CircleView = new CircleView(circleBody, 0xabcdef, 0x333333, 1);
				
				addChild(circleView);
				_context.bodies.push(circleView);
				circleBody.forces.push(_gravity);
			}
			
			
			
			//_player = circleViewA;
			//_player.body.forces.push(_gravity);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, stage_onKeyUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
		}
		
		private function stage_onMouseDown(event:MouseEvent):void 
		{
			if (event.target == stage) return;
			_player = event.target as ICollidable;
			_player.body.type = BodyType.KINEMATIC;
			(_player.body as Body).skipIntegration = true;
			_player.body.forces.length = 0;
			_player.body.forces.push(new DragForce(stage, event.localX, event.localY));
			//_playerMouseX = event.localX;
			//_playerMouseY = event.localY;
			stage.addEventListener(Event.ENTER_FRAME, stage_onEnterFrame);
		}
		
		private function stage_onMouseUp(event:MouseEvent):void 
		{
			if (!_player) return;
			_player.body.type = BodyType.DYNAMIC;
			(_player.body as Body).skipIntegration = false;
			_player.body.forces.length = 0;
			_player.body.forces.push(_gravity);
			stage.removeEventListener(Event.ENTER_FRAME, stage_onEnterFrame);
		}
		
		private function stage_onEnterFrame(event:Event):void
		{
			//_player.body.x = stage.mouseX - _playerMouseX;
			//_player.body.y = stage.mouseY - _playerMouseY;
			//trace('post vx', _player.body.linearVelocityX);
		}
		
		private function stage_onKeyDown(event:KeyboardEvent):void 
		{
			const playerBody:IBody = _player.body;
			if (event.keyCode == Keyboard.UP)
			{
				playerBody.linearVelocityY = -_playerSpeed;
			}
			else if (event.keyCode == Keyboard.DOWN)
			{
				playerBody.linearVelocityY = _playerSpeed;
			}
			if (event.keyCode == Keyboard.LEFT)
			{
				playerBody.linearVelocityX = -_playerSpeed;
			}
			else if (event.keyCode == Keyboard.RIGHT)
			{
				playerBody.linearVelocityX = _playerSpeed;
			}
		}
		
		private function stage_onKeyUp(event:KeyboardEvent):void 
		{
			const playerBody:IBody = _player.body;
			if (event.keyCode == Keyboard.UP)
			{
				playerBody.linearVelocityY = 0;
			}
			else if (event.keyCode == Keyboard.DOWN)
			{
				playerBody.linearVelocityY = 0;
			}
			if (event.keyCode == Keyboard.LEFT)
			{
				playerBody.linearVelocityX = 0;
			}
			else if (event.keyCode == Keyboard.RIGHT)
			{
				playerBody.linearVelocityX = 0;
			}
		}
		
	}

}