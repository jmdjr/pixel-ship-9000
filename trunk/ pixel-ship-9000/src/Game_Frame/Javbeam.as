package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Javbeam extends EnemyProjectile
	{
		public function Javbeam()
		{
			super();
			_CurrentClass = Javbeam;
			
			speed = 5;
			Damage = 2;
		}
	}
}