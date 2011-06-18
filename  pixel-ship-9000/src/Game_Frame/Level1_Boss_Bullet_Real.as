package src.Game_Frame
{
	import flash.display.MovieClip;

	public class Level1_Boss_Bullet_Real extends EnemyProjectile
	{
		public function Level1_Boss_Bullet_Real()
		{
			super();
			_CurrentClass = Level1_Boss_Bullet_Real;
			Damage = 2;
			speed = 3;
		}
	}
}