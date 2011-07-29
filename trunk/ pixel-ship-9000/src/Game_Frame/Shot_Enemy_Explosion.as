package src.Game_Frame
{
	import flash.events.Event;

	public class Shot_Enemy_Explosion extends Shot_Enemy_
	{
		private var GrowToScale:Number;
		private var GrowDiff:Number;
		private var SpinBy:Number;
		private var DimBy:Number;
		private var TimeLast:Number;  // in seconds
		private var Timer:Number;     // counter for delay
		private var Interval:Number;  // the number of frames for each change
		
		
		/**
		 * 
		 * 
		 */
		public function Shot_Enemy_Explosion()
		{
			super();
			_CurrentClass = Shot_Enemy_Explosion;
			Damage = 2;
			TimeLast = 1;
			Timer = 0;
			
			GrowDiff = GrowToScale/TimeLast;
		}
		
		public override function Update( tick:Event ):void
		{
			super.Update( tick );
			
			++Timer;
			
			if( stage == null || Timer > TimeLast * stage.frameRate  )
			{
				Disappear();
				return;
			}
		}
	}
}