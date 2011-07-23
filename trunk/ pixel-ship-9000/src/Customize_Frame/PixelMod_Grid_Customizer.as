package src.Customize_Frame
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import src.Ship;

	/**
	 * Object used to communicate the customizing functionality of the ship 
	 *  and display an interface where the ship can be modified and upgraded.
	 */ 
	public class PixelMod_Grid_Customizer extends MovieClip
	{
		private var ShipReference:Ship;
		private var zones:Array;
		private var ReferenceModSpawner:ModSpawn_;
		
		public function PixelMod_Grid_Customizer()
		{
			zones = new Array( numChildren );
			for( var i:int = 0; i < numChildren; ++i )
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
		
		public function OnClick_ZoneGrid( click:MouseEvent ):void
		{
			var mod_zone:PixelMod_GridZone = null;
			
			zones.some( 
				function( item:Object, index:int, array:Array ):Boolean
				{
					if( PixelMod_GridZone( item ).hitTestPoint( click.stageX, click.stageY, true ) )
					{
						mod_zone = PixelMod_GridZone( item );
						return true;
					}
					
					return false;
				});
			
			if( ReferenceModSpawner == null )
			{
				mod_zone.UpdateModSpawnerRef( null );
				
				return;
			}
			
			if( mod_zone != null )
			{
				var modSpawner:ModSpawn_ = null;
				
				// Identify if there is a mod present at this point in the grid.
				var modSpawnTest:Array = this.getObjectsUnderPoint( new Point( mod_zone.x, mod_zone.y ) );
				var hasSpawner:Boolean = modSpawnTest.some( 
					function( item:Object, index:int, array:Array ):Boolean
					{
						if( item is ModSpawn_ )
						{
							modSpawner = ModSpawn_( item );
							return true;
						}
						
						return false;
					});
				
				// if it does have a spawner, then remove the old spawner.
				if( hasSpawner && modSpawner != null )
				{
					this.removeChild( modSpawner );
					modSpawner.visible = false;
					modSpawner.enabled = false;
				}
				
				ReferenceModSpawner.x = mod_zone.x;
				ReferenceModSpawner.y = mod_zone.y;
				this.addChild( ReferenceModSpawner );
				mod_zone.UpdateModSpawnerRef( ReferenceModSpawner );
			}
		}
		
		/**
		 * produces the PixelMod grid and assigns the mods to the ship based on the grid.
		 * */
		public function Produce_Ship_From_Grid():void
		{
			ShipReference.RemoveAllMods();
			zones.forEach(
				function( item:Object, index:int, array:Array ):void
				{
					if( item != null )
					{
						var temp:PixelMod_GridZone = PixelMod_GridZone( item );
						ShipReference.AddModPixel( temp.InvokeModSpawner(), Math.round( temp.x / temp.width ) + 1, Math.round( temp.y / temp.height ) + 1 );
					}
				});
		}
	}
}