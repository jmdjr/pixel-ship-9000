package src.Game_Frame
{
	public class Shot_Enemy_L1Boss_Real extends Shot_Enemy_
	{
		public function Shot_Enemy_L1Boss_Real()
		{
			super();
			addChild( new Asset_Shot_L1Boss().getChildAt(0) );
			_CurrentClass = Shot_Enemy_L1Boss_Real;
			Damage = 2;
			speed = 2;
		}
	}
}