package src.Game_Frame
{
	import flash.display.MovieClip;

	public class Clip_HPMeter extends MovieClip
	{
		private var healthBG:Asset_HPMeter_BG;
		private var health:Asset_HPMeter_FG;
		private var barLength:Number;
		
		public function Clip_HPMeter()
		{
			
			healthBG = Asset_HPMeter_BG( addChild( new Asset_HPMeter_BG() ) );
			health = Asset_HPMeter_FG( addChild( new Asset_HPMeter_FG() ) );
			
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