package src.Game_Frame
{
	import flash.display.MovieClip;

	public class Level1_Boss_Bullet_Real extends EnemyProjectile
	{
		public function Level1_Boss_Bullet_Real()
		{
			super();
			_CurrentClass = Level1_Boss_Bullet_Real;
			this.Damage = 2;
			this.speed = 1;
		}
	}
}