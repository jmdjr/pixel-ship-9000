package src.Customize_Frame
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import src.GameDataTracker;
	import src.Game_Frame.Shot_;
	import src.Game_Frame.Shot_Player_Missile;
	import src.PhysVector2D;
	
	
	public class ModPixel_Attack extends ModPixel_
	{
		var FireNorth:Boolean;
		var FireSouth:Boolean;
		var FireEast:Boolean;
		var FireWest:Boolean;
		var PrimaryWeapon:Shot_Player_Missile;
		var WeaponBoundary:Rectangle;
		var gameData:GameDataTracker;
		
		public function ModPixel_Attack()
		{
			super();
			FireNorth = true;
			FireSouth = true;
			FireEast  = true;
			FireWest  = true;
		}
		
		/**
		 * Enables the Attack Mod Pixel to fire in any number of the four directions.
		 * the directions are as follows:
		 *  NORTH = 1;
		 *  EAST  = 2;
		 *  SOUTH = 3;
		 *  WEST  = 4;
		 */
		public function EnableFireDirections( dir:Number ):void
		{
			switch( dir )
			{
				case 1:
					FireNorth = true;
					break;
				
				case 2:
					FireEast = true;
					break;
				
				case 3:
					FireSouth = true;
					break;
				
				case 4:
					FireWest = true;
					break;
				
				default:
					break;
			}
		}
		
		/**
		 * disables the Attack Mod Pixel to fire in any number of the four directions.
		 * the directions are as follows:
		 *  NORTH = 1;
		 *  EAST  = 2;
		 *  SOUTH = 3;
		 *  WEST  = 4;
		 */
		public function DisableFireDirections( dir:Number ):void
		{
			switch( dir )
			{
				case 1:
					FireNorth = false;
					break;
				
				case 2:
					FireEast = false;
					break;
				
				case 3:
					FireSouth = false;
					break;
				
				case 4:
					FireWest = false;
					break;
				
				default:
					break;
			}
		}
		
		public function Fire():void
		{
			var bullet:Shot_;
			
			if( FireNorth )
			{
				bullet = Shot_( parent.addChild( 
					PrimaryWeapon.Spawn( x, y, PhysVector2D.UP ) ) );
				bullet.LoadBoundary( WeaponBoundary );
				gameData.FireShot();
			}
			
			if( FireEast )
			{
				bullet = Shot_( parent.addChild( 
					PrimaryWeapon.Spawn( x, y, PhysVector2D.LEFT ) ) );
				bullet.LoadBoundary( WeaponBoundary );
				gameData.FireShot();
			}
			
			if( FireSouth )
			{
				bullet = Shot_( parent.addChild( 
					PrimaryWeapon.Spawn( x, y, PhysVector2D.DOWN ) ) );
				bullet.LoadBoundary( WeaponBoundary );
				gameData.FireShot();
			}
			
			if( FireWest )
			{
				bullet = Shot_( parent.addChild( 
					PrimaryWeapon.Spawn( x, y, PhysVector2D.RIGHT ) ) );
				bullet.LoadBoundary( WeaponBoundary );
				gameData.FireShot();
			}
		}
	}
}