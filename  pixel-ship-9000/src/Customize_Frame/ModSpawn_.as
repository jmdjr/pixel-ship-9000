package src.Customize_Frame
{
	import flash.display.MovieClip;
	
	public class ModSpawn_ extends MovieClip
	{
		protected var _ModPixel_To_Spawn:Class;
		protected var _ModSpawn_Class:Class;
		
		public function ModSpawn_()
		{
			super();
			_ModPixel_To_Spawn = null;
			_ModSpawn_Class = ModSpawn_;
		}
		
		public function Spawn_ModPixel():ModPixel_
		{
			return new _ModPixel_To_Spawn();
		}
		
		public function Spawn_ModSpawn():ModSpawn_
		{
			return new _ModSpawn_Class();
		}
	}
}