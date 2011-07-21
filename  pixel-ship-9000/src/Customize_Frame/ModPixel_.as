package src.Customize_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
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
		
		public var positionX:Number;     //Position in the Mod Grid
		public var positionY:Number;
		protected var _CurrentClass:Class;
		protected var _SpawnerClass:Class;
		public function ModPixel_()
		{
			positionX = 0;
			positionY = 0;
			_CurrentClass = ModPixel_;
			_SpawnerClass = null;
		}
		
		public function Update( tick:Event ):void
		{
			
		}
		
		public function Spawn( _bound:Rectangle = null ):ModPixel_
		{
			return new _CurrentClass();
		}
		
		public function SpawnSpawners():ModSpawn_
		{
			return new _SpawnerClass();
		}
	}
}