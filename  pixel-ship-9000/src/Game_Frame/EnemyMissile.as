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
			this._CurrentClass = EnemyMissile;
			
			this.Damage = 1;
			this.speed = 5;
		}
	}
}