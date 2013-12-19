package orihalcum.geometry 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * @author Landon Lunsford
	 */

	public class DispatcherTest extends Sprite
	{
		
		public function DispatcherTest() 
		{
			const dispatcher:Dispatcher = new Dispatcher;
			dispatcher.addEventListener('poop', function(event:Event):void { trace(event.type); } );
			dispatcher.dispatchEvent(new Event('poop'));
		}
		
	}

}

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

internal class Dispatcher implements IEventDispatcher
{
	private var _delegate:EventDispatcher;
	
	public function Dispatcher()
	{
		_delegate = new EventDispatcher(this);
	}
	
	/* INTERFACE flash.events.IEventDispatcher */
	
	public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
	{
		_delegate.addEventListener(type, listener, useCapture, priority, useWeakReference);
	}
	
	public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
	{
		_delegate.removeEventListener(type, listener, useCapture);
	}
	
	public function dispatchEvent(event:Event):Boolean 
	{
		return _delegate.dispatchEvent(event);
	}
	
	public function hasEventListener(type:String):Boolean 
	{
		return _delegate.hasEventListener(type);
	}
	
	public function willTrigger(type:String):Boolean 
	{
		return _delegate.willTrigger(type);
	}
}