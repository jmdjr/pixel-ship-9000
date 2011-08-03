package src.Game_Frame
{
	import src.Game_Frame.Shot_Boss_Homing;
	import src.PhysVector2D;
	
	public class Enemy_GreenDrone extends Enemy_Drone
	{
		public function Enemy_GreenDrone()
		{
			super();
			FireRate = 2;
			_CurrentClass = Enemy_GreenDrone;
			PrimaryWeapon = new Shot_Boss_Homing();
		}
	}

}
