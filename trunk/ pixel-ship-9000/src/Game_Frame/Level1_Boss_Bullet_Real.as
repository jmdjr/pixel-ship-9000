package src.Game_Frame
{
	import flash.display.MovieClip;

	public class Level1_Boss_Bullet_Real extends EnemyProjectile
	{
		public function Level1_Boss_Bullet_Real()
		{
			super();
			addChild( new Level1_Boss_Bullet().getChildAt(0) );
			_CurrentClass = Level1_Boss_Bullet_Real;
			Damage = 2;
			speed = 2;
		}
	}
}