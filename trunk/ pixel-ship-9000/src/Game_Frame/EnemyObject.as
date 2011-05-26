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
			PrimaryWeapon = new EnemyMissile();
			Velocity = new PhysVector2D();
			FireDirection = new PhysVector2D();
			
		}
		
		public function Spawn( _x:Number, _y:Number, _v:PhysVector2D ):EnemyObject
		{
			var temp:EnemyObject = new _CurrentClass();
			temp.x = _x;
			temp.y = _y;
			temp.Velocity.Equal( _v.UnitV() );
			
			temp.Initialize();
			temp.Velocity.Multiply( temp.ShipSpeed );
			temp.LoadBoundary( Boundary, WeaponBoundary );
			temp.FireDirection.Equal( temp.Velocity );
			
			return temp;
		}
		
		public function LoadPlayerReference( _s:Ship ):void
		{
			ShipReference = _s;
		}
		
		public function Initialize():void
		{
			addEventListener( Event.ENTER_FRAME, Update );
			addEventListener(Event.REMOVED_FROM_STAGE, Unloaded );
		}
		
		private function Unloaded( uload:Event ):void
		{
			removeEventListener( Event.ENTER_FRAME, Update );
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
		
		protected function DoCollisionChecks():void
		{
			if( !IsDead && !Invulnerable &&  hitTestObject( ShipReference ) )
			{
				ShipReference.DealDamage( this );
				DealDamage( ShipReference );
			}
		}
		
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
		
		public override function Update( tick:Event ):void
		{
			super.Update( tick );
			
			if( !IsDead ) DoCollisionChecks();
		}
	}
}