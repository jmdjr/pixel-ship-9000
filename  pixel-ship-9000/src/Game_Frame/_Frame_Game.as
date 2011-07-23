package src.Game_Frame
{	
	import fl.motion.Color;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.engine.TextBlock;
	import flash.ui.Keyboard;
	
	import src.Background;
	import src.Frames;
	import src.GameDataTracker;
	import Juke_Box.JukeBox;
	import src.PhysVector2D;
	import src.Ship;

	/**
	 * GameFrame Object
	 *  Designed to contain all objects used with the game logic.
	 * 
	 * @author John M Davis Jr
	 * 
	 */
	public class _Frame_Game extends MovieClip
	{
		private var gameData:GameDataTracker;
		private var timeTracker:Number;
		private var shipHealthBar:Clip_HPMeter;
		private var shipHBText:TextField;
		private var shipPixelCount:TextField;
		
		private var SpaceBG:Background;
		private var ship:Ship;
		
		private var level1:Level;
		private var Factory:EnemyFactory;
		
		private var IsPlaying:Boolean;
		private var WorldMusic:Sound;
		private var WorldChannel:SoundChannel;
		
		private var paused:Boolean;
		private var pauseText:Asset_Text_Pause;
		
		private var fps:Clip_FrameRate;
		
		public function _Frame_Game()
		{
			IsPlaying = false;
			SpaceBG = new Background();
			shipHealthBar = new Clip_HPMeter();
			fps = new Clip_FrameRate();
			level1 = new Level();
			Factory = new EnemyFactory();
			addEventListener( Event.ADDED_TO_STAGE, Loaded );
			paused = false;
			pauseText = new Asset_Text_Pause();
			shipHBText = new TextField();
			shipPixelCount = new TextField();
		}
		
		public function Loaded( e:Event ):void
		{ 
			
			var enemyBound:Rectangle = new Rectangle( -100, -100, stage.stageWidth + 100, stage.stageHeight + 100 );
			var shipBound:Rectangle = new Rectangle( 50, 50, stage.stageWidth - 50, stage.stageHeight - 50 );
			
			
			Factory.LoadBoundary( enemyBound, enemyBound );
			
			level1.AddFactory( Factory );
			level1.AddShip( ship );
			level1.LoadGameData( gameData );
			ship.LoadBoundary( shipBound, enemyBound );
			ship.LoadGameData( gameData );
			ResetFrame();
			var textformat:TextFormat = new TextFormat( "BM mini", 16 );
			var textcolor:ColorTransform = new ColorTransform( 1, 1, 1, 1, 255 );
			
			shipHBText.defaultTextFormat = textformat;	
			shipHBText.transform.colorTransform = textcolor;
			
			shipPixelCount.defaultTextFormat = textformat;
			shipPixelCount.transform.colorTransform = textcolor;
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, KeyPressed );
			stage.addEventListener( KeyboardEvent.KEY_UP, KeyReleased );
			addEventListener( Event.ENTER_FRAME, Update );
			addChild( level1 );
		}
		
		public function LoadShipReference( sr:Ship ):void
		{
			ship = sr;
		}
		
		public function UpdateScrapText():void
		{
			with( shipPixelCount )
			{
				text = "Scrap: " + this.gameData.Scrap.toString();
				x = this.stage.stageWidth - ( shipHBText.x + textWidth );
				y = shipHBText.y;
			}
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
			
			with( fps )
			{
				fps.x = 500;
				fps.y = 100;
			}
			
			with( shipHBText )
			{
				text = "Health";
				x = 5;
				y = 5;
			}
			
			with( shipPixelCount )
			{
				text = "Scrap: " + this.gameData.Scrap.toString();
				x = this.stage.stageWidth - ( shipHBText.x + textWidth );
				y = shipHBText.y;
				
			}
			
			//shipPixelCount.defaultTextFormat.align;
			
			with( shipHealthBar )
			{ 
				rotation = -90;
				x = width / 2 + shipHBText.textWidth / 2;
				y = height + shipHBText.y + shipHBText.textHeight;
			}
			
			with( ship ) 
			{
				x = this.SpaceBG.width/2;
				y = this.stage.stageHeight/2;
				ResetHealth();
			}
			
			with( pauseText )
			{
				enabled = false;
				visible = false;
				x = this.stage.stageWidth / 2;
				y = this.stage.stageHeight / 2;
			}
			
			UpdateScrapText();
			level1.Reset();
			
			if( !contains( fps ) )
			{
				addChild( fps );
			}
			
			if( !contains( SpaceBG ) )
			{
				addChild( SpaceBG );
			}
			
			if( !contains( ship ) )
			{
				addChild( ship );
			}
			
			if( !contains( level1 ) )
			{
				addChild( level1 );
			}
			
			if( !contains( shipHBText ) )
			{
				addChild( shipHBText );
			}
			
			if( !contains( shipPixelCount ) )
			{
				addChild( shipPixelCount );
			}
			
			if( !contains( shipHealthBar ) )
			{
				addChild( shipHealthBar );
			}
			
			if( !contains( pauseText ))
			{
				addChild( pauseText );
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
			pauseText.enabled = paused;
			pauseText.visible = paused;
			
			if( enabled && !paused )
			{
				//Reset frame's base objects and tell game that this frame is playing stuff
				if( !IsPlaying )
				{
					ResetFrame(); 
					IsPlaying = true;
				}
				
				//**********************************************************************************************
				//*  Update calls for all base objects under this frame's control
				//**********************************************************************************************
				timeTracker += 1;
				dispatchEvent( new Event( ShipObject.MANAGED_UPDATE, true ) );
				
				SpaceBG.Update( tick );
				ship.Update( tick );
				level1.Update( tick );
				
				shipHealthBar.ShowAPercentage( ship.HealthPercentage() );
				UpdateScrapText();
				
				//***********************************************************************************************
				//*  UI shift to top of level
				//***********************************************************************************************
				
				if( getChildIndex( shipHealthBar ) < numChildren-1 )
				{
					setChildIndex( shipHealthBar, numChildren-1 ); 
				}
				
				if( getChildIndex( shipHBText ) < numChildren-1 )
				{
					setChildIndex( shipHBText, numChildren-1 );
				}
				
				if( getChildIndex( shipPixelCount ) < numChildren-1 )
				{
					setChildIndex( shipPixelCount, numChildren-1 );
				}
				
				//***********************************************************************************************
				//*  Cases for end of the game
				//***********************************************************************************************
				if( ship.HealthPercentage() <= 0 )
				{
					CleanUp();
					JukeBox.Stop(); 
					dispatchEvent( new Event( Frames.CUSTOM, true ) );
				}
				
				if( level1.IsComplete )
				{
					dispatchEvent(  new Event( Frames.TITLE, true ) );
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
						ship.MoveUP();
						break;
					
					case Keyboard.DOWN:
						ship.MoveDown();
						break;
					
					case Keyboard.LEFT:
						ship.MoveLeft();
						break;
					
					case Keyboard.RIGHT:
						ship.MoveRight();
						break;
					
					case Keyboard.Z:
						ship.BeginFiring();
						break;
					
					case Keyboard.R:
						//CleanUp();
						break;
					
					default:
						break;
				}
			}
		}
		
		public function KeyReleased( key:KeyboardEvent ):void
		{
			switch( key.keyCode )
			{
				case Keyboard.UP:
					ship.StopUP();
					break;
				
				case Keyboard.DOWN:
					ship.StopDown();
					break;
				
				case Keyboard.LEFT:
					ship.StopLeft();
					break;
				
				case Keyboard.RIGHT:
					ship.StopRight();
					break;
				
				case Keyboard.Z:
					ship.EndFiring();
					break;
				
				case Keyboard.P:
					paused = !paused;
					break;
					
				default:
					break;
			}
		}
		
		
		/**
		 * LoadGameData( data )
		 *   loads the base game data that is used between frames
		 * Parameters:
		 *   data - the basic game data reference
		 * 
		 *  @author John M Davis Jr.
		 */
		public function LoadGameData( data:GameDataTracker ):void
		{
			gameData = data;
		}
	}
}