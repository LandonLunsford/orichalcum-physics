package orichalcum.physics.datastructure 
{
	import flash.utils.Dictionary;

	public class CombinationMap 
	{
		
		private var _data:Dictionary;
		
		public function CombinationMap() 
		{
			_data = new Dictionary(true);
		}
		
		public function dispose():void
		{
			_data = null;
		}
		
		public function map(a:*, b:*, value:*):CombinationMap
		{
			(_data[a] ||= new Dictionary(true))[b] = value;
			(_data[b] ||= new Dictionary(true))[a] = value;
			return this;
		}
		
		public function at(a:*, b:*):*
		{
			/*
				The issue here is the client needs to know
				if the keys were flipped.
				
				The only way I can think to do that is return a wrapper (OOP)
				Or set a flag locally indicating the last get was flipped (not OOP)
			*/
			if (a in _data && b in _data[a]) return _data[a][b];
			if (b in _data && a in _data[b]) return _data[b][a];
			return undefined;
		}
		
		public function unmap(a:*, b:*):CombinationMap
		{
			if (a in _data && b in _data[a]) delete _data[a][b];
			if (b in _data && a in _data[b]) delete _data[b][a];
			return this;
		}
		
	}

}
