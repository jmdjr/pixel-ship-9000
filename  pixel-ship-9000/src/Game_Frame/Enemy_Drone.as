package src.Game_Frame
{
	// This is the base class for enemies.  new enemies will be derived from this class, modifying their behavior 
	//  and the amount of contactDamage/weaponDamage/Defense/Health/etc
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import src.PhysVector2D;
	
	public class Enemy_Drone extends Enemy_
	{
		public function Enemy_Drone()
		{
			super();
			FireRate = 1;
			fullHealth = 1;
			scrapAmount = 1;
			ResetHealth();
			PrimaryWeapon = new Shot_Enemy_Missile();
			PrimaryWeapon.ProjectileDamage = 1;
			_CurrentClass = Enemy_Drone;
		}
		
		public override function Spawn(_x:Number, _y:Number, _v:PhysVector2D):Enemy_
		{
			var temp:Enemy_ = super.Spawn( _x, _y, _v );
			temp.rotation = 0;
			return temp;
		}
		
		protected override function DoCombatChecks():void
		{
			if( FireTimer % ( stage.frameRate / FireRate ) == 0 )
			{
				super.DoCombatChecks();
			}
		}
	}
}