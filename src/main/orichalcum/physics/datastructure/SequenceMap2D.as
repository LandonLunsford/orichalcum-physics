package orichalcum.physics.datastructure 
{
	import flash.utils.Dictionary;

	public class SequenceMap2D
	{
		private var _data:Dictionary = new Dictionary(true);
		
		public function dispose():*
		{
			_data = null;
			return this;
		}
		
		public function map(a:*, b:*, value:*):SequenceMap2D
		{
			(_data[a] ||= new Dictionary(true))[b] = value;
			return this;
		}
		
		public function unmap(a:*, b:*):SequenceMap2D
		{
			if (a in _data && b in _data[a]) delete _data[a][b];
			return this;
		}
		
		public function at(a:*, b:*):*
		{
			return a in _data && b in _data[a] ? _data[a][b] : undefined;
		}
		
		public function hasKey(a:*, b:*):Boolean
		{
			return a in _data && b in _data[a];
		}
		
		public function hasReverseKey(a:*, b:*):Boolean
		{
			return b in _data && a in _data[b];
		}
		
	}
	
	
}
	
