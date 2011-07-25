package src.Game_Frame
{
	import Juke_Box.JukeBox;
	
	import src.PhysVector2D;

	public class Enemy_BlueDrone extends Enemy_
	{
		private var base_firedirection:PhysVector2D;
		
		public function Enemy_BlueDrone()
		{
			super();
			FireRate = 1;
			FullHealth = 1;
			scrapAmount = 1;
			base_firedirection = new PhysVector2D();
			ResetHealth();
			PrimaryWeapon = new Shot_Enemy_Missile();
			PrimaryWeapon.ProjectileDamage = 1;
			_CurrentClass = Enemy_BlueDrone;
		}
			
		public override function Spawn(_x:Number, _y:Number, _v:PhysVector2D ):Enemy_
		{
			var temp:Enemy_ = super.Spawn( _x, _y, _v );
			temp.rotation = 0;
			
			base_firedirection.Equal( FireDirection );
			
			return temp;
		}
		
		protected override function DoCombatChecks():void
		{
			if( FireTimer % ( stage.frameRate / FireRate ) == 0 )
			{
				JukeBox.PlaySE( JukeBox.ATTACK1_SE );
				FireDirection.Equal( PhysVector2D.Add( base_firedirection, new PhysVector2D(1, 1) ) );
				super.DoCombatChecks();
				FireDirection.Equal( PhysVector2D.Add( base_firedirection, PhysVector2D.RIGHT ) );
				super.DoCombatChecks();
			}
		}
	}
}