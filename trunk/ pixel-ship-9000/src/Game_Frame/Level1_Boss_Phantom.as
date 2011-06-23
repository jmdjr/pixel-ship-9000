package src.Game_Frame
{
	import src.PhysVector2D;

	public class Level1_Boss_Phantom extends EnemyObject
	{
		protected var isHidden:Boolean;
		
		public function Level1_Boss_Phantom()
		{
			super();
			_CurrentClass = Level1_Boss_Phantom;
			PrimaryWeapon = new Level1_Boss_Bullet_Phantom();
			speed = 0.5;
			Invulnerable = true;
			isHidden = true;
		}
		
		public function get getVelocity():PhysVector2D
		{
			return velocity;
		}
		
		public function set setVelocity( v:PhysVector2D ):void
		{
			velocity.Equal( v );
		}
		
		public function doCombatCheck():void
		{
			FireDirection.Equal( velocity );
			super.DoCombatChecks();
		}
		public function doMoveChecks():void
		{
			super.DoMoveChecks();
		}

		protected override function DoCombatChecks():void
		{}
		
		protected override function DoBoundaryChecks():void
		{}
		
		protected override function DoMoveChecks():void
		{}
		
		protected override function bounceOffShip():void
		{
			if( isHidden )
			{
				super.bounceOffShip();
			}
		}
		
		public function set Hidden( _t:Boolean ):void
		{
			isHidden = _t;
		}
		
	}
}