package src
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import src.Customize_Frame.PixelMod_Grid_;
	import src.Game_Frame.ShipObject;
	import src.Game_Frame.Shot_;
	import src.Game_Frame.Shot_Player_Missile;
	import src.PhysVector2D;
	
	public class Ship extends ShipObject
	{
		private var isFiring:Boolean;
		var gameData:GameDataTracker;
		var canFire:Boolean;
		
		private var ModAttack:Number;
		private var ModSpeed:Number;
		private var ModDefense:Number;
		private var MG:PixelMod_Grid_;
		
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
			PrimaryWeapon = new Shot_Player_Missile();
			fullHealth = 1000;
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
		
		/**
		 * Calculates the mod values from the ModGrid and assigns those values to the 
		 * Ship.  All AttackMods will be set to fire in any direction not covered by
		 * Any other Mod.
		 */
		public function RecalcModGrid():void
		{}
		
		public override function Update( tick:Event ):void
		{
			super.Update( tick );
		}
		
		protected override function DoCombatChecks():void
		{	
			if( isFiring && canFire && parent != null && PrimaryWeapon != null )
			{
				var bullet:Shot_;
				bullet = Shot_( parent.addChild( 
						PrimaryWeapon.Spawn( x, y, PhysVector2D.UP ) ) );
				bullet.LoadBoundary( WeaponBoundary );
				gameData.FireShot();
				
				bullet = Shot_( parent.addChild( 
					PrimaryWeapon.Spawn( x, y, PhysVector2D.DOWN ) ) );
				bullet.LoadBoundary( WeaponBoundary );
				gameData.FireShot();
				
				bullet = Shot_( parent.addChild( 
					PrimaryWeapon.Spawn( x, y, PhysVector2D.LEFT ) ) );
				bullet.LoadBoundary( WeaponBoundary );
				gameData.FireShot();
				
				bullet = Shot_( parent.addChild( 
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
		
		public override function Disappear():void
		{
			removeEventListener( Event.ENTER_FRAME, Update );
			this.visible = false;
		}
		
		public function CorrectVelocity():void
		{
			velocity.Normalize();
			velocity.Multiply( Speed );
		}
	}
}