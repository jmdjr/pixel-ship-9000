package src.Game_Frame.Customize_Frame
{
	import flash.display.MovieClip;
	
	public class playAgainButton extends MovieClip
	{
		public function playAgainButton()
		{
			super();
			x = 0;
			y = 0;
		}
		
		public function SetPositionIf( DidShipDie:Boolean ):void
		{
			if( DidShipDie )
			{
				x = 158.10;
				y = 225.85;
			}
			else
			{
				x = 158.10;
				y = 225.85;
			}
		}
	}
}