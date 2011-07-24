package src.Customize_Frame
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import src.GameDataTracker;
	import src.Game_Frame.Shot_;
	import src.Game_Frame.Shot_Player_Missile;
	import src.PhysVector2D;
	
	
	public class ModPixel_Attack extends ModPixel_
	{
		private var FireNorth:Boolean;
		private var FireSouth:Boolean;
		private var FireEast:Boolean;
		private var FireWest:Boolean;
		private var PrimaryWeapon:Shot_Player_Missile;
		private var WeaponBoundary:Rectangle;
		private var gameData:GameDataTracker;
		
		public function ModPixel_Attack()
		{
			super();
			FireNorth = true;
			FireSouth = true;
			FireEast  = true;
			FireWest  = true;
			
			PrimaryWeapon = new Shot_Player_Missile();
			_CurrentClass = ModPixel_Attack;
			_SpawnerClass = ModSpawn_Attack;
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
		
		public function Fire( gameData:GameDataTracker, ship:MovieClip ):void
		{
			var bullet:Shot_;
			
			if( FireNorth )
			{
				bullet = Shot_( ship.parent.addChild( 
					PrimaryWeapon.Spawn( x + ship.x, y + ship.y, PhysVector2D.UP ) ) );
				bullet.LoadBoundary( WeaponBoundary );
				gameData.FireShot();
			}
			
			if( FireEast )
			{
				bullet = Shot_( ship.parent.addChild( 
					PrimaryWeapon.Spawn( x + ship.x, y + ship.y, PhysVector2D.LEFT ) ) );
				bullet.LoadBoundary( WeaponBoundary );
				gameData.FireShot();
			}
			
			if( FireSouth )
			{
				bullet = Shot_( ship.parent.addChild( 
					PrimaryWeapon.Spawn( x + ship.x, y + ship.y, PhysVector2D.DOWN ) ) );
				bullet.LoadBoundary( WeaponBoundary );
				gameData.FireShot();
			}
			
			if( FireWest )
			{
				bullet = Shot_( ship.parent.addChild( 
					PrimaryWeapon.Spawn( x + ship.x, y + ship.y, PhysVector2D.RIGHT ) ) );
				bullet.LoadBoundary( WeaponBoundary );
				gameData.FireShot();
			}
		}
		
		public function LoadBoundary( _bound:Rectangle ):void
		{
			WeaponBoundary = _bound;
		}
		
		public override function Spawn( _bound:Rectangle=null ):ModPixel_
		{
			var temp:ModPixel_ = super.Spawn( );
			WeaponBoundary = _bound;
			
			return temp;
		}
	}
}