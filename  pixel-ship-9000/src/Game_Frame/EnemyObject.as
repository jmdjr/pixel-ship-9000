package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import src.PhysVector2D;
	import src.Ship;
	
	public class EnemyObject extends ShipObject
	{
		public var ShipReference:Ship;
		
		protected var _CurrentClass:Class;    // An internal reference to the current class for spawning
		protected var FireDirection:PhysVector2D;
		
		public function EnemyObject()
		{
			super();
			_CurrentClass = EnemyObject;
			ShipReference = null;
			Boundary = null;
			FireRate = 1;
			FireTimer = 0;
			PrimaryWeapon = null;
			velocity = new PhysVector2D();
			FireDirection = new PhysVector2D();
			
		}
		
		public function Spawn( _x:Number, _y:Number, _v:PhysVector2D ):EnemyObject
		{
			var temp:EnemyObject = new _CurrentClass();
			temp.x = _x;
			temp.y = _y;
			temp.velocity.Equal( _v.UnitV() );
			temp.Initialize();
			temp.velocity.Multiply( temp.ShipSpeed );
			
			temp.LoadBoundary( Boundary, WeaponBoundary );
			temp.FireDirection.Equal( _v );
			
			return temp;
		}
		
		public function LoadPlayerReference( _s:Ship ):void
		{
			ShipReference = _s;
		}
		
		public function Initialize():void
		{
			addEventListener( Event.ADDED_TO_STAGE, OnAddToStage );
			addEventListener(Event.REMOVED_FROM_STAGE, Unloaded );
		}
		
		private function OnAddToStage( test:Event )
		{
			// Made for an internally managed update.
			//  this way enemies and items can be placed dynamically without any need
			//  for additional memory usage, but still being able to manage their updates.
			stage.addEventListener( ShipObject.MANAGED_UPDATE, Update );
		}
		
		private function Unloaded( uload:Event ):void
		{
			stage.removeEventListener( ShipObject.MANAGED_UPDATE, Update );
		}
		
		public function LoadBoundary( _bound:Rectangle, _weaponBound:Rectangle = null ):void
		{
			this.Boundary = _bound;
			if( _weaponBound != null )
			{
				WeaponBoundary = _weaponBound;
			}
		}
		
		/**
		 * Does the Boundary tests.  if the enemy has hit a boundary, 
		 * this boundary condition will force enemy to disappear. 
		 */
		protected override function DoBoundaryChecks():void
		{
			super.DoBoundaryChecks();
			if( Boundary != null && !IsDead )
			{
				var ShipTop = y;
				var ShipBottom = y + height;
				var ShipLeft = x;
				var ShipRight = x + width;
			
				if( ShipTop < Boundary.y || ShipBottom > Boundary.height || ShipLeft < Boundary.x || ShipRight > Boundary.width )
				{
					Disappear();
				}
			}
		}

		/**
		 * Does Collision checks with the Ship
		 */
		protected function DoCollisionChecks():void
		{
			if( !IsDead && hitTestObject( ShipReference ) )
			{
				if( !Invulnerable )
				{
					ShipReference.DealDamage( this );
					DealDamage( ShipReference );
				}
				
				var centersVector:PhysVector2D = PhysVector2D.Subtract( velocity, ShipReference.Velocity );
				var throwDistance:Number = ( height + width + ShipReference.height + ShipReference.width ) / 8;
				centersVector.Normalize();
				centersVector.Multiply( throwDistance );
				ShipReference.x += centersVector.X;
				ShipReference.y += centersVector.Y;
			}
		}
		
		/**
		 * Does combat checks, ensuring that enemy can fire its primary weapons
		 *   override this to include additional attacks, throttle fire speeds, etc.
		 * */
		protected override function DoCombatChecks():void
		{
			super.DoCombatChecks();
			if( !IsDead && PrimaryWeapon != null && parent != null )
			{
				var indexOf = parent.getChildIndex( this );
				var bullet:EnemyProjectile = EnemyProjectile(
					parent.addChildAt( PrimaryWeapon.Spawn( x, y, FireDirection ), indexOf - 1 ) );
				
				bullet.LoadBoundary( WeaponBoundary );
				bullet.SetPlayerReference( ShipReference );
			}
		}
		
		/**
		 * Update that adds the collision checks for the ship.
		 * */
		public override function Update( tick:Event ):void
		{
			super.Update( tick );
			if( !IsDead ) DoCollisionChecks();
		}
	}
}