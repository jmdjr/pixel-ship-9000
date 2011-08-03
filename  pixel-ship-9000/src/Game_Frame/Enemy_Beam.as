package src.Game_Frame
{
	public class Enemy_Beam extends Enemy_
	{
		public function Enemy_Beam()
		{
			super();
			_CurrentClass = Enemy_Beam;
			PrimaryWeapon = null;
			Speed = 5;
			attack = 5;
			invulnerable = true;
		}
	}
}