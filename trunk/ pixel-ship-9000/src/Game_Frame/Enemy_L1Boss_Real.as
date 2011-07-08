package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.utils.Timer;
	
	import src.PhysVector2D;
	
	public class Enemy_L1Boss_Real extends Enemy_
	{
		var TopLeftPosition:Boolean;
		var blackImage:Asset_Enemy_L1Boss_Black = new Asset_Enemy_L1Boss_Black();
		var whiteImage:Asset_Enemy_L1Boss_White = new Asset_Enemy_L1Boss_White();
		var PhantomBoss:Enemy_L1Boss_Phantom = new Enemy_L1Boss_Phantom();
		
		// in absence of internal structures in AS3.0, I will be using a number
		//  to represent the state of the boss.
		var stateStep:Number;
		
		var MyTimer:Timer;
		
		public function Enemy_L1Boss_Real()
		{
			super();
			_CurrentClass = Enemy_L1Boss_Real;
			fullHealth = 20;
			PrimaryWeapon = new Shot_Enemy_L1Boss_Real();
			ResetHealth();
			addEventListener( Event.ADDED, LoadPhantom );
			stateStep = 0;
			speed = 0.5;
			scrapAmount = 25;
			invulnerable = true;
		}
		
		private function LoadPhantom( e:Event ):void
		{
			removeEventListener( Event.ADDED, LoadPhantom );
			PhantomBoss.Initialize();
			PhantomBoss.LoadBoundary( Boundary, WeaponBoundary );
			PhantomBoss.LoadPlayerReference( ShipReference );
			parent.addChild( PhantomBoss );
			parent.addChildAt( this, parent.getChildIndex( ShipReference ) + 1);
			parent.addChildAt( PhantomBoss, parent.getChildIndex( ShipReference ) + 1);
			
			RestartPlay();
		}
		
		public function DecideWhichSpawnPoint():void
		{
			if( Math.random() <= 0.5 )
			{
				x = 125; 
				y = -125;
				
				TopLeftPosition = true;
				
				velocity.Equal( PhysVector2D.DOWN );
				PhantomBoss.setVelocity = PhysVector2D.UP;
				
				PhantomBoss.x = 375;
				PhantomBoss.y = 650;
			}
			else
			{
				x = 375;
				y = 650;
				
				TopLeftPosition = false;
				
				velocity.Equal( PhysVector2D.UP );
				PhantomBoss.setVelocity = PhysVector2D.DOWN;
				
				PhantomBoss.x = 125;
				PhantomBoss.y = -125;
			}
		}
		
		public function DecideWhichSpawnImage()
		{
			blackImage = new Asset_Enemy_L1Boss_Black();
			whiteImage = new Asset_Enemy_L1Boss_White();
			while( numChildren > 0 )
			{
				removeChildAt( 0 );
			}
			
			while( PhantomBoss.numChildren > 0 )
			{
				PhantomBoss.removeChildAt( 0 );
			}
			
			if( Math.random() <= 0.5 )
			{
				addChild( blackImage.getChildAt(0) );
				PhantomBoss.addChild( whiteImage.getChildAt(0) );
			}
			else
			{
				addChild( whiteImage.getChildAt(0) );
				PhantomBoss.addChild( blackImage.getChildAt(0) );
			}
		}
		
		public function DecideWhichDirectionToMove()
		{
			stateStep = 3;
			if( Math.random() <= 0.5 )
			{
				if( TopLeftPosition )
				{
					velocity.Equal(PhysVector2D.DOWN);
					PhantomBoss.setVelocity = PhysVector2D.UP;
				}
				else
				{
					velocity.Equal(PhysVector2D.UP);
					PhantomBoss.setVelocity = PhysVector2D.DOWN;
				}
			}
			else
			{
				if( TopLeftPosition )
				{
					velocity.Equal(PhysVector2D.RIGHT);
					PhantomBoss.setVelocity = PhysVector2D.LEFT;
				}
				else
				{
					velocity.Equal(PhysVector2D.LEFT);
					PhantomBoss.setVelocity = PhysVector2D.RIGHT;
				}
			}
		}
 
		public function MakePhantomBlink():void
		{
			PhantomBoss.visible = false;
			if(MyTimer == null )
			{
				MyTimer = new Timer(100, 1);
				MyTimer.addEventListener(TimerEvent.TIMER, daBlink );
				MyTimer.start();
			}
		}
		
		public function daBlink( tick:TimerEvent ):void
		{
			this.PhantomBoss.visible = true;
			MyTimer.removeEventListener( TimerEvent.TIMER, daBlink );
			MyTimer.delay = 300;
			MyTimer.repeatCount = 1;
			MyTimer.addEventListener( TimerEvent.TIMER, Delay );
			MyTimer.reset();
			MyTimer.start();
			stateStep = 2;
		}
		
		public function WaitThenReset()
		{
			if( stage != null && ( x > width + stage.stageWidth || y > height + stage.stageHeight ) )
			{
				RestartPlay();
				PhantomBoss.Hidden = true;
			}
		}
		
		public function Delay( tick:TimerEvent ):void
		{
			// just a blank funciton for holding up the logic of timers.
			MyTimer = null;
		}
		
		public override function Update(tick:Event):void
		{
			super.Update( tick );
			// state steps are as follows.
			// 0: Starting state, includes movement to initial spots
			// 1: Warning state, when phantom will display somehow that its fake
			// 2: Movement state, the bosses begin moving in one of two directions
			// 		this state begins with the movement followed by a quick fire
			// 3: Reset state, rinse and repeat.
		
			if( stateStep == 0 )
			{
				if( TopLeftPosition && this.y > 130 )
				{
					velocity.Equal( PhysVector2D.ZERO );
					PhantomBoss.setVelocity = PhysVector2D.ZERO;
					stateStep = 1;
				}
				else if( !TopLeftPosition && PhantomBoss.y > 130 )
				{
					velocity.Equal( PhysVector2D.ZERO );
					PhantomBoss.setVelocity = PhysVector2D.ZERO;
					
					stateStep = 1;
				}
			}
			else if( stateStep == 1 )
			{
				MakePhantomBlink();
				PhantomBoss.Hidden = false;
				invulnerable = false;
			}
			else if( stateStep == 2 && MyTimer == null )
			{
				DecideWhichDirectionToMove();
				FireDirection.Equal( velocity );
				super.DoCombatChecks();
				PhantomBoss.doCombatCheck();
			}
			else if( stateStep == 3 )
			{
				WaitThenReset();
			}
		}
		
		protected function RestartPlay():void
		{
			stateStep = 0;
			invulnerable = true;
			DecideWhichSpawnImage();
			DecideWhichSpawnPoint();
		}
		
		protected override function DoMoveChecks():void
		{
			super.DoMoveChecks();
			PhantomBoss.doMoveChecks();
		}
		
		public override function Explode():void
		{
			super.Explode();
			PhantomBoss.Explode();
		}
			
		/**
		 * this version of 
		 * */
		protected override function DoBoundaryChecks():void
		{
			
		}
		
		protected override function DoCombatChecks():void
		{
		}
	}
}