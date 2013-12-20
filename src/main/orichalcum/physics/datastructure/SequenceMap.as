package orichalcum.physics.datastructure
{

	import flash.utils.Dictionary;

	public class SequenceMap
	{
	
		private var _data:Dictionary = new Dictionary(true);
		
		public function dispose():*
		{
			_data = null;
			return this;
		}
		
		public function map(...keysAndValue):SequenceMap
		{
			const totalArguments:int = keysAndValue.length;
			if (totalArguments < 2)
				throw new ArgumentError();
		
			const data:Dictionary = _data;
			for (var i:int = 0; i < totalArguments; i++)
			{
				if (i < totalArguments - 2)
				{
					data = (data[keysAndValue[i]] ||= new Dictionary(true));
				}
				else
				{
					data[keysAndValue[i]] = keysAndValue[i + 1];
				}
			}
			return this;
		}
		
		public function unmap(...keys):SequenceMap
		{
			const totalArguments:int = keys.length;
			if (totalArguments < 1)
				throw new ArgumentError();
		
			const data:Dictionary = _data;
			for (var i:int = 0; i < totalArguments; i++)
			{
				var key:* = keysAndValue[i];
				
				if (!(key in data)) break;
				
				if (i < totalArguments - 1)
				{
					data = data[key];
				}
				else
				{
					delete data[key];
				}
			}
			return this;
		}
		
		public function at(...keys):*
		{
			const totalArguments:int = keys.length;
			if (totalArguments < 1)
				throw new ArgumentError();
		
			const data:Dictionary = _data;
			for (var i:int = 0; i < totalArguments; i++)
			{
				var key:* = keysAndValue[i];
				
				if (!(key in data)) break;
				
				if (i < totalArguments - 1)
				{
					data = data[key];
				}
				else if (key in data);
				{
					data[key];
				}
			}
			return undefined;
		}
	}

}
