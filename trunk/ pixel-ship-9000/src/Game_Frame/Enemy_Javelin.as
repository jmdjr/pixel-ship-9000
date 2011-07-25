package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import Juke_Box.JukeBox;
	
	import src.PhysVector2D;
	
	public class Enemy_Javelin extends Enemy_
	{
		private var HasFired:Boolean;
		
		public function Enemy_Javelin()
		{
			super();
			_CurrentClass = Enemy_Javelin;
			FireRate = 1;
			FireTimer = 1;
			FullHealth = 3;
			scrapAmount = 2;
			ResetHealth();
			HasFired = false;
			PrimaryWeapon = new Shot_Enemy_Beam();
		}
		
		protected override function DoCombatChecks():void
		{
			if( !HasFired && FireTimer % ( stage.frameRate / FireRate ) == 0 )
			{
				JukeBox.PlaySE( JukeBox.ATTACK1_SE );
				super.DoCombatChecks();
				HasFired = true;
			}
		}
	}
}