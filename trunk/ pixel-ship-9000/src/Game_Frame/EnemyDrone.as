package src.Game_Frame
{
	// This is the base class for enemies.  new enemies will be derived from this class, modifying their behavior 
	//  and the amount of contactDamage/weaponDamage/Defense/Health/etc
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import src.PhysVector2D;
	
	public class EnemyDrone extends EnemyObject
	{
		public function EnemyDrone()
		{
			super();
			FireRate = 1;
			FullHealth = 2;
			Health = 2;
			Attack = FullHealth;
			_CurrentClass = EnemyDrone;
		}
		
		protected override function DoCombatChecks():void
		{
			if( FireTimer % ( stage.frameRate / FireRate ) <= 0 )
			{
				super.DoCombatChecks();
			}
		}
	}
}