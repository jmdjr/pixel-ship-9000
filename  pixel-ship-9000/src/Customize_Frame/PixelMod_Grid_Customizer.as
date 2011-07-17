package src.Customize_Frame
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import src.Ship;

	/**
	 * Object used to communicate the customizing functionality of the ship 
	 *  and display an interface where the ship can be modified and upgraded.
	 */ 
	public class PixelMod_Grid_Customizer extends MovieClip
	{
		var ShipReference:Ship;
		var zones:Array;
		var ReferenceModSpawner:ModSpawn_;
		
		public function PixelMod_Grid_Customizer()
		{
			zones = new Array( numChildren );
			for( var i = 0; i < numChildren; ++i )
			{
				zones[i] = PixelMod_GridZone( getChildAt( i ) );
			}
		}
		
		public function LoadShipReference( sr:Ship ):void
		{
			ShipReference = sr;
		}
		
		public function UpdateReferenceMod( mod:ModSpawn_ ):void
		{
			ReferenceModSpawner = mod;
		}
		
		public function OnClick_ZoneGrid( click:MouseEvent )
		{
			if( ReferenceModSpawner == null )
			{
				return;
			}
			
			var mod_zone:PixelMod_GridZone = null;
			
			zones.some( 
				function( item:Object, index:int, array:Array )
				{
					if( PixelMod_GridZone( item ).hitTestPoint( click.stageX, click.stageY, true ) )
					{
						mod_zone = PixelMod_GridZone( item );
						return true;
					}
					
					return false;
				});
			
			if( mod_zone != null )
			{
				ReferenceModSpawner.x = mod_zone.x;
				ReferenceModSpawner.y = mod_zone.y;
				ShipReference.AddModPixel( ReferenceModSpawner.Spawn_ModPixel(), int(mod_zone.x/mod_zone.width) + 1, int(mod_zone.y/mod_zone.height) + 1 );
			}
		}
	}
}