package src.Game_Frame
{	
	import src.PhysVector2D;
	import Juke_Box.JukeBox;

	public class Shot_Enemy_Missile extends Shot_Enemy_
	{
		public function Shot_Enemy_Missile()
		{
			super();
			_CurrentClass = Shot_Enemy_Missile;
			
			Damage = 2;
			speed = 5;
		}
		
		public override function Spawn(_x:Number, _y:Number, _v:PhysVector2D):Shot_
		{
			return super.Spawn( _x, _y, _v );
		}
	}
}