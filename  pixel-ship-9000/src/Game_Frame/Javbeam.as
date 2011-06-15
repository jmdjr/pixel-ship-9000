package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	import src.PhysVector2D;
	
	public class Javbeam extends EnemyProjectile
	{
		public function Javbeam()
		{
			super();
			_CurrentClass = Javbeam;
			speed = 5;
		}
		
		public override function Spawn(_x:Number, _y:Number, _v:PhysVector2D):Projectile
		{
			return super.Spawn( _x, _y, _v );
		}
	}
}