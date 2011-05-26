package src.Game_Frame
{
	
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import src.PhysVector2D;
	
	public class ShipObject extends MovieClip
	{
		public var Boundary:Rectangle;
		
		protected var WeaponBoundary:Rectangle;
		protected var PrimaryWeapon:Projectile;
		protected var FireTimer:Number;
		protected var FireRate:Number;
		protected var CanFire:Boolean;
		
		protected var Health:Number;
		protected var FullHealth:Number;
		protected var IsDead:Boolean;
		protected var Invulnerable:Boolean;
		
		protected var Speed:Number;
		protected var Velocity:PhysVector2D;
		protected var IsStopped:Boolean;
		
		protected var Defense:Number;
		protected var Attack:Number;
		
		public function get isDead():Boolean
		{
			return IsDead;
		}
		
		public function ShipObject()
		{
			super();
			IsStopped = false;
			IsDead = false;
			FireRate = 1;
			FireTimer = 0;
			Health = 1;
			FullHealth = 1;
			Defense = 1;
			Attack = 1;
			Speed = 1;
			Invulnerable = false;
			PrimaryWeapon = null;
			WeaponBoundary = null;
			Boundary = null;
			Velocity = null;
		}
		
		public function ResetHealth():void
		{
			Health = FullHealth;
		}
		
		public function get ShipSpeed():Number
		{
			return Speed;
		}
		
		public function set ShipSpeed( s:Number ):void
		{
			Speed = s;
		}
		
		
		public function Disappear():void
		{
			removeEventListener( Event.ENTER_FRAME, Update );
			parent.removeChild( this );
			IsDead = true;
		}
		
		public function Explode():void
		{
			if( parent != null )
			{
				var esplosion:Explosion = Explosion( parent.addChild( new Explosion() ) );
				esplosion.x = x;
				esplosion.y = y;
				Disappear();
			}
		}
		
		protected function DoMoveChecks():void
		{
			if( !IsStopped )
			{
				Velocity.Normalize();
				Velocity.Multiply( Speed );
				
				x += Velocity.X;
				y += Velocity.Y;
			}
		}
		protected function DoCombatChecks():void
		{
			IsDead = (this.parent == null);
		}
		 
		protected function DoBoundaryChecks():void
		{
			IsDead = (this.parent == null);
		}
		
		protected function DoHealthChecks():void
		{
			if( this.Health <= 0 )
			{
				Explode();
			}
		}
		
		public function Update( tick:Event ):void
		{			
			FireTimer += 1;
			
			if( FireTimer > 1000000 )
			{
				FireTimer = 0;
			}
			
			if( !IsDead ) DoHealthChecks();
			if( !IsDead ) DoMoveChecks();
			if( !IsDead ) DoBoundaryChecks();
			if( !IsDead ) DoCombatChecks();
		}
		
		public function TakeDamage( amount:Number ):void
		{
			if( !Invulnerable )
			{
				Health -= amount;
				if( Health <= 0 )
				{
					Explode();
					IsDead = true;
				}
			}
		}
		
		/**
		 * Deals an amount of Damage to another ship.
		 */ 
		public function DealDamage( someone:ShipObject ):void
		{
			if( !Invulnerable )
			{
				someone.TakeDamage( Attack );
			}
		}
	}
}