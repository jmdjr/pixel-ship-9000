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
	import src.Game_Frame.Summary_Frame.Asset_Status_Level_BG;
	import Juke_Box.JukeBox;
	import src.PhysVector2D;
	import src.Ship;

	public class Level extends Sprite
	{
		protected var Time:Number;
		protected var BossMode:Boolean;
		protected var BossReference:Enemy_;
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

			
			// to bomb area of first level, uncomment following
			//Time = 84 * 60;
			
			// to skip to level two, uncomment the following line
			// Time = 199 * 60;
			// to skip to level three, uncomment the follonw line
			// Time = 299 * 60;

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
				
				var bg:Asset_Status_Level_BG = Asset_Status_Level_BG( InternalFrame.addChild( new Asset_Status_Level_BG() ) );
				bg.x = stage.stageWidth / 2;
				bg.y = stage.stageHeight / 2; 
				
				var Title:TextField = TextField( InternalFrame.addChild( new TextField() ) );
				
				var mini:TextFormat = new TextFormat( "BM mini", 24, new Color( 0.5, 1.0, 0.5 ) );

				Title.height = bg.height 
				Title.wordWrap = true;
				
				Title.defaultTextFormat = mini;
				Title.text = this.LevelTitle + "\n\n" + 
					"Move with the arrow keys, and fire with Z. \n" +
					"If you die, you get a chance to upgrade your ship!\n" + 
					"but you go back to the start of the level... :'(\n\n";
				/*+ 
					"The next game will be better, Promise!";*/
	 			
				Title.x = bg.x - bg.width/2 + 50;
				Title.y = bg.y - bg.height/2 + 20;
				Title.width = bg.width - Title.x;
				Title.height = bg.height - Title.y;
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
				JukeBox.Play( JukeBox.GAME_MUSIC );
				DisplayLevelHint();
			}
			
			if ( Time == 4 * stage.frameRate )
			{
				RemoveLevelHint();
			}
			
			
			//e1
			if( Time == 10 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Drone", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
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
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 0, 300, new PhysVector2D( 1, 0 ), this.myShip ) );
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
					BossReference = Enemy_( parent.addChild( factory.Spawn( "MidBoss", 250, 250, new PhysVector2D( 1, -1 ), myShip ) ) );
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
			if( Time == 128 * stage.frameRate )
			{
				
				if( !BossMode )
				{
					BossReference = Enemy_( parent.addChild( factory.Spawn( "BigBoss", 250, 100, new PhysVector2D( 1, -1 ), myShip ) ) );
					BossReference.LoadBoundary( myShip.Boundary );
					
				}
				
				BossMode = true;
				if( BossReference != null && BossReference.IsDead )
				{
					BossReference = null;
					BossMode = false;
				}
			}
			
			/*
			if( Time >= 150 * stage.frameRate && !BossMode )
			{
				isComplete = true;
			}
			*/
			
			
			//b1
			if( Time == 200 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
			//b2
			if( Time == 205 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
			// b3 b4
			if( Time == 206 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 200, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 300, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
			//b5 b6 
			if( Time == 210 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 350, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			//b7 b8
			if( Time == 215 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
			//b9 b10
			if( Time == 220 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			// b11 b12 b13 b14 b15
			if( Time == 225 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
				// b16
			if( Time == 230 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
				
				// b17 b18
			if( Time == 231 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 200, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 300, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			// b19 b20
			if( Time == 232 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 350, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			
			// b21 b22
			if( Time == 233 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			
			// b23
			if( Time == 235 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
				
			}
				
				// b24 b25 b26
			if( Time == 240 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 350, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
				
			}
			
			// b23
			if( Time == 245 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
				
			}
			// b23
			if( Time == 245 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
				
			}
			
			// b24
			if( Time == 247 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
				
			}
			
			// b25
			if( Time == 249 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
				
			}
			// b26 b28
			if( Time == 250 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			// b29
			if( Time == 253 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			// b30 b31
			if( Time == 255 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			/*
			// b32
			if( Time == 256 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "light", 200, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
				
			}*/
			
			// b33
			if( Time == 257 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			
			// b34 b35
			if( Time == 259 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			
			// b36 b37 b38 b39 b40 b41 b42 b43 b44
			if( Time == 260 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 200, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 300, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 350, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			// b45 b46 b47 b48 b49 b50 b51 b52 b53
			if( Time == 262 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 200, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 300, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 350, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			
			
			// b54 b55 b56 b57 b58 b59 b60 b61 b62
			if( Time == 264 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 200, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 300, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 350, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
			
			// b63 b64
			if( Time == 265 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 300, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 200, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
				
			// b65
			if( Time == 267 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
				
				// b66 b67
			if( Time == 269 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 300, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 200, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			
			}
			
			
			// b68 b69
			if( Time == 270 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 200, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
			
			
			// b70 b71
			if( Time == 272 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
				
				
				// b72 b73
			if( Time == 274 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 350, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
				
			// b74
			if( Time == 275 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 350, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
				
			// b75
			if( Time == 277 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
		/*	
			// b76
			if( Time == 278 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "light", 300, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
				*/
			// b77
			if( Time == 279 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 310, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
				
			// b78 b79
			if( Time == 280 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
				
			// b80
			if( Time == 282 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Meteor", 500, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Meteor", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
				
			// b81 b82
			if( Time == 283 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Silo", 300, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Light", 200, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
				
			
			// b83 b84
			if( Time == 285 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Silo", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Silo", 350, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
				
				// b85 b86 b87
			if( Time == 290 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Silo", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Light", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "BlueDrone", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
			if( Time == 6 * stage.frameRate )
			{
				if( !BossMode )
				{
					BossReference = Enemy_( parent.addChild( factory.Spawn( "HullBoss", 250, 250, new PhysVector2D( 0, 0 ), myShip ) ) );
					BossReference.LoadBoundary( myShip.Boundary );
				}
				
				BossMode = true;
				if( BossReference != null && BossReference.IsDead )
				{
					BossReference = null;
					BossMode = false;
				}
			}
			
			/*
			// r1
			if( Time == 300 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 250, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
				
			// r2 r3 
			if( Time == 305 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 200, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 300, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				
			}
				
			// r4 r5 r6 r7 
			if( Time == 310 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
				
				
				
			
			// r8 r9 r10 r11 r12 r13
			if( Time == 315 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 200, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 300, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 350, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}

			// r14 r15 
			if( Time == 320 * stage.frameRate )
			{ 
				
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
				
			
			// r16 r17
			if( Time == 321 * stage.frameRate )
			{ 
				
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
			
			// r18 r19
			if( Time == 325 * stage.frameRate )
			{ 
				
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 200, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 300, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
				
			
			
			// r20 r21
			if( Time == 326 * stage.frameRate )
			{ 
				
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 350, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
			
			
			// r22 r23
			if( Time == 327 * stage.frameRate )
			{ 
				
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
			// r24 r25
			if( Time == 330 * stage.frameRate )
			{ 
				
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 250, 250, new PhysVector2D( 0, 0 ), this.myShip ) );
				
			}
				
			// r26 r27
			if( Time == 335 * stage.frameRate )
			{ 
				
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 250, 400, new PhysVector2D( 0, 0 ), this.myShip ) );
			}
				
			// r28 r29
			if( Time == 336 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 250, 250, new PhysVector2D( 0, 0 ), this.myShip ) );
			}
			
			// r30 r31
			if( Time == 337 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 250, 100, new PhysVector2D( 0, 0 ), this.myShip ) );
			}
				
			// r32 r33  
			if( Time == 340 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 350, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
				
				
			// r34 r35 r36 r37 r38
			if( Time == 345 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 250, 250, new PhysVector2D( 0, 0 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
				
				
			// r39 r40
			if( Time == 350 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 150, 150, new PhysVector2D( 0, 0 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 350, 350, new PhysVector2D( 0, 0 ), this.myShip ) );
			}
				
			
			// r43
			if( Time == 355 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 150, 150, new PhysVector2D( 0, 0 ), this.myShip ) );

			}
				
			// r44
			if( Time == 356 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 350, 150, new PhysVector2D( 0, 0 ), this.myShip ) );

			}
				
			// r45
			if( Time == 357 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 350, 350, new PhysVector2D( 0, 0 ), this.myShip ) );

			}
			
			// r46
			if( Time == 358 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 150, 350, new PhysVector2D( 0, 0 ), this.myShip ) );

			}
			
			//WORLD END aka Drop 275
		
			// r47 r48
			if( Time == 380 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
				
				
			// r49
			if( Time == 385 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
			
		
			// r50 r50
			if( Time == 390 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Red", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
				
			
			// r51
			if( Time == 395 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 250, 400, new PhysVector2D( 0, 0 ), this.myShip ) );
			}
				
			// r52 r53
			if( Time == 400 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 400, 350, new PhysVector2D( 0, 0 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 100, 350, new PhysVector2D( 0, 0 ), this.myShip ) );
			}
			
			
			// r55
			if( Time == 405 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Sprinkler", 150, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
				
			// r56 r57
			if( Time == 410 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Sprinkler", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Sprinkler", 450, 0, new PhysVector2D( 0, 1 ), this.myShip ) );  
			}
				
			// r58 
			if( Time == 415 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Sprinkler", 350, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
			
			// r56
			if( Time == 420 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Sprinkler", 50, 0, new PhysVector2D( 0, 1 ), this.myShip ) );  
			}
				
			// r56 r57 r58
			if( Time == 425 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Sprinkler", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 250, 400, new PhysVector2D( 0, 0 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Sprinkler", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}
				
			// r59 r60 r61
			if( Time == 430 * stage.frameRate )
			{ 
				this.parent.addChild( this.factory.Spawn( "Enemy_Drone", 100, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Nuke", 250, 350, new PhysVector2D( 0, 0 ), this.myShip ) );
				this.parent.addChild( this.factory.Spawn( "Enemy_Sprinkler", 400, 0, new PhysVector2D( 0, 1 ), this.myShip ) );
			}*/
		}
		/*
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