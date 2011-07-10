package src.Credits_Frame
{
	import flash.display.MovieClip;
	
	import src.GameDataTracker;
	import src.Ship;
	
	public class _Frame_Credits extends MovieClip
	{
		private var ship:Ship;
		private var gameData:GameDataTracker;
		
		public function _Frame_Credits()
		{
			super();
		}
		
		public function LoadShipReference( sr:Ship ):void
		{
			ship = sr;
		}
		
		/**
		 * LoadGameData( data )
		 *   loads the base game data that is used between frames
		 * Parameters:
		 *   data - the basic game data reference
		 * 
		 *  @author John M Davis Jr.
		 */
		public function LoadGameData( data:GameDataTracker )
		{
			gameData = data;
		}
	}
}