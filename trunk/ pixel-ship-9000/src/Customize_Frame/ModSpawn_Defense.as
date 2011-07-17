package src.Customize_Frame
{
	import flash.display.MovieClip;
	
	public class ModSpawn_Defense extends ModSpawn_
	{
		public function ModSpawn_Defense()
		{
			super();
			_ModPixel_To_Spawn = ModPixel_Defense;
			_ModSpawn_Class = ModSpawn_Defense;
		}
	}
}