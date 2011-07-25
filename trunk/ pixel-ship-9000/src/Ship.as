package src
{
	import Juke_Box.JukeBox;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import src.Customize_Frame.ModPixel_;
	import src.Customize_Frame.ModPixel_Attack;
	import src.Customize_Frame.ModPixel_Speed;
	import src.Customize_Frame.PixelMod_Grid_;
	import src.Game_Frame.ShipObject;
	import src.Game_Frame.Shot_;
	import src.Game_Frame.Shot_Player_Missile;
	import src.PhysVector2D;
	
	public class Ship extends ShipObject
	{
		private var isFiring:Boolean;
		private var gameData:GameDataTracker;
		private var canFire:Boolean;
		
		private var _UP:Boolean;
		private var _RIGHT:Boolean;
		private var _DOWN:Boolean;
		private var _LEFT:Boolean;
		
		private var _FireUP:Boolean;
		private var _FireRIGHT:Boolean;
		private var _FireDOWN:Boolean;
		private var _FireLEFT:Boolean;
		
		private var ModAttack:Number;
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
			MG = new PixelMod_Grid_();
			FullHealth = 1;
			ModDefense = 0;
			ModAttack = 0;
			ModSpeed = 0;
			ShipSpeed = 1;
			FireTimer = 1;
			FireRate = 1;
			
			Defense = 0;
			
			isFiring = false;
			canFire = false;
			Boundary = null;
			WeaponBoundary = null;
			ResetHealth();
			
			// for moving in a direction.
			_UP = false;
			_RIGHT = false;
			_DOWN = false;
			_LEFT = false;
			
			// for firing in a direction.
			_FireUP = false;
			_FireRIGHT = false;
			_FireDOWN = false;
			_FireLEFT = false;
			
			RecalcModGrid();
		}
		
		
		/**
		 * Calculates the mod values from the ModGrid and assigns those values to the 
		 * Ship.  All AttackMods will be set to fire in any direction not covered by
		 * Any other Mod.
		 */
		public function RecalcModGrid():void
		{
			ModHealth = MG.CalcModHealth();
			ModDefense = MG.CalcModDefense();
			ModSpeed = MG.CalcModSpeed();
			ModAttack = MG.CalcModAttack();
			
			MG.CalibrateModAttack();
			MG.DrawModPixelsOnShip( this );
			
			_FireUP = MG.CheckModAt( 0, 1 ) == null;
			_FireDOWN = MG.CheckModAt( 2, 1 ) == null;
			_FireLEFT = MG.CheckModAt( 1, 0 ) == null;
			_FireRIGHT = MG.CheckModAt( 1, 2 ) == null;
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
				
				if( _FireRIGHT || _FireLEFT || _FireDOWN || _FireUP )
				{
					JukeBox.PlaySE( JukeBox.ATTACK1_SE );
				}
				
				MG.FireOffAttackMods( gameData, this );
				
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
				var ShipTop:int = y;
				var ShipBottom:int = y + height;
				var ShipLeft:int = x;
				var ShipRight:int = x + width;
				
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
			return health / FullHealth;
		}
		
		protected override function get FullHealth():Number
		{
			return fullHealth + ModHealth;
		}
		
		public function LoadBoundary( _bound:Rectangle, _bullet:Rectangle ):void
		{
			this.Boundary = _bound;
			this.WeaponBoundary = _bullet;
			
			RecalcModGrid();
		}
		
		public function AddModPixel( mod:ModPixel_, r:Number, c:Number ):void
		{
			if( mod is ModPixel_Attack )
			{
				ModPixel_Attack(mod).LoadBoundary( WeaponBoundary );
			}
			
			MG.AddModPixel( mod, r, c );
		}
		
		public function RemoveAllMods():void
		{
			MG.DeleteAllMods( this );
		}
		
		public function ReportPixelModAt( r:Number, c:Number ):ModPixel_
		{
			return MG.CheckModAt( r, c );
		}
		
		public function LoadGameData( data:GameDataTracker ):void
		{
			gameData = data;
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
		
		public function ReportAttackMods():Number
		{
			return this.MG.CalcModAttack();
		}
		
		public function ReportDefenseMods():Number
		{
			return this.MG.CalcModDefense();
		}
		
		public function ReportSpeedMods():Number
		{
			return this.MG.CalcModSpeed();
		}
		
		public function get ReportAttackStat():Number
		{
			return this.Attack;
		}
		
		public function get ReportSpeedStat():Number
		{
			return this.Speed;
		}
		
		public function get ReportDefenseStat():Number
		{
			return this.Defense
		}
		
		public function get ReportHealthStat():Number
		{
			return this.FullHealth;
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