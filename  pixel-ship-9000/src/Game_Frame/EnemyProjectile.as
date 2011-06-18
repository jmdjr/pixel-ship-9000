package src.Game_Frame
{
	// Unlike projectiles from the Player, the Enemy projectiles only need to affect 
	// the Player, so they only need a reference rather than a collection.
	import flash.events.Event;
	
	import src.PhysVector2D;
	import src.Ship;
	
	public class EnemyProjectile extends Projectile
	{
		protected var PlayerReference:Ship;
		protected var HitPlayer:Boolean;
		
		public function EnemyProjectile()
		{
			super();
			HitPlayer = false;
			PlayerReference = null;
			_CurrentClass = EnemyProjectile;
		}
		
		public override function Spawn( _x:Number, _y:Number, _v:PhysVector2D ):Projectile
		{
			var temp:Projectile = super.Spawn( _x, _y, _v );
			
			if( _v.CrossP( PhysVector2D.LEFT ) == 0 && !_v.TestDirOpposite( PhysVector2D.LEFT ) )
			{
				temp.rotation = 90;
			}
			else if( _v.CrossP( PhysVector2D.RIGHT ) == 0 && !_v.TestDirOpposite( PhysVector2D.RIGHT )  )
			{
				temp.rotation = -90;
			}
			else if( _v.CrossP( PhysVector2D.UP ) == 0 && !_v.TestDirOpposite( PhysVector2D.UP )  )
			{
				temp.rotation = 180;
			}
			else
			{
				temp.rotation = 0;
			}
			
			return temp;
		}
		
		public function SetPlayerReference( _ship:Ship ):void
		{
			PlayerReference = _ship;
		}
		
		public override function Update( tick:Event ):void
		{
			super.Update( tick );
			
			if( !HitPlayer && PlayerReference != null &&  hitTestPoint( PlayerReference.x, PlayerReference.y, true ) )
			{
				HitPlayer = true;
				PlayerReference.TakeDamage( Damage );
				Disappear();
			}
		}
	}
}