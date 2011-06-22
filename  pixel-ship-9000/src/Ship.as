package src
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import src.Game_Frame.Customize_Frame.ModGrid;
	import src.Game_Frame.Missile;
	import src.Game_Frame.Projectile;
	import src.Game_Frame.ShipObject;
	import src.PhysVector2D;
	
	public class Ship extends ShipObject
	{
		private var isFiring:Boolean;
		var gameData:GameDataTracker;
		var canFire:Boolean;
		
		private var ModAttack;
		private var ModSpeed;
		private var ModDefense;
		private var MG:ModGrid;
		
		public override function Disappear():void
		{
			removeEventListener( Event.ENTER_FRAME, Update );
			this.visible = false;
		}
		
		public override function ResetHealth():void
		{
			super.ResetHealth();
			this.visible = true;
		}
		
		protected override function get Attack():Number
		{
			return ModAttack + attack;
		}
		
		protected override function get Defense():Number
		{
			return ModDefense + defense;
		}
		
		protected override function get Speed():Number
		{
			return ModSpeed + speed;
		}
		
		public function Ship()
		{
			super();
			isFiring = false;
			canFire = false;
			
			velocity = new PhysVector2D();
			PrimaryWeapon = new Missile();
			fullHealth = 10;
			ShipSpeed = 3;
			Defense = 0;
			FireTimer = 1;
			FireRate = 1;
			
			ModAttack = 0;
			ModDefense = 0;
			ModSpeed = 0;
			
			Boundary = null;
			WeaponBoundary = null;
			Attack = fullHealth;
			ResetHealth();
		}
		
		public override function Update( tick:Event ):void
		{
			super.Update( tick );
		}
		
		protected override function DoCombatChecks():void
		{	
			if( isFiring && canFire && parent != null && PrimaryWeapon != null )
			{
				var bullet:Projectile;
				bullet = Projectile( parent.addChild( 
						PrimaryWeapon.Spawn( x, y, PhysVector2D.UP ) ) );
				bullet.LoadBoundary( WeaponBoundary );
				gameData.FireShot();
				
				bullet = Projectile( parent.addChild( 
					PrimaryWeapon.Spawn( x, y, PhysVector2D.DOWN ) ) );
				bullet.LoadBoundary( WeaponBoundary );
				gameData.FireShot();
				
				bullet = Projectile( parent.addChild( 
					PrimaryWeapon.Spawn( x, y, PhysVector2D.LEFT ) ) );
				bullet.LoadBoundary( WeaponBoundary );
				gameData.FireShot();
				
				bullet = Projectile( parent.addChild( 
					PrimaryWeapon.Spawn( x, y, PhysVector2D.RIGHT ) ) );
				bullet.LoadBoundary( WeaponBoundary );
				gameData.FireShot();
				
				canFire = false;
				FireTimer = 1;
			}
			
			if( stage != null && !canFire && FireTimer % ( stage.frameRate / FireRate )  == 0 )
			{
				canFire = true;
			}
		}
		
		protected override function DoBoundaryChecks():void
		{
			if( Boundary != null )
			{
				var ShipTop = y;
				var ShipBottom = y + height;
				var ShipLeft = x;
				var ShipRight = x + width;
				
				if( ShipTop < Boundary.y )
				{
					y = Boundary.y;
				}
				
				if( ShipBottom > Boundary.height )
				{
					y = Boundary.height - height;
				}
				
				if( ShipLeft < Boundary.x )
				{
					x = Boundary.x;
				}
				
				if( ShipRight > Boundary.width ) 
				{
					x = Boundary.width - width;
				}
			}
		}
		
		/**
		 * When an enemy is killed, they report to the ship that they have been killed
		 * using this function.
		 */
		public function KilledEnemy():void
		{
			gameData.EnemyKill();
		}
		
		public function AddScrap( scrapToAdd:Number ):void
		{
			gameData.AddScrap( scrapToAdd );
		}
		
		public function HealthPercentage():Number
		{
			isDead = false;
			return health / fullHealth;
		}
		public function LoadBoundary( _bound:Rectangle, _bullet:Rectangle ):void
		{
			this.Boundary = _bound;
			this.WeaponBoundary = _bullet;
		}
		
		public function BeginFiring():void
		{
			this.isFiring = true;
		}  
		
		public function EndFiring():void
		{
			this.isFiring = false;
		}
		
		public function LoadGameData( data:GameDataTracker )
		{
			gameData = data;
		}
		
		// Movement functions for updating the direction of the ship's movement.
		public function MoveNorth():void
		{
			velocity.Y = -1;
		}
		
		public function MoveSouth():void
		{
			velocity.Y = 1;
		}
		
		public function MoveEast():void
		{
			velocity.X = 1;
		}
		
		public function MoveWest():void
		{
			velocity.X = -1;
		}
		
		public function StopVertical():void
		{
			velocity.Y = 0;
		}
		
		public function StopHorizontal():void
		{
			velocity.X = 0;
		}
		
		public function CorrectVelocity():void
		{
			velocity.Normalize();
			velocity.Multiply( Speed );
		}
	}
}