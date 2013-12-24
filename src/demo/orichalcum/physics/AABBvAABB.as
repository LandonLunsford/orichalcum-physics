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
	import orichalcum.physics.context.IPhysicsContext;
	import orichalcum.physics.context.PhysicsContext;
	import orichalcum.physics.force.PlanarGravitaionalForce;
	import orichalcum.physics.geometry.AABB;
	import orichalcum.physics.geometry.Point;
	import orichalcum.physics.geometry.view.AABBView;
	import orichalcum.physics.material.Material;

	public class AABBvAABB extends Sprite
	{
		
		private var _context:IPhysicsContext;
		private var _player:AABBView;
		private var _playerSpeed:Number = 24;
		private var _playerMouseX:Number;
		private var _playerMouseY:Number;
		
		public function AABBvAABB() 
		{
			const aabbA:AABB = new AABB(stage.stageWidth * 0.5, stage.stageHeight * 0.5, stage.stageWidth * 0.1, stage.stageWidth * 0.1);
			const aabbBodyA:IBody = new Body(aabbA, Material.ROCK);
			const aabbViewA:AABBView = new AABBView(aabbBodyA, 0xabcdef, 0x333333, 1);
			aabbBodyA.type = BodyType.STATIC;
			
			const aabbB:AABB = new AABB(stage.stageWidth * 0.1, stage.stageHeight * 0.5, stage.stageWidth * 0.1, stage.stageWidth * 0.1);
			const aabbBodyB:IBody = new Body(aabbB, Material.ROCK);
			const aabbViewB:AABBView = new AABBView(aabbBodyB, 0xabcdef, 0x333333, 1);
			aabbBodyB.linearVelocityX = _playerSpeed;
			
			const aabbC:AABB = new AABB(stage.stageWidth * 0.9, stage.stageHeight * 0.5, stage.stageWidth * 0.1, stage.stageWidth * 0.1);
			const aabbBodyC:IBody = new Body(aabbC, Material.ROCK);
			const aabbViewC:AABBView = new AABBView(aabbBodyC, 0xabcdef, 0x333333, 1);
			aabbBodyC.linearVelocityX = -_playerSpeed;
			
			
			const aabbD:AABB = new AABB(stage.stageWidth * 0.5, -stage.stageHeight * 0, stage.stageWidth * 0.1, stage.stageWidth * 0.1);
			const aabbBodyD:IBody = new Body(aabbD, Material.ROCK);
			const aabbViewD:AABBView = new AABBView(aabbBodyD, 0xabcdef, 0x333333, 1);
			
			addChild(aabbViewA);
			addChild(aabbViewB);
			addChild(aabbViewC);
			addChild(aabbViewD);
			
			_context = new PhysicsContext();
			_context.bodies.push(aabbViewA);
			_context.bodies.push(aabbViewB);
			_context.bodies.push(aabbViewC);
			_context.bodies.push(aabbViewD);
			
			_player = aabbViewB;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, stage_onKeyUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
			
			
			aabbBodyD.forces.push(new PlanarGravitaionalForce(new Point(0, 1)));
		}
		
		private function stage_onMouseDown(event:MouseEvent):void 
		{
			if (event.target == stage) return;
			_player = event.target as AABBView;
			_playerMouseX = event.localX;
			_playerMouseY = event.localY;
			stage.addEventListener(Event.ENTER_FRAME, stage_onEnterFrame);
		}
		
		private function stage_onMouseUp(event:MouseEvent):void 
		{
			if (!_player) return;
			stage.removeEventListener(Event.ENTER_FRAME, stage_onEnterFrame);
		}
		
		private function stage_onEnterFrame(event:Event):void
		{
			_player.body.x = stage.mouseX - _playerMouseX;
			_player.body.y = stage.mouseY - _playerMouseY;
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