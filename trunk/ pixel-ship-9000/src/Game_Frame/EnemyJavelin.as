package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import src.PhysVector2D;
	
	public class EnemyJavelin extends EnemyObject
	{
		var HasFired:Boolean;
		
		public function EnemyJavelin()
		{
			super();
			_CurrentClass = EnemyJavelin;
			FireRate = 1;
			FireTimer = 1;
			FullHealth = 3;
			Health = 3;
			
			Attack = FullHealth;
			HasFired = false;
			PrimaryWeapon = new Javbeam();
		}	
		
		protected override function DoCombatChecks():void
		{
			if( !HasFired && FireTimer % ( stage.frameRate / FireRate ) == 0 )
			{
				super.DoCombatChecks();
				HasFired = true;
			}
		}
	}
}