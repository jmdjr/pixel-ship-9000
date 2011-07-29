package src.Game_Frame
{
	import src.PhysVector2D;

	public class Enemy_GreenDrone extends Enemy_Drone
	{
		public function Enemy_GreenDrone()
		{
			super();
			FireRate = 2;
			_CurrentClass = Enemy_GreenDrone;
		}
		
		public override function Spawn(_x:Number, _y:Number, _v:PhysVector2D):Enemy_
		{
			return super.Spawn( _x, _y, _v );
		}
		
	}

}
