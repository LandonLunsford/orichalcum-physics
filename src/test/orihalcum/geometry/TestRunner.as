package orihalcum.geometry
{
	import flash.display.Sprite;
	import org.flexunit.internals.TraceListener;
	import org.flexunit.runner.FlexUnitCore;

	public class TestRunner extends Sprite
	{
		private var _tests:Array = [
			Vector2Test
		];
		
		public function TestRunner()
		{
			const flexunit:FlexUnitCore = new FlexUnitCore;
			flexunit.addListener(new TraceListener);
			flexunit.run.apply(null, _tests);
		}
	}

}