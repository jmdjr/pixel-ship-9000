package src.Game_Frame
{
	import fl.motion.Color;
	import fl.motion.ColorMatrix;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.sensors.Accelerometer;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import src.GameDataTracker;
	import src.Game_Frame.Summary_Frame.StatFrameBG;
	import src.JukeBox;
	import src.PhysVector2D;
	import src.Ship;

	public class Level extends Sprite
	{
		protected var Time:Number;
		protected var BossMode:Boolean;
		protected var BossReference:EnemyObject;
		protected var factory:EnemyFactory;
		protected var myShip:Ship;
		public var LevelTitle:String;
		protected var isComplete:Boolean;
		protected var InternalFrame:Sprite;
		protected var gameData:GameDataTracker;
		
		public function Level()
		{
			Time = 0;
			BossMode = false;
			isComplete = false;
			myShip = null;
			factory = null;
			BossReference = null;
			LevelTitle = "Level 1";
			InternalFrame = new Sprite();
		}
		
		public function get IsComplete():Boolean
		{
			return isComplete;
		}
		
		public function AddFactory( _f:EnemyFactory ):void
		{
			factory = _f;
		}
		
		public function AddShip( _s:Ship ):void
		{
			myShip = _s;
		}
		
		public function Reset():void
		{ 
			Time = 0;
			BossMode = false;
			isComplete = false;
		}
		
		private function DisplayLevelHint():void  
		{
			if( parent != null )
			{
				if( !parent.contains( InternalFrame ) )
				{
					parent.addChild( InternalFrame );
				}
				
				var bg:StatFrameBG = StatFrameBG( InternalFrame.addChild( new StatFrameBG() ) );
				bg.x = stage.stageWidth / 2;
				bg.y = stage.stageHeight / 2; 
				
				var Title:TextField = TextField( InternalFrame.addChild( new TextField() ) );
				
				var mini:TextFormat = new TextFormat( "BM mini", 24, new Color( 0.5, 1.0, 0.5 ) );
				Title.width = bg.width;
				Title.wordWrap = true;
				
				Title.defaultTextFormat = mini;
				Title.text = this.LevelTitle;
	 			
				Title.x = bg.x - bg.width/2 + 50;
				Title.y = bg.y - bg.height/2 + 20;
			}
		}
		
		private function RemoveLevelHint():void
		{
			if( parent != null && parent.contains( InternalFrame ) )
			{
				while( InternalFrame.numChildren > 0 )
				{
					InternalFrame.removeChildAt( 0 );
				}
				
				parent.removeChild( InternalFrame );
			}
		}
		
		
		public function Update( tick:Event ):void
		{
			if( !BossMode )
			{
				++Time;
			}
			
			if( Time == 1 )
			{
				DisplayLevelHint();
				gameData.JB.Play( JukeBox.BOSS_MUSIC );
			}
			
			if ( Time == 3 * stage.frameRate )
			{
				gameData.JB.Play( JukeBox.GAME_MUSIC );
				RemoveLevelHint();
			}
			//e1
			if( Time == 5 * stage.frameRate ) 

			{ 
				parent.addChild( this.factory.Spawn( "Drone", 350, 499, new PhysVector2D( 0, -1 ), this.myShip ) );

			}
			//e2 e3
			if( Time == 10 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			//e4 e5 e6
			if( Time == 15 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 350, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			//e7
			if( Time == 20 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 0, 300, new PhysVector2D( 1, 0 ), this.myShip ) );
			}
			//e8
			if( Time == 22 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 499, 400, new PhysVector2D( -1, 0 ), this.myShip ) );
			}
			//e11 
			if( Time == 25 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			//e10 e12
			if( Time == 26 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 200, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 300, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			//e9 e13
			if( Time == 27 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			//e14
			if( Time == 30 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Jav", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			//e15 e16
			if( Time == 35 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 350, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			//e17
			if( Time == 40 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Jav", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			//e18 e19
			if( Time == 45 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 0, 200, new PhysVector2D( 1, 0 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 499, 300, new PhysVector2D( -1, 0 ), this.myShip ) );
			}
			//e20
			if( Time == 50 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Jav", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			//e21 e22
			if( Time == 55 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 200, 499, new PhysVector2D( 0,-1 ), this.myShip ) );
				
			}
			//e23
			if( Time == 57 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Jav", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			//e24 Mid Boss 1
			if( Time == 60 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
			if( Time == 62 * stage.frameRate )
			{
				if( !BossMode )
				{
					BossReference = EnemyObject( parent.addChild( factory.Spawn( "MidBoss", 250, 250, new PhysVector2D( 1, -1 ), myShip ) ) );
					BossReference.LoadBoundary( myShip.Boundary );
				}
				
				BossMode = true;
				if( BossReference != null && BossReference.IsDead )
				{
					BossReference = null;
					BossMode = false;
				}
			}
			
			// e26 e29
			if( Time == 65 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 100, 499, new PhysVector2D( 0, -1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			//e25 e27 e28 30
			if( Time == 66 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 50, 499, new PhysVector2D( 0, -1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 150, 499, new PhysVector2D( 0, -1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 450,0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 350,0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
			//e31 e32 e33 e 34 e35 e36
			if( Time == 70 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 0, 250, new PhysVector2D( 1, 0 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 0, 350, new PhysVector2D( 1, 0 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 499, 200, new PhysVector2D( -1, 0 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 499, 300, new PhysVector2D( -1, 0 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Jav", 200, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Jav",300, 499, new PhysVector2D( 0, -1 ), this.myShip ) );
			}
			// e35.1
			if( Time == 75 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Jav", 0, 250, new PhysVector2D( 1, 0 ), this.myShip ) );
				
			}
			//e36.1
			if( Time == 80 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			//e37 e38 e39 e40 e41 e42 e43
			if( Time == 85 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 450, 499, new PhysVector2D( 0, -1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 350, 499, new PhysVector2D( 0, -1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 250, 499, new PhysVector2D( 0, -1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 150, 499, new PhysVector2D( 0, -1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 50, 499, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Jav", 0, 50, new PhysVector2D( 1, 0 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Jav", 250, 0, new PhysVector2D( -1, 0 ), this.myShip ) );
			}
			//e44 e45 e46
			if( Time == 90 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 250, 0, new PhysVector2D(1,0 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 499, 250, new PhysVector2D( -1,0 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Bomb", 350, 350, new PhysVector2D( 0, 0 ), this.myShip ) );
			}
			//e47 e48 e49
			if( Time == 95 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 200, 0, new PhysVector2D(0,1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 300,499, new PhysVector2D( 0,-1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Bomb", 350, 350, new PhysVector2D( 0, 0 ), this.myShip ) );
			}
			//e51 e53 e54
			if( Time == 100 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 250, 499, new PhysVector2D(0,-1), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Jav", 150, 0, new PhysVector2D( 0,1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Jav", 350, 0, new PhysVector2D( 0,1 ), this.myShip ) );
			}
			//e50 e52
			if( Time == 103 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 50, 0, new PhysVector2D(0,1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 450,0, new PhysVector2D( 0,1 ), this.myShip ) );
			}
			//e55 e56 e57
			if( Time == 105 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Bomb", 250, 400, new PhysVector2D(0,0), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Bomb", 150, 100, new PhysVector2D( 0,0 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Bomb", 350, 100, new PhysVector2D( 0, 0 ), this.myShip ) );
			}
			//e58 e59 
			if( Time == 110 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Jav", 250, 0, new PhysVector2D(0,1), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Jav", 499, 250, new PhysVector2D( -1,0 ), this.myShip ) );
			}
			//e60 e61 e62 e63 e64
			if( Time == 115 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 50, 499, new PhysVector2D(0,-1), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 150, 499, new PhysVector2D( 0,-1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 250, 499, new PhysVector2D( 0,-1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 350, 499, new PhysVector2D( 0,-1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 450, 499, new PhysVector2D( 0,-1 ), this.myShip ) );
			}
			//e69 
			if( Time == 120 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Jav", 499, 250, new PhysVector2D(-1,0), this.myShip ) );
				
			}
			//e70
			if( Time == 121 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Jav", 350, 499, new PhysVector2D(0,-1), this.myShip ) );
				
			}
			//e72 e75 
			if( Time == 122 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 250, 0, new PhysVector2D(0,1), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Drone", 0, 250, new PhysVector2D(1,0), this.myShip ) );
				
			}
			//e65 e66 e67 e68
			if( Time == 123 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Bomb", 100, 150, new PhysVector2D(0,0), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Bomb", 400, 150, new PhysVector2D(0,0), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Bomb", 100, 400, new PhysVector2D(0,0), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Bomb", 400, 400, new PhysVector2D(0,0), this.myShip ) );
				
			}
			
			
			//e71 e73 e74 e76 124
			if( Time == 124* stage.frameRate )
			{
					
					parent.addChild( factory.Spawn( "Drone", 200, 0, PhysVector2D.DOWN, myShip ) );
					parent.addChild( factory.Spawn( "Drone", 300, 0, PhysVector2D.DOWN, myShip ) );
					parent.addChild( factory.Spawn( "Drone", 0, 200, PhysVector2D.RIGHT, myShip ) );
					parent.addChild( factory.Spawn( "Drone", 0, 300, PhysVector2D.RIGHT, myShip ) );
				}
			if( Time == 132* stage.frameRate )
			{
				
				if( !BossMode )
				{
					BossReference = EnemyObject( parent.addChild( factory.Spawn( "BigBoss", 250, 100, new PhysVector2D( 1, -1 ), myShip ) ) );
					BossReference.LoadBoundary( myShip.Boundary );
					
				}
				
				BossMode = true;
				if( BossReference != null && BossReference.IsDead )
				{
					BossReference = null;
					BossMode = false;
				}
			}
			
			if( Time >= 150 * stage.frameRate && !BossMode )
			{
				isComplete = true;
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
		public function LoadGameData( data:GameDataTracker )
		{
			gameData = data;
		}
	}
}