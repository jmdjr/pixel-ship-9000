package src.Customize_Frame
{
	import flash.display.MovieClip;
	
	import src.Ship;

	/**
	 * Object used to communicate the customizing functionality of the ship 
	 *  and display an interface where the ship can be modified and upgraded.
	 */ 
	public class ModGridCustomizer extends MovieClip
	{
		var ShipReference:Ship;
		
		
		public function ModGridCustomizer()
		{
			
		}
		
		public function LoadShipReference( sr:Ship ):void
		{
			ShipReference = sr;
		}
		
		
	}
}