package src.Game_Frame
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import src.Credits_Frame._Frame_Credits;
	import src.PhysVector2D;
	
	public class Enemy_Boss_Hull extends Enemy_
	{
		protected var startingPos:Point;
		protected var endingPos:Point;
		protected var toStartDirection:PhysVector2D;
		protected var toEndDirection:PhysVector2D;
		
		protected var weapon_pos:int;
		protected var weapon_cycleClock:int;
		protected var weapon_cycleTime:int;
		protected var weapon_list:Array;
		
		public function Enemy_Boss_Hull()
		{
			super();
			this._CurrentClass = Enemy_Boss_Hull;
			
			this.FullHealth = 100;
			this.ResetHealth();
			
			this.FireRate = 2;
			this.Speed = 0.5;
			this.startingPos = new Point(150, 100);
			this.endingPos = new Point(350, 100);
			this.toStartDirection = new PhysVector2D( this.startingPos.x - this.endingPos.x, this.startingPos.y - this.endingPos.y);
			this.toEndDirection = new PhysVector2D( this.endingPos.x - this.startingPos.x, this.endingPos.y - this.startingPos.y);
			
			this.weapon_pos = 0;
			this.weapon_cycleClock = 0;
			this.weapon_cycleTime = 10;
			 
			this.weapon_list  = new Array(); 
			this.weapon_list[0] = new Shot_Enemy_Missile();
			(this.weapon_list[0] as Shot_Enemy_Missile).Damage = 1; 
			(this.weapon_list[0] as Shot_Enemy_Missile).Speed = 1;
				
			this.weapon_list[1] = new Shot_Enemy_Beam();
			(this.weapon_list[1] as Shot_Enemy_Beam).Damage = 10;
			(this.weapon_list[1] as Shot_Enemy_Beam).Speed = 0.1;
			
			this.weapon_list[2] = new Shot_Boss_Homing();
			(this.weapon_list[2] as Shot_Boss_Homing).Damage = 1;
			(this.weapon_list[2] as Shot_Boss_Homing).Speed = 1;
			
			this.weapon_list[3] = new Shot_Enemy_Bee();
			(this.weapon_list[3] as Shot_Enemy_Bee).Damage = 1;
			(this.weapon_list[3] as Shot_Enemy_Bee).Speed = 1;
			
			this.PrimaryWeapon = this.weapon_list[this.weapon_pos];
		}
		
		protected function isPastEndPosition():Boolean
		{
			var pastX:Boolean, pastY:Boolean;
			
			pastX = false;
			pastY = false;
			
			if(this.Velocity.X > 0)
			{
				pastX = this.x > this.endingPos.x;
			}
			else if(this.Velocity.X < 0)
			{
				pastX = this.x < this.endingPos.x;
			}
			
			if(this.Velocity.Y > 0)
			{
				pastY = this.y > this.endingPos.y;
			}
			else if(this.Velocity.Y < 0)
			{
				pastY = this.y < this.endingPos.y;
			}
			
			return pastX || pastY;
		}
		
		protected function isPastStartPosition():Boolean
		{			
			var pastX:Boolean, pastY:Boolean;
			
			pastX = false;
			pastY = false;
			 
			if(this.Velocity.X > 0)
			{
				pastX = this.x > this.startingPos.x;
			}
			else if(this.Velocity.X < 0)
			{
				pastX = this.x < this.startingPos.x;
			}
			
			if(this.Velocity.Y > 0)
			{
				pastY = this.y > this.startingPos.y;
			}
			else if(this.Velocity.Y < 0)
			{
				pastY = this.y < this.startingPos.y;
			}
			
			return pastX || pastY;
		}
		
		protected function cycleWeapon():void
		{
			this.weapon_pos += 1;
			
			if( this.weapon_pos >= this.weapon_list.length )
			{
				this.weapon_pos = 0;
			}
			
			this.PrimaryWeapon = this.weapon_list[this.weapon_pos];
		}
		
		protected override function DoMoveChecks():void
		{
			super.DoMoveChecks();
			if( this.isPastStartPosition() )
			{
				this.Velocity = this.toEndDirection;
			}
			
			if( this.isPastEndPosition() )
			{
				this.Velocity = this.toStartDirection;
			}
		}
		
		protected override function DoCombatChecks():void
		{
			if( FireTimer % ( stage.frameRate / FireRate ) == 0 )
			{
				this.FireDirection.Equal( PhysVector2D.DOWN );
				super.DoCombatChecks();
				
				this.FireDirection.Equal( PhysVector2D.LEFT );
				super.DoCombatChecks();
				
				this.FireDirection.Equal( PhysVector2D.RIGHT );
				super.DoCombatChecks();
				
				this.FireDirection.Equal( new PhysVector2D( -1, -1 ) );
				super.DoCombatChecks();
				 
				this.FireDirection.Equal( new PhysVector2D( 1, -1 ) );
				super.DoCombatChecks();
			}
			
			if( this.weapon_cycleClock % this.weapon_cycleTime*stage.frameRate == 0 )
			{
				this.cycleWeapon();
			}
			
			this.weapon_cycleClock += 1;
		}
		
		protected override function DoBoundaryChecks():void
		{
			
		}
		
		public override function Spawn(_x:Number, _y:Number, _v:PhysVector2D):Enemy_
		{
			var spawn:Enemy_ = super.Spawn( this.startingPos.x, this.startingPos.y, this.toEndDirection);
			spawn.rotation = 0;
			return spawn;
		}
	}
}