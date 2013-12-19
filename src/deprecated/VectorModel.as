package com.orihalcum.geometry.ui 
{
	import com.orihalcum.geometry.Vector2;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class VectorModel extends Vector2 implements IEventDispatcher
	{
		static private const _changeEvent:Event;
		static private const _renderEvent:Event;
		private var _delegate:EventDispatcher;
		
		public function VectorModel(x:Number = 0, y:Number = 0)
		{
			super(x, y);
		}
		
		override public function set x(value:Number):void 
		{
			if (super.x == value) return;
			super.x = value;
			dispatchChangeEvent();
		}

		override public function set y(value:Number):void 
		{
			if (super.y == value) return;
			super.y = value;
			dispatchChangeEvent();
		}
		
		private function dispatchChangeEvent():void
		{
			dispatchEvent(_changeEvent ||= new Event(Event.CHANGE));
		}
		
		private function dispatchRenderEvent():void
		{
			dispatchEvent(_renderEvent ||= new Event(Event.RENDER));
		}
		
		/* INTERFACE flash.events.IEventDispatcher */
		
		private function get delegate():IEventDispatcher
		{
			return _delegate ||= new EventDispatcher(this);
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			delegate.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			delegate.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean 
		{
			return delegate.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean 
		{
			return delegate.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean 
		{
			return delegate.willTrigger(type);
		}
	}

}