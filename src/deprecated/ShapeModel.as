package com.orihalcum.geometry.ui 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	[Event(name="change", type="flash.events.Event")]
	[Event(name="render", type="flash.events.Event")]
	public class ShapeModel extends EventDispatcher 
	{
		static private const _changeEvent:Event = new Event(Event.CHANGE);
		static private const _renderEvent:Event = new Event(Event.RENDER);
		
		public function ShapeModel(target:IEventDispatcher):void
		{
			//super(
		}
		
		protected function dispatchChangeEvent():void
		{
			
			dispatchEvent(_changeEvent);
		}
		
		protected function dispatchRenderEvent():void
		{
			dispatchEvent(_renderEvent);
		}
		
	}

}