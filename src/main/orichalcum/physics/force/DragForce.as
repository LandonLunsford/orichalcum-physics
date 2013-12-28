package orichalcum.physics.force 
{
	import flash.display.Stage;
	import orichalcum.physics.body.IBody;
	
	/**
	 * Not smooth because += velocity in body
	 */
	public class DragForce implements IForce
	{
		private var stage:Stage;
		private var localX:Number;
		private var localY:Number;
		
		private var _previousMouseX:Number = 0;
		private var _previousMouseY:Number = 0;
		
		public function DragForce(stage:Stage, localX:Number, localY:Number) 
		{
			this.localY = localY;
			this.localX = localX;
			this.stage = stage;
			
			//_previousMouseX = stage.mouseX;
			//_previousMouseY = stage.mouseY;
		}
		
		public function apply(body:IBody):void 
		{
			//const temporaryX:Number = stage.mouseX;
			//const temporaryY:Number = stage.mouseY;
			//body.x += temporaryX - _previousMouseX;
			//body.y += temporaryY - _previousMouseY;
			//_previousMouseX = temporaryX;
			//_previousMouseY = temporaryY;
			body.x = stage.mouseX - localX;
			body.y = stage.mouseY - localY;
			trace('drag application')
		}
		
	}

}