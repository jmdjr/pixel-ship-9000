package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import src.PhysVector2D;
	
	public class Shot_ extends MovieClip
	{
		protected var Center:PhysVector2D;     	// Internal reference to the center of the Projectile
		protected var Velocity:PhysVector2D;    // The direction of the Projectile
		protected var Damage:Number;            // The amount of damage the Projectile can cause
		protected var Boundary:Rectangle;      	// The restrictive boundary determining when the Projectile should be removed
		protected var speed:Number;				// The speed of the Projectile.  accessors used to update Velocity.
		protected var _CurrentClass:Class;    	// An internal reference to the current class for spawning
		
		public function Shot_()
		{
			super();
			
			_CurrentClass = Shot_;
			Velocity = new PhysVector2D( );
			Speed = 0;
			Damage = 2;
			Center = new PhysVector2D( height/2, width/2 );
		}
		
		public function get Speed():Number
		{
			return speed;
		}
		
		public function set Speed( s:Number ):void
		{
			speed = s;
			if( Velocity != null )
			{
				Velocity.Normalize();
				Velocity.Multiply( s );
			}
		}
		
		public function Spawn( _x:Number, _y:Number, _v:PhysVector2D ):Shot_
		{
			var temp:Shot_ = new _CurrentClass();
			temp.x = _x - x;
			temp.y = _y - y;
			
			temp.Velocity.Equal( _v.UnitV() );
			temp.Velocity.Normalize();
			temp.Velocity.Multiply( temp.speed );
			temp.Damage = Damage;
			temp.Initialize();
			
			return temp;
		}
		
		public function LoadBoundary( _bound:Rectangle ):void
		{
			Boundary = _bound;
		}
		
		// will set events up so that the object will act like it should.
		public function Initialize():void
		{
			addEventListener( Event.ADDED_TO_STAGE, Echo );
			addEventListener(Event.REMOVED_FROM_STAGE, Unloaded );
		}
		
		private function Echo( test:Event )
		{
			stage.addEventListener( ShipObject.MANAGED_UPDATE, Update );
		}
		
		private function Unloaded( uload:Event ):void
		{
			stage.removeEventListener( ShipObject.MANAGED_UPDATE, Update );
		}
		
		public function Update( tick:Event ):void
		{
			// The projectile requires two 
			if( Boundary != null )
			{
				x += Velocity.X;
				y += Velocity.Y;
				
				var ShipTop = y;
				var ShipBottom = y + height;
				var ShipLeft = x;
				var ShipRight = x + width;
				
				if( ShipTop < Boundary.y || ShipBottom > Boundary.height || ShipLeft < Boundary.x || ShipRight > Boundary.width )
				{
					Disappear();
					return;
				}
			}
		}
		
		public function Disappear():void
		{
			removeEventListener(Event.ENTER_FRAME, Update );
			
			if( parent != null )
			{
				parent.removeChild( this );
			}
		}
		
		public function set ProjectileDamage( _d:Number ):void
		{
			Damage = _d;
		}
		
	}
}




