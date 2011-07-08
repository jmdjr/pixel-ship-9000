package src.Game_Frame
{
	public class Shot_Enemy_L1Boss_Phantom extends Shot_Enemy_
	{
		public function Shot_Enemy_L1Boss_Phantom()
		{
			addChild( new Asset_Shot_L1Boss().getChildAt(0) );
			super();
			_CurrentClass = Shot_Enemy_L1Boss_Phantom;
			this.Damage = 0;
			speed = 2;
			this.HitPlayer = true;
		}
	}
}