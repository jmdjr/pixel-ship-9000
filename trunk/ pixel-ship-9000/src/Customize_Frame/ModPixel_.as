package src.Customize_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * ModPixel represents the pixel that is displayed with the ship, as well as 
	 * in the customize ship frame.  the ship has a ModGrid that reports the 
	 * Position and modification stat that the ModPixel provides.
	 * 
	 * 
	 */ 
	public class ModPixel_ extends MovieClip
	{
		/**
		 * ModPixel Class
		 *   Base Class for the Modifying Pixels that add to a ship.
		 */
		
		public var position:Number;     //Position in the Mod Grid
		//private var modAmount:Number;    // Generic amount used to modify an attribute. 
		
		public function ModPixel_()
		{
			position = 0;
			//modAmount = 0;
		}
		
		public function Update( tick:Event ):void
		{
			
		}
	}
}