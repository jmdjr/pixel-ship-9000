package src.Game_Frame
{
	import flash.events.Event;

	public class EnemyBomb extends EnemyObject
	{
		public function EnemyBomb()
		{
			super();
			Speed = 1;
			FireRate = 1;
			_CurrentClass = EnemyBomb;
			PrimaryWeapon = new EBombSplosion();
		}
		
		public override function Update(tick:Event):void
		{
			super.Update( tick );
		}
		
		protected override function DoCombatChecks():void
		{
			if( stage != null && FireTimer % ( stage.frameRate / FireRate ) == 0 )
			{
				super.DoCombatChecks();
				Explode();
			}
		}
	}
}