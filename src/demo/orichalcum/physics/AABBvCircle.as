package orichalcum.physics 
{
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

	public class AABBvCircle extends Sprite
	{
		
		private var _context:IPhysicsContext;
		private var _player:ICollidable;
		private var _playerSpeed:Number = 24;
		private var _playerMouseX:Number;
		private var _playerMouseY:Number;
		private var _gravity:IForce = new PlanarGravitaionalForce(new Point(0, 1));
		
		public function AABBvCircle() 
		{
			const aabbA:AABB = new AABB(stage.stageWidth * 0.2, stage.stageHeight * 0.8, stage.stageWidth * 0.6, stage.stageWidth * 0.5);
			const aabbBodyA:IBody = new Body(aabbA, Material.WOOD);
			const aabbViewA:AABBView = new AABBView(aabbBodyA, 0xabcdef, 0x333333, 1);
			aabbBodyA.type = BodyType.STATIC;
			
			const circleA:Circle = new Circle(stage.stageWidth * 0.5, stage.stageHeight * 0.2, stage.stageWidth * 0.05);
			const circleBodyA:IBody = new Body(circleA, Material.BOUNCY_BALL);
			const circleViewA:CircleView = new CircleView(circleBodyA, 0xabcdef, 0x333333, 1);
			
			addChild(aabbViewA);
			addChild(circleViewA);
			
			
			
			
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, stage_onKeyUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
			
			
			_context = new PhysicsContext();
			_context.bodies.push(aabbViewA);
			_context.bodies.push(circleViewA);
			
			_player = circleViewA;
			//_player.body.forces.push(_gravity);
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