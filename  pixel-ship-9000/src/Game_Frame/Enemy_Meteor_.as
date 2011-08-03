package src.Game_Frame
{
	import flash.events.Event;

	public class Enemy_Meteor_ extends Enemy_
	{
		public function Enemy_Meteor_()
		{
			super();
			_CurrentClass = Enemy_Meteor_;
			FullHealth = 3;
			scrapAmount = 5;
			ResetHealth();
			PrimaryWeapon = null;
		}
		
		protected override function DoCombatChecks():void
		{}
		
		public override function Update(tick:Event):void
		{
			super.Update( tick );
			this.rotation += 1;
		}
	}
}