package src.Game_Frame
{
	import flash.display.MovieClip;

	public class ShipHealthMeterDisplay extends MovieClip
	{
		var healthBG:healthMeterBackground;
		var health:HealthMeterBar;
		var barLength:Number;
		
		public function ShipHealthMeterDisplay()
		{
			
			healthBG = healthMeterBackground( addChild( new healthMeterBackground() ) );
			health = HealthMeterBar( addChild( new HealthMeterBar() ) );
			
			barLength = health.width;
		}
		
		// will display a percentage of the healthMeter bar.
		//  percent amount must be between 0 and 1.0
		public function ShowAPercentage( Percent:Number ):void
		{
			if( Percent >= 0 && Percent <= 1.0 )
			{
				health.width = barLength * Percent;
			}
		}
	}
}