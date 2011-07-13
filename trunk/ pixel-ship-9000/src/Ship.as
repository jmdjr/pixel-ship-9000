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
		
		var _UP:Boolean;
		var _RIGHT:Boolean;
		var _DOWN:Boolean;
		var _LEFT:Boolean;
		
		var _FireUP:Boolean;
		var _FireRIGHT:Boolean;
		var _FireDOWN:Boolean;
		var _FireLEFT:Boolean;
		
		//private var ModAttack:Number;
		private var ModSpeed:Number; 
		private var ModDefense:Number;
		private var ModHealth:Number;
		private var MG:PixelMod_Grid_;
		
		public override function ResetHealth():void
		{
			super.ResetHealth();
			visible = true;
		}
		
		public function Ship()
		{
			super();
			
			velocity = new PhysVector2D();
			PrimaryWeapon = new Shot_Player_Missile();
			
			fullHealth = 1000;
			ModDefense = 0;
			//ModAttack = 0;
			ShipSpeed = 3;
			FireTimer = 1;
			FireRate = 1;
			ModSpeed = 0;
			Defense = 0;
			
			isFiring = false;
			canFire = false;
			Boundary = null;
			WeaponBoundary = null;
			Attack = fullHealth;
			ResetHealth();
			
			// for moving in a direction.
			_UP = false;
			_RIGHT = false;
			_DOWN = false;
			_LEFT = false;
			
			// for firing in a direction.
			_FireUP = true;
			_FireRIGHT = true;
			_FireDOWN = true;
			_FireLEFT = true;
		}
		
		/**
		 * Calculates the mod values from the ModGrid and assigns those values to the 
		 * Ship.  All AttackMods will be set to fire in any direction not covered by
		 * Any other Mod.
		 */
		public function RecalcModGrid():void
		{
			this.ModHealth = MG.CalcModHealth();
			this.ModDefense = MG.CalcModDefense();
			this.ModSpeed = MG.CalcModSpeed();
			
			MG.CalcModAttack();
		}
		
		protected override function DoMoveChecks():void
		{
			velocity.X = 0;
			velocity.Y = 0;
			
			if( _DOWN )
			{
				velocity.Y = 1;
			}
			else if( _UP )
			{
				velocity.Y = -1;
			}
			
			if( _LEFT )
			{
				velocity.X = -1;
			}
			else if( _RIGHT )
			{
				velocity.X = 1;
			}
			
			super.DoMoveChecks();
		}
		
		protected override function DoCombatChecks():void
		{	
			if( isFiring && canFire && parent != null && PrimaryWeapon != null )
			{
				var bullet:Shot_;
				if( _FireUP )
				{
					bullet = Shot_( parent.addChild( 
							PrimaryWeapon.Spawn( x, y, PhysVector2D.UP ) ) );
					bullet.LoadBoundary( WeaponBoundary );
					gameData.FireShot();
				}
				
				if( _FireDOWN )
				{
					bullet = Shot_( parent.addChild( 
						PrimaryWeapon.Spawn( x, y, PhysVector2D.DOWN ) ) );
					bullet.LoadBoundary( WeaponBoundary );
					gameData.FireShot();
				}
				
				if( _FireLEFT )
				{
					bullet = Shot_( parent.addChild( 
						PrimaryWeapon.Spawn( x, y, PhysVector2D.LEFT ) ) );
					bullet.LoadBoundary( WeaponBoundary );
					gameData.FireShot();
				}
				
				if( _FireRIGHT )
				{
					bullet = Shot_( parent.addChild( 
						PrimaryWeapon.Spawn( x, y, PhysVector2D.RIGHT ) ) );
					bullet.LoadBoundary( WeaponBoundary );
					gameData.FireShot();
				}
				
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
		
		public function LoadGameData( data:GameDataTracker )
		{
			gameData = data;
		}
		
		protected override function get Attack():Number
		{
			return /*ModAttack + */attack;
		}
		
		protected override function get Defense():Number
		{
			return ModDefense + defense;
		}
		
		protected override function get Speed():Number
		{
			return ModSpeed + speed;
		}
		
		public function BeginFiring():void
		{
			this.isFiring = true;
		}  
		
		public function EndFiring():void
		{
			this.isFiring = false;
		}
		
		// Movement functions for updating the direction of the ship's movement.
		public function MoveUP():void
		{
			_UP = true;
		}
		
		public function MoveDown():void
		{
			_DOWN = true;
		}
		
		public function MoveRight():void
		{
			_RIGHT = true;
		}
		
		public function MoveLeft():void
		{
			_LEFT = true;
		}
		
		public function StopUP():void
		{
			_UP = false;
		}
		
		public function StopDown():void
		{
			_DOWN = false;
		}
		
		public function StopRight():void
		{
			_RIGHT = false;
		}
		
		public function StopLeft():void
		{
			_LEFT = false;
		}
	}
}