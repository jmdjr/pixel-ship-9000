package src.Game_Frame
{
	import src.PhysVector2D;
	public class Enemy_Silo extends Enemy_
	{
		public function Enemy_Silo()
		{
			super();
			_CurrentClass = Enemy_Silo;
			Speed = 0.5;
			FireRate = 2;
			PrimaryWeapon = new Shot_Boss_Homing();
		}
		
		protected override function DoCombatChecks():void
		{
			if( FireTimer % int(stage.frameRate / this.FireRate) == 0 )
			{
				this.FireDirection.Equal( PhysVector2D.DOWN );
				super.DoCombatChecks();
				
				this.FireDirection.Equal( PhysVector2D.LEFT );
				super.DoCombatChecks();
				
				this.FireDirection.Equal( PhysVector2D.RIGHT );
				super.DoCombatChecks();
				
				this.FireDirection.Equal( new PhysVector2D( -1, -1 ) );
				super.DoCombatChecks();
				
				this.FireDirection.Equal( new PhysVector2D( 1, -1 ) );
				super.DoCombatChecks();
			}
		}
	}
}