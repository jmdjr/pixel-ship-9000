package src.Game_Frame
{
	import flash.events.Event;

	public class Shot_Enemy_L1Boss_Real extends Shot_Enemy_
	{
		private var temp:Asset_Shot_L1Boss;
		
		public function Shot_Enemy_L1Boss_Real()
		{
			super();
			temp = new Asset_Shot_L1Boss();
			_CurrentClass = Shot_Enemy_L1Boss_Real;
			Damage = 2;
			speed = 2;
			addEventListener(Event.ADDED_TO_STAGE, initiate );
		}
		
		private function initiate( tick:Event ):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initiate );
			addChild( temp.getChildAt(0) );
		}
	}
}