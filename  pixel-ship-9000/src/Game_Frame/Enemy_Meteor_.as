package src.Game_Frame
{
	import src.PhysVector2D;

	public class Enemy_Meteor_ extends Enemy_
	{
		private var MeteorA:Class = Enemy_Meteor_A;
		private var MeteorB:Class = Enemy_Meteor_B;
		private var MeteorC:Class = Enemy_Meteor_C;
		
		public function Enemy_Meteor_()
		{
			super();
			_CurrentClass = Enemy_Meteor_;
			FullHealth = 3;
			scrapAmount = 5;
			ResetHealth();
			PrimaryWeapon = null;
		}
		private function RandomCurrentClass():void
		{
			var rand:Number = Math.random() * 100;
			if( rand <= 30 )
			{
				_CurrentClass = Enemy_Meteor_A;
			}
			else if( rand > 30 && rand <= 60 )
			{
				_CurrentClass = Enemy_Meteor_B;
			}
			else
			{
				_CurrentClass = Enemy_Meteor_C;
			}
		}
		
		protected override function DoCombatChecks():void
		{
		}
		
		public override function Spawn(_x:Number, _y:Number, _v:PhysVector2D):Enemy_
		{
			RandomCurrentClass();
			var temp:Enemy_ = super.Spawn( _x, _y, _v );
			return temp;
		}
	}
}