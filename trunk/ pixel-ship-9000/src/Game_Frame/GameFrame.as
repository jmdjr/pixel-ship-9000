package src.Game_Frame
{
	import BulletDance.mp3;
	
	import UnfriendlyRave.mp3;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	
	import src.Background;
	import src.GameDataTracker;
	import src.PhysVector2D;
	import src.Ship;

	/**
	 * GameFrame Object
	 *  Designed to contain all objects used with the game logic.
	 * 
	 * @author John M Davis Jr
	 * 
	 */
	public class GameFrame extends MovieClip
	{
		var gameData:GameDataTracker;
		var timeTracker:Number;
		var shipHealthBar:ShipHealthMeterDisplay;
		
		var SpaceBG:Background;
		var ship:Ship;
		
		var level1:Level;
		var Factory:EnemyFactory;
		
		var IsPlaying:Boolean;
		var WorldMusic:Sound;
		var WorldChannel:SoundChannel;
		
		var fps:FrameRate;
		
		public function GameFrame()
		{
			IsPlaying = false;
			
			WorldMusic = new BulletDance.mp3();
			SpaceBG = new Background();
			ship = new Ship();
			shipHealthBar = new ShipHealthMeterDisplay();
			fps = new FrameRate();
			level1 = new Level();
			Factory = new EnemyFactory();
			addEventListener( Event.ADDED_TO_STAGE, Loaded );
		}
		
		public function Loaded( e:Event ):void
		{ 
			var enemyBound:Rectangle = new Rectangle( -100, -100, stage.stageWidth + 100, stage.stageHeight + 100 );
			var shipBound:Rectangle = new Rectangle( 50, 50, stage.stageWidth - 50, stage.stageHeight - 50 );
			
			ship.LoadBoundary( shipBound, enemyBound );
			Factory.LoadBoundary( enemyBound, enemyBound );
			
			level1.AddFactory( Factory );
			level1.AddShip( ship );
			
			ship.LoadGameData( gameData );
			ResetFrame();
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, KeyPressed );
			stage.addEventListener( KeyboardEvent.KEY_UP, KeyReleased );
			addEventListener( Event.ENTER_FRAME, Update );
			addChild( level1 );
		}
		
		/**
		 * LoadGameData( data )
		 *   loads the base game data that is used between frames
		 * Parameters:
		 *   data - the basic game data reference
		 * 
		 *  @author John M Davis Jr.
		 */
		public function LoadGameData( data:GameDataTracker )
		{
			gameData = data;
		}
		
		/**
		 * ResetFrame():void
		 *   Used to reset all of the elements within the frame to a starting state.
		 * 
		 */
		public function ResetFrame():void
		{
			timeTracker = 0;
			with( SpaceBG )
			{
				width = this.stage.stageWidth;
				startY = this.stage.stageHeight;
				x = width / 2;
				y = startY; 
				scrollRate = 10;
			}
		
			if( !contains( SpaceBG ) )
			{
				addChild( SpaceBG );
			}
			
			with( fps )
			{
				fps.x = 500;
				fps.y = 100;
			}
			
			if( !contains( fps ) )
			{
				addChild( fps );
			}
			
			with( shipHealthBar )
			{ 
				rotation = -90;
				x = width / 2 + 5;
				y = height + 5;
			}
			
			if( !contains( shipHealthBar ) )
			{
				addChild( shipHealthBar );
			}
			
			
			level1.Reset();
			if( !contains( level1 ) )
			{
				addChild( level1 );
			}
			
			with( ship ) 
			{
				x = this.SpaceBG.width/2;
				y = this.stage.stageHeight/2;
				ResetHealth();
			}
			
			if( !contains( ship ) )
			{
				addChild( ship );
			}
		}
		
		/**
		 * Update( tick:Event ):void
		 * Update for all objects used within the Game Frame. This is where the game logic will be executed.
		 *   Parameters:
		 *      tick - the event object handling event communication used incase the function is added to the event structure.
		 *  @author John M Davis Jr. 
		 */  
		public function Update( tick:Event ):void
		{
			SpaceBG.Update( tick );
			if( enabled )
			{
				if( !IsPlaying )
				{
					ResetFrame();
					if( WorldChannel != null )
					{
						WorldChannel.stop();	
					}
					
					WorldChannel = new SoundChannel();
					WorldChannel = WorldMusic.play( 0, -1 );
					IsPlaying = true;
				}
				
				timeTracker += 1;
				
				shipHealthBar.ShowAPercentage( ship.HealthPercentage() );
				
				// updating Ship
				ship.Update( tick );
				level1.Update( tick );
				
				//**********************************************************************************************
				//*  Ship Boundry Case
				//**********************************************************************************************
				// restricting ship to spacebackground area and height of world - ~10
				// These act as the values determining whether or not to push the ship back into the boundries 
				// of the game environment.
				
				if( ship.HealthPercentage() <= 0 )
				{
					CleanUp();
					dispatchEvent( new Event( "GameOverFrame", true ) );
					WorldChannel.stop(); 
					WorldChannel = new SoundChannel();
					var tempMusic:Sound = new UnfriendlyRave.mp3();
					WorldChannel = tempMusic.play(0, 0);
					
				}
			}
		}
		
		public function CleanUp():void
		{
			timeTracker = 0;
			IsPlaying = false;
			while( numChildren > 0 )
			{
				removeChildAt(0);
			}	
		}
		
		public function KeyPressed( key:KeyboardEvent ):void
		{
			if( enabled )
			{
				switch( key.keyCode )
				{
					case Keyboard.UP:
						ship.MoveNorth();
						break;
					
					case Keyboard.DOWN:
						ship.MoveSouth();
						break;
					
					case Keyboard.LEFT:
						ship.MoveWest();
						break;
					
					case Keyboard.RIGHT:
						ship.MoveEast();
						break;
					
					case Keyboard.Z:
						ship.BeginFiring();
						break;
					
					case Keyboard.R:
						CleanUp();
						break;
					
					default:
						break;
				}
				
				ship.CorrectVelocity();
			}
		}
		
		public function KeyReleased( key:KeyboardEvent ):void
		{
			switch( key.keyCode )
			{
				case Keyboard.UP:
				case Keyboard.DOWN:
					ship.StopVertical();
					break;
				
				case Keyboard.LEFT:
				case Keyboard.RIGHT:
					ship.StopHorizontal();
					break;
				
				case Keyboard.Z:
					ship.EndFiring();
					break;
				
				default:
					break;
			}
			
			ship.CorrectVelocity();
		}
	}
}