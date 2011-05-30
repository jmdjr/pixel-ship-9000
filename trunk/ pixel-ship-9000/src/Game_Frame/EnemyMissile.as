package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import src.PhysVector2D;
	
	public class EnemyMissile extends EnemyProjectile
	{
		public function EnemyMissile()
		{
			super();
			_CurrentClass = EnemyMissile;
			
			Damage = 2;
			speed = 5;
		}
	}
}