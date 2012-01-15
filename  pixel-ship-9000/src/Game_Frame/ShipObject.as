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
		public static var MANAGED_UPDATE:String = "ManagedUpdate";
		public var Boundary:Rectangle;
		
		protected var WeaponBoundary:Rectangle;
		protected var PrimaryWeapon:Shot_;
		protected var FireTimer:Number;
		protected var FireRate:Number;
		protected var CanFire:Boolean;
		
		protected var health:Number;
		protected var fullHealth:Number;
		protected var isDead:Boolean;
		protected var invulnerable:Boolean;
		
		protected var velocity:PhysVector2D;
		protected var IsStopped:Boolean;
		
		protected var defense:Number;
		protected var attack:Number;
		protected var speed:Number;
		
		protected var damageEffectTimer:Timer;
		protected var damageColor:ColorTransform;
		protected var normalColor:ColorTransform;
		
		public function ShipObject()
		{
			super();
			IsStopped = false;
			isDead = false;
			
			FireRate = 1;
			FireTimer = 0;
			fullHealth = 1;
			Defense = 1;
			attack = 0;
			speed = 1;
			
			ResetHealth();
			normalColor = new ColorTransform();
			damageColor = new ColorTransform( 1, 1, 1, 1, 255, -255, -255 );
			transform.colorTransform = normalColor;
			
			damageEffectTimer = new Timer(10, 5);
			damageEffectTimer.addEventListener( TimerEvent.TIMER, damEffectTimer );
			damageEffectTimer.addEventListener( TimerEvent.TIMER_COMPLETE, restoreNormalColor );
			invulnerable = false;
			PrimaryWeapon = null;
			WeaponBoundary = null; 
			Boundary = null;
			velocity = null;
		}
		
		private function restoreNormalColor( e:TimerEvent ):void
		{
			transform.colorTransform = normalColor;
		}
		
		private function damEffectTimer( e:TimerEvent ):void
		{
			if( damageEffectTimer.currentCount % 2 == 1 )
			{
				transform.colorTransform = damageColor;
			}
			else
			{
				transform.colorTransform = normalColor;
			}
		}
		
		protected function DamageEffect( ):void
		{
				damageEffectTimer.reset();
				damageEffectTimer.start();
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
					isDead = true;
				}
			}
		}
		
		/**
		 * Deals an amount of Damage to another ship.
		 */ 
		public function DealDamage( someone:ShipObject ):void
		{
			if( !someone.Invulnerable )
			{
				someone.TakeDamage( Attack );
			}
		}
		
		public function Disappear():void
		{
			removeEventListener( Event.ENTER_FRAME, Update );
			parent.removeChild( this );
			while( numChildren > 0 )
			{
				removeChildAt( 0 );
			}
			isDead = true;
		}
		
		public function Explode():void
		{
			if( parent != null )
			{
				var esplosion:Clip_Explosion = Clip_Explosion( parent.addChild( new Clip_Explosion() ) );
				esplosion.x = x;
				esplosion.y = y;
				Disappear();
			}
		}
		
		protected function DoMoveChecks():void
		{
			if( !IsStopped )
			{
				velocity.Normalize();
				velocity.Multiply( Speed );
				
				x += velocity.X;
				y += velocity.Y;
			}
		}
		protected function DoCombatChecks():void
		{
			isDead = ( parent == null );
		}
		 
		protected function DoBoundaryChecks():void
		{
			isDead = ( parent == null );
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
			
			if( FireTimer > 1000000000 )
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
		
		protected function get FullHealth():Number
		{
			return fullHealth;
		}
		
		protected function set FullHealth( value:Number ):void
		{
			fullHealth = value;
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
		
		public function get Health():Number
		{
			return health;
		}
		public function set Health( _h:Number ):void
		{
			health = _h;
		}
		
		public function get IsDead():Boolean
		{
			return isDead;
		}
		
		public function get ShipSpeed():Number
		{
			return Speed; 
		}
		
		public function set ShipSpeed( s:Number ):void
		{
			Speed = s;
		}
		
		public function get Invulnerable():Boolean
		{
			return invulnerable;
		}
		
		public function set Invulnerable( _b:Boolean ):void
		{
			invulnerable = _b;
		}
		
		public function get Velocity():PhysVector2D
		{
			return this.velocity;
		}
		public function set Velocity( v:PhysVector2D):void
		{
			this.velocity = v;
		}
	}
}