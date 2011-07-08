package src.Customize_Frame
{
	import flash.display.MovieClip;
	
	public class ModSpawn_ extends MovieClip
	{
		var _ModPixel_To_Spawn:Class;
		public function ModSpawn_()
		{
			super();
			_ModPixel_To_Spawn = null;
		}
		
		public function SpawnModPixel():ModPixel_
		{
			return new _ModPixel_To_Spawn();
		}
	}
}