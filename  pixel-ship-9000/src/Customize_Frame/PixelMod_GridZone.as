package src.Customize_Frame
{
	import flash.display.MovieClip;
	
	public class PixelMod_GridZone extends MovieClip
	{
		var ModSpawnerRef:ModSpawn_;
		
		public function PixelMod_GridZone()
		{
			super();
			ModSpawnerRef = null;
		}
		
		public function UpdateModSpawnerRef( ref:ModSpawn_ ):void
		{
			if( ModSpawnerRef != null )
			{
				ModSpawnerRef.visible = false;
				ModSpawnerRef.enabled = false;
				ModSpawnerRef = null;
			}
			
			ModSpawnerRef = ref;
		}
		
		public function InvokeModSpawner( ):ModPixel_
		{
			if( ModSpawnerRef == null )
			{
				return null;
			}
			
			return ModSpawnerRef.Spawn_ModPixel();
		}
	}
}