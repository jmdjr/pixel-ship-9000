package src.Game_Frame
{
	import Juke_Box.JukeBox;
	
	import fl.motion.Color;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import src.GameDataTracker;
	import src.Game_Frame.Summary_Frame.Asset_Status_Level_BG;
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
		private var LevelStepsCollection:Array;
		private var PastTime:int = 0;
		
		private var TimeVal:int = 8; // starting time for this level
		private var TimeInc:int = 3; // incrementing steps for time
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
			LevelStepsCollection = new Array();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		protected function addedToStage( tick:Event ):void
		{
			this.BuildLevelSteps();
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
					"Arrow keys to move\n" + 
					"Z to fire. \n" +
					"If you die...\n" +
					"you get to upgrade your ship!\n" + 
					"but you have to restart at the beginning... \n\n";
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
		
		private function BuildLevelSteps():void
		{
			LevelStepsCollection[1] = function():void {
				JukeBox.Play( JukeBox.GAME_MUSIC );
				DisplayLevelHint();
			};
			
			LevelStepsCollection[8] = function():void {
				RemoveLevelHint();
			};
			
			BuildLevel_1();
			BuildLevel_2();
			BuildLevel_3();
		}
		
		private function BuildLevel_1():void
		{
			//e2 e3
			LevelStepsCollection[TimeVal] = function():void
			{
				parent.addChild( factory.Spawn( "Drone", 400, 0, PhysVector2D.DOWN, myShip ) );
				parent.addChild( factory.Spawn( "Drone", 100, 0, PhysVector2D.DOWN, myShip ) );
			};
			TimeVal += TimeInc;
			
			//e4 e5 e6
			LevelStepsCollection[TimeVal] = function():void
			{
				parent.addChild( factory.Spawn( "BlueDrone", 150, 0, PhysVector2D.DOWN, myShip ) );
				parent.addChild( factory.Spawn( "Drone", 250, 0, PhysVector2D.DOWN, myShip ) );
				parent.addChild( factory.Spawn( "BlueDrone", 350, 0, PhysVector2D.DOWN, myShip ) );
			};
			TimeVal += TimeInc;
			//e7
			LevelStepsCollection[TimeVal] = function():void
			{
				parent.addChild( factory.Spawn( "BlueDrone", 0, 300, PhysVector2D.RIGHT, myShip ) );
			};
			TimeVal += TimeInc;
			//e8
			LevelStepsCollection[TimeVal] = function():void
			{
				parent.addChild( factory.Spawn( "Drone", 499, 400, PhysVector2D.LEFT, myShip ) );
			};
			TimeVal += TimeInc;
			
			//e11 
			LevelStepsCollection[TimeVal] = function():void
			{
				parent.addChild( factory.Spawn( "Drone", 250, 0, PhysVector2D.DOWN, myShip ) );
			};
			TimeVal += TimeInc;
			
			//e10 e12
			LevelStepsCollection[TimeVal] = function():void
			{
				parent.addChild( factory.Spawn( "Drone", 200, 0, PhysVector2D.DOWN, myShip ) );
				parent.addChild( factory.Spawn( "Drone", 300, 0, PhysVector2D.DOWN, myShip ) );
			};
			TimeVal += TimeInc;
			
			//e9 e13
			LevelStepsCollection[TimeVal] = function():void
			{
				parent.addChild(  factory.Spawn( "Drone", 50, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Drone", 450, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e14
			LevelStepsCollection[TimeVal] = function():void
			{
				parent.addChild(  factory.Spawn( "Jav", 250, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e15 e16
			LevelStepsCollection[TimeVal] = function():void
			{
				parent.addChild(  factory.Spawn( "Drone", 150, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Drone", 350, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e17
			LevelStepsCollection[TimeVal] = function():void
			{
				parent.addChild(  factory.Spawn( "Jav", 250, 0, PhysVector2D.DOWN,  myShip ) );
			};
			//e18 e19
			LevelStepsCollection[TimeVal] = function():void
			{
				parent.addChild(  factory.Spawn( "Drone", 0, 200, PhysVector2D.RIGHT,  myShip ) );
				parent.addChild(  factory.Spawn( "Drone", 499, 300, PhysVector2D.LEFT,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e20
			LevelStepsCollection[TimeVal] = function():void
			{
				parent.addChild(  factory.Spawn( "Jav", 250, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e21 e22
			LevelStepsCollection[TimeVal] = function():void
			{
				parent.addChild(  factory.Spawn( "Drone", 250, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Drone", 200, 499, PhysVector2D.UP,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e23
			LevelStepsCollection[TimeVal] = function():void
			{
				parent.addChild(  factory.Spawn( "Jav", 250, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e24 Mid Boss 1
			LevelStepsCollection[TimeVal] = function():void
			{
				parent.addChild(  factory.Spawn( "Drone", 250, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			LevelStepsCollection[TimeVal] = function():void
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
			};
			TimeVal += TimeInc;
			
			// e26 e29
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Drone", 100, 499, PhysVector2D.UP,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 400, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e25 e27 e28 30
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Drone", 50, 499, PhysVector2D.UP,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 150, 499, PhysVector2D.UP,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 450,0, PhysVector2D.DOWN,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 350,0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e31 e32 e33 e 34 e35 e36
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Drone", 0, 250, PhysVector2D.RIGHT,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 0, 350, PhysVector2D.RIGHT,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 499, 200, PhysVector2D.LEFT,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 499, 300, PhysVector2D.LEFT,  myShip ) );
				 parent.addChild(  factory.Spawn( "Jav", 200, 0, PhysVector2D.DOWN,  myShip ) );
				 parent.addChild(  factory.Spawn( "Jav",300, 499, PhysVector2D.UP,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// e35.1
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Jav", 0, 250, PhysVector2D.RIGHT,  myShip ) );
			};
			TimeVal += TimeInc;

			//e36.1
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Drone", 250, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e37 e38 e39 e40 e41 e42 e43
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Drone", 450, 499, PhysVector2D.UP,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 350, 499, PhysVector2D.UP,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 250, 499, PhysVector2D.UP,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 150, 499, PhysVector2D.UP,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 50, 499, PhysVector2D.DOWN,  myShip ) );
				 parent.addChild(  factory.Spawn( "Jav", 50, 50, PhysVector2D.RIGHT,  myShip ) );
				 parent.addChild(  factory.Spawn( "Jav", 250, 0, PhysVector2D.LEFT,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e44 e45 e46
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Drone", 250, 50, PhysVector2D.RIGHT,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 499, 250, PhysVector2D.LEFT,  myShip ) );
				 parent.addChild(  factory.Spawn( "Bomb", 350, 350, PhysVector2D.ZERO,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e47 e48 e49
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Drone", 200, 0, PhysVector2D.RIGHT,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 300,499, PhysVector2D.UP,  myShip ) );
				 parent.addChild(  factory.Spawn( "Bomb", 350, 350, PhysVector2D.ZERO,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e51 e53 e54
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Drone", 250, 499, PhysVector2D.LEFT,  myShip ) );
				 parent.addChild(  factory.Spawn( "Jav", 150, 0, PhysVector2D.DOWN,  myShip ) );
				 parent.addChild(  factory.Spawn( "Jav", 350, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e50 e52
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Drone", 50, 0, PhysVector2D.DOWN,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 450,0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e55 e56 e57
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Bomb", 250, 400, PhysVector2D.ZERO,  myShip ) );
				 parent.addChild(  factory.Spawn( "Bomb", 150, 100, PhysVector2D.ZERO,  myShip ) );
				 parent.addChild(  factory.Spawn( "Bomb", 350, 100, PhysVector2D.ZERO,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e58 e59 
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Jav", 250, 0, PhysVector2D.DOWN,  myShip ) );
				 parent.addChild(  factory.Spawn( "Jav", 499, 250, PhysVector2D.LEFT,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e60 e61 e62 e63 e64
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Drone", 50, 499, PhysVector2D.UP,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 150, 499, PhysVector2D.UP,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 250, 499, PhysVector2D.UP,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 350, 499, PhysVector2D.UP,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 450, 499, PhysVector2D.UP,  myShip ) );
			};
			TimeVal += TimeInc;

			//e69 
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Jav", 499, 250, PhysVector2D.LEFT,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e70
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Jav", 350, 499, PhysVector2D.UP,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e72 e75 
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Drone", 250, 0, PhysVector2D.DOWN,  myShip ) );
				 parent.addChild(  factory.Spawn( "Drone", 0, 250, PhysVector2D.RIGHT,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e65 e66 e67 e68
			LevelStepsCollection[TimeVal] = function():void {
				 parent.addChild(  factory.Spawn( "Bomb", 100, 150, PhysVector2D.ZERO,  myShip ) );
				 parent.addChild(  factory.Spawn( "Bomb", 400, 150, PhysVector2D.ZERO,  myShip ) );
				 parent.addChild(  factory.Spawn( "Bomb", 100, 400, PhysVector2D.ZERO,  myShip ) );
				 parent.addChild(  factory.Spawn( "Bomb", 400, 400, PhysVector2D.ZERO,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//e71 e73 e74 e76 124
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild( factory.Spawn( "Drone", 200, 0, PhysVector2D.DOWN, myShip ) );
				parent.addChild( factory.Spawn( "Drone", 300, 0, PhysVector2D.DOWN, myShip ) );
				parent.addChild( factory.Spawn( "Drone", 0, 200, PhysVector2D.RIGHT, myShip ) );
				parent.addChild( factory.Spawn( "Drone", 0, 300, PhysVector2D.RIGHT, myShip ) );
			};		
			TimeVal += TimeInc;	
			//
			//LevelStepsCollection[TimeVal] = function():void {
				//
				//if( !BossMode )
				//{
					//BossReference = Enemy_( parent.addChild( factory.Spawn( "BigBoss", 250, 100, new PhysVector2D( 1, -1 ), myShip ) ) );
					//BossReference.LoadBoundary( myShip.Boundary );
				//}
				//
				//BossMode = true;
				//if( BossReference != null && BossReference.IsDead )
				//{
					//BossReference = null;
					//BossMode = false;
				//} 
			//};
			//TimeVal += TimeInc;
		}
		
		private function BuildLevel_2():void
		{
			//b1
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "BlueDrone", 250, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//b2
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "BlueDrone", 250, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b3 b4
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "BlueDrone", 200, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "BlueDrone", 300, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//b5 b6 
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "BlueDrone", 150, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "BlueDrone", 350, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//b7 b8
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "BlueDrone", 100, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "BlueDrone", 400, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//b9 b10
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "BlueDrone", 50, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "BlueDrone", 450, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b11 b12 b13 b14 b15
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "BlueDrone", 50, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "BlueDrone", 100, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "BlueDrone", 400, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "BlueDrone", 450, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b16
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "BlueDrone", 250, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b17 b18
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "BlueDrone", 200, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "BlueDrone", 300, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b19 b20
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "BlueDrone", 150, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "BlueDrone", 350, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b21 b22
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "BlueDrone", 100, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "BlueDrone", 400, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b23
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 150, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b24 b25 b26
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 150, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 250, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 350, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b23
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 100, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;

			// b23
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 100, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b24
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 250, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b25
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 400, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b26 b28
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 50, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 450, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;

			// b29
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 250, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;

			// b30 b31
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 50, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 450, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b32
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Beam", 200, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b33
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 250, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b34 b35
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 50, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 450, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b36 b37 b38 b39 b40 b41 b42 b43 b44
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 50, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 100, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 150, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 200, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 250, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 300, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 350, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 400, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 450, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b45 b46 b47 b48 b49 b50 b51 b52 b53
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 50, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 100, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 150, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 200, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 250, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 300, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 350, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 400, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 450, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b54 b55 b56 b57 b58 b59 b60 b61 b62
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 50, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 100, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 150, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 200, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 250, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 300, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 350, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 400, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 450, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b63 b64
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 300, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 200, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b65
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 250, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b66 b67
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 300, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 200, 0, PhysVector2D.DOWN,  myShip ) );
			};	
			TimeVal += TimeInc;		
			
			// b68 b69
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 400, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 200, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b70 b71
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 450, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 150, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b72 b73
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 350, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 150, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b74
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 350, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b75
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 250, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b76
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Beam", 300, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b77
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 310, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b78 b79
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 450, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 50, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b80
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Meteor", 500, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Meteor", 100, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;

			// b81 b82
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "EnemySilo", 300, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Beam", 200, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;

			// b83 b84
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "EnemySilo", 150, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "EnemySilo", 350, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// b85 b86 b87
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "EnemySilo", 150, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Beam", 250, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "BlueDrone", 400, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			TimeVal += 10;
			LevelStepsCollection[TimeVal] = function():void {
				if( !BossMode )
				{
					BossReference = Enemy_( parent.addChild( factory.Spawn( "HullBoss", 250, 250, PhysVector2D.ZERO, myShip ) ) );
					BossReference.LoadBoundary( myShip.Boundary );
				}
				
				BossMode = true;
				if( BossReference != null && BossReference.IsDead )
				{
					BossReference = null;
					BossMode = false;
				}
			};
			TimeVal += TimeInc;
		}
		
		private function BuildLevel_3():void
		{
			// r1
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild( factory.Spawn( "Enemy_Red", 250, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r2 r3 
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Red", 200, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 300, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r4 r5 r6 r7 
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Red", 50, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 100, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 400, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 450, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r8 r9 r10 r11 r12 r13
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Red", 100, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 150, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 200, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 300, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 350, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 400, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r14 r15 
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Red", 50, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 450, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r16 r17
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Red", 100, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 400, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r18 r19
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Red", 200, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 300, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
	
			// r20 r21
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Red", 150, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 350, 0, PhysVector2D.DOWN,  myShip ) );
			};		
			TimeVal += TimeInc;	
			
			// r22 r23
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Red", 100, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 400, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r24 r25
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 250, 250, PhysVector2D.ZERO,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r26 r27
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 250, 400, PhysVector2D.ZERO,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r28 r29
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 250, 250, PhysVector2D.ZERO,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r30 r31
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 250, 100, PhysVector2D.ZERO,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r32 r33 
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Red", 100, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 150, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 350, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 400, 0, PhysVector2D.DOWN,  myShip ) );
			}; 
			TimeVal += TimeInc;
			
			// r34 r35 r36 r37 r38
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Red", 50, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 150, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 250, 250, PhysVector2D.ZERO,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 400, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 450, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r39 r40
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 150, 150, PhysVector2D.ZERO,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 350, 350, PhysVector2D.ZERO,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r43
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 150, 150, PhysVector2D.ZERO,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r44
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 350, 150, PhysVector2D.ZERO,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r45
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 350, 350, PhysVector2D.ZERO,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r46
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 150, 350, PhysVector2D.ZERO,  myShip ) );
			};
			TimeVal += TimeInc;
			
			//WORLD END aka Drop 275
			
			// r47 r48
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Red", 100, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
		
			// r49
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Red", 100, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r50 r50
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Red", 50, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Red", 450, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r51
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 250, 400, PhysVector2D.ZERO,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r52 r53
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 400, 350, PhysVector2D.ZERO,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 100, 350, PhysVector2D.ZERO,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r55
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Sprinkler", 150, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r56 r57
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Sprinkler", 50, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Sprinkler", 450, 0, PhysVector2D.DOWN,  myShip ) );  
			};
			TimeVal += TimeInc;
			
			// r58 
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Sprinkler", 350, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r56
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Sprinkler", 50, 0, PhysVector2D.DOWN,  myShip ) );  
			};
			TimeVal += TimeInc;
			
			// r56 r57 r58
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Sprinkler", 100, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 250, 400, PhysVector2D.ZERO,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Sprinkler", 400, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
			
			// r59 r60 r61
			LevelStepsCollection[TimeVal] = function():void {
				parent.addChild(  factory.Spawn( "Enemy_Drone", 100, 0, PhysVector2D.DOWN,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Nuke", 250, 350, PhysVector2D.ZERO,  myShip ) );
				parent.addChild(  factory.Spawn( "Enemy_Sprinkler", 400, 0, PhysVector2D.DOWN,  myShip ) );
			};
			TimeVal += TimeInc;
		}
		
		public function Update( tick:Event ):void
		{
			if( !BossMode ) 
			{
				++Time;
			}
			
			var TimeInSeconds:int = Time / stage.frameRate;
			
			if(PastTime != TimeInSeconds || BossMode)
			{
				if(LevelStepsCollection[TimeInSeconds] != null)
				{
					(LevelStepsCollection[TimeInSeconds] as Function)();
				}
				
				PastTime = TimeInSeconds;
			}
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