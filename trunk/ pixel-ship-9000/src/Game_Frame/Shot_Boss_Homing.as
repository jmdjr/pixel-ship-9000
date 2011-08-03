package src.Game_Frame
{
	import flash.events.Event;
	
	import src.PhysVector2D;

	public class Shot_Boss_Homing extends Shot_Enemy_
	{
		private var lifespan:Number;
		private var clock:Number;
		private var delay:Number;
		private var lag:Number;
		
		public function Shot_Boss_Homing()
		{
			super();
			clock = 0;
			Speed = 2;
			lifespan = 2;  // number of seconds to live.
			delay = 1;     // time before missle starts aiming towards ship
			lag = 10;	   // lag between each reorientation of the missle. 
			_CurrentClass = Shot_Boss_Homing;
		}
		
		public override function Update(tick:Event):void
		{
			// Delay a little bit before homing.
			var delayTime:int = delay * stage.frameRate;
			
			if( delayTime <= clock && clock % lag  == 0 )
			{
				// identify direction of ship from bullet.
				// figure out which direction to turn.c
				// turn a fraction of the direction towards the hero.
				var toShipDirection:PhysVector2D = new PhysVector2D( PlayerReference.x - this.x, PlayerReference.y - this.y );
				toShipDirection.Normalize();
				Velocity.Add( toShipDirection );
			}
			
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