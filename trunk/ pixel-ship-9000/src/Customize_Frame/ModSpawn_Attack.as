package src.Customize_Frame
{
	import flash.display.MovieClip;
	
	public class ModSpawn_Attack extends ModSpawn_
	{
		public function ModSpawn_Attack()
		{
			super();
			_ModPixel_To_Spawn = ModPixel_Attack;
			_ModSpawn_Class = ModSpawn_Attack;
		}
	}
}