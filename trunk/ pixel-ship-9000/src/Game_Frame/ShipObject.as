package src.Game_Frame
{
	
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import src.PhysVector2D;
	import src.Ship;
	
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
		
		protected var Velocity:PhysVector2D;
		protected var IsStopped:Boolean;
		
		protected var defense:Number;
		protected var attack:Number;
		protected var speed:Number;
		
		protected var damageEffectTimer:Timer;

		public function ShipObject()
		{
			super();
			IsStopped = false;
			IsDead = false;
			
			FireRate = 1;
			FireTimer = 0;
			Health = 1;
			FullHealth = 1;
			defense = 0;
			attack = 1;
			speed = 1;
			
			transform.colorTransform = new ColorTransform();
			damageEffectTimer = new Timer(0, 10);
			damageEffectTimer.addEventListener( TimerEvent.TIMER, damEffectTimer );
			
			Invulnerable = false;
			PrimaryWeapon = null;
			WeaponBoundary = null;
			Boundary = null;
			Velocity = null;
		}
		
		private function damEffectTimer( e:TimerEvent ):void
		{
			damageEffectTimer.delay = 1000;
			if( damageEffectTimer.currentCount % 2 == 1 )
			{
				transform.colorTransform.redOffset += 200;
			}
			else
			{
				transform.colorTransform.redOffset -= 200;
			}
		}
		
		public function TakeDamage( amount:Number ):void
		{ 
			if( !Invulnerable )
			{
				Health -= amount - Defense;
				DamageEffect();
				if( Health <= 0 )
				{
					Explode();
					IsDead = true;
				}
			}
		}
		
		protected function DamageEffect( ):void
		{
			damageEffectTimer.start();
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
		
		
		
		public function ResetHealth():void
		{
			Health = FullHealth;
		}
		
		protected function get Speed():Number
		{
			return speed;
		}		
		protected function set Speed( s:Number ):void
		{
			speed = s;
		}
		
		protected function get Attack():Number
		{
			return attack;
		}
		protected function set Attack( a:Number ):void
		{
			attack = a;
		}
		
		protected function get Defense():Number
		{
			return defense;
		}
		protected function set Defense( d:Number ):void
		{
			defense = d;
		}
		
		public function get isDead():Boolean
		{
			return IsDead;
		}
		
		public function get ShipSpeed():Number
		{
			return Speed;
		}
		
		public function set ShipSpeed( s:Number ):void
		{
			Speed = s;
		}
	}
}