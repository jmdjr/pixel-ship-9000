package src.Game_Frame
{
	import flash.events.Event;

	public class EBombSplosion extends EnemyProjectile
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
		public function EBombSplosion()
		{
			super();
			_CurrentClass = EBombSplosion;
			
			GrowToScale = 1;
			SpinBy = 30;
			TimeLast = 2;
			Timer = 0;
			Interval = 1;
			DimBy = 0.01;
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
			else if( ( Timer <= (TimeLast * stage.frameRate) ) && (Timer % Interval * stage.frameRate) == 0 )
			{
				scaleX += GrowDiff;
				scaleY += GrowDiff;
				
				rotation += SpinBy;
				alpha -= DimBy;
			}
		}
	}
}