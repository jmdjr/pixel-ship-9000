package src.Game_Frame
{
	import flash.events.Event;
	
	import src.PhysVector2D;

	public class Shot_Boss_Homing extends Shot_Enemy_
	{
		private var lifespan:Number;
		private var clock:Number;
		public function Shot_Boss_Homing()
		{
			super();
			clock = 0;
			Speed = 1;
			lifespan = 1;  // number of seconds to live.
			_CurrentClass = Shot_Boss_Homing;
		}
		
		public override function Update(tick:Event):void
		{
			// identify direction of ship from bullet.
			// figure out which direction to turn.
			// turn a fraction of the direction towards the hero.
			var toShipDirection:PhysVector2D = new PhysVector2D( PlayerReference.x - this.x, PlayerReference.y - this.y );
			toShipDirection.Normalize();
			Velocity.Add( toShipDirection );
			
			if( lifespan < 0 )
			{
				Disappear();
				return;
			}
			clock += 1;
			lifespan -= ( clock % stage.frameRate == 0? 1 : 0 );
			
			super.Update(tick);
			
		}
	}
}