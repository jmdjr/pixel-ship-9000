package src.Game_Frame
{
	// Unlike projectiles from the Player, the Enemy projectiles only need to affect 
	// the Player, so they only need a reference rather than a collection.
	import flash.events.Event;
	
	import src.Ship;
	
	public class EnemyProjectile extends Projectile
	{
		protected var PlayerReference:Ship;
		
		public function EnemyProjectile()
		{
			super();
			PlayerReference = null;
			_CurrentClass = EnemyProjectile;
		}
		
		public function SetPlayerReference( _ship:Ship ):void
		{
			PlayerReference = _ship;
		}
		
		public override function Update( tick:Event ):void
		{
			super.Update( tick );
			
			if( PlayerReference != null && hitTestObject( PlayerReference ) )
			{
				PlayerReference.TakeDamage( Damage );
				Disappear();
			}
		}
	}
}