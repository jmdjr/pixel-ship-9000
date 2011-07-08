package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	import src.PhysVector2D;
	
	public class Shot_Enemy_Beam extends Shot_Enemy_
	{
		public function Shot_Enemy_Beam()
		{
			super();
			_CurrentClass = Shot_Enemy_Beam;
			speed = 5;
		}
	}
}