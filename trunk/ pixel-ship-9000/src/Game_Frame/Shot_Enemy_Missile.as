package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import src.PhysVector2D;
	
	public class Shot_Enemy_Missile extends Shot_Enemy_
	{
		public function Shot_Enemy_Missile()
		{
			super();
			_CurrentClass = Shot_Enemy_Missile;
			
			Damage = 2;
			speed = 5;
		}
	}
}