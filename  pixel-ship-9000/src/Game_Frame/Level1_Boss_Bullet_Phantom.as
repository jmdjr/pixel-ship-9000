package src.Game_Frame
{
	public class Level1_Boss_Bullet_Phantom extends EnemyProjectile
	{
		public function Level1_Boss_Bullet_Phantom()
		{
			addChild( new Level1_Boss_Bullet().getChildAt(0) );
			super();
			_CurrentClass = Level1_Boss_Bullet_Phantom;
			this.Damage = 0;
			speed = 2;
		}
	}
}