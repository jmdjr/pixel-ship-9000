package src.Game_Frame
{
	import flash.events.Event;

	public class Shot_Enemy_L1Boss_Phantom extends Shot_Enemy_
	{
		private var temp:Asset_Shot_L1Boss;
		
		public function Shot_Enemy_L1Boss_Phantom()
		{
			super();
			temp = new Asset_Shot_L1Boss();
			
			_CurrentClass = Shot_Enemy_L1Boss_Phantom;
			Damage = 0;
			speed = 2;
			HitPlayer = true;
			
			addEventListener(Event.ADDED_TO_STAGE, initiate );
		}
		private function initiate( tick:Event ):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initiate );
			addChild( temp.getChildAt(0) );
		}
	}
}