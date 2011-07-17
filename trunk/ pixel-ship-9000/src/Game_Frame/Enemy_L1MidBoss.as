package src.Game_Frame
{
	import flash.events.Event;
	
	import src.PhysVector2D;

	public class Enemy_L1MidBoss extends Enemy_
	{
		var fadeEffectTimer:Number;
		
		public function Enemy_L1MidBoss()
		{
			super();
			_CurrentClass = Enemy_L1MidBoss;
			PrimaryWeapon = new Shot_Enemy_Missile();
			fadeEffectTimer = 200;
			alpha = 0;
			health = 5;
			scrapAmount = 25;
			FullHealth = 5;
		}
		
		public override function Update( tick:Event ):void
		{
			if( fadeEffectTimer > 0 && 
				( FireTimer % ( fadeEffectTimer * stage.frameRate ) == 0 ) )
			{
				Invulnerable = true;
				alpha += 0.005;
				--fadeEffectTimer;
				return;
			}
			
			Invulnerable = false;
			FireDirection.X = ShipReference.x - x;
			FireDirection.Y = ShipReference.y - y;
			
			super.Update( tick );
		}
		
		protected override function DoBoundaryChecks():void
		{
			if( Boundary != null && !IsDead )
			{
				var ShipTop = y;
				var ShipBottom = y + height;
				var ShipLeft = x;
				var ShipRight = x + width;
				
				if( ShipTop < Boundary.y || ShipBottom > 300 )
				{
					this.velocity.Y *= -1;
				}
				
				if( ShipLeft < Boundary.x || ShipRight > Boundary.width )
				{
					this.velocity.X *= -1;
				}
			}
		}
		
		protected override function DoCombatChecks():void
		{
			if( FireTimer % ( stage.frameRate / FireRate ) == 0 )
			{
				super.DoCombatChecks();
			}
		}
	}
}
















