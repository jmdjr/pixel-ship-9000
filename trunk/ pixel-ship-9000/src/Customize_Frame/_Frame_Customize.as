package src.Customize_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	
	import src.Background;
	import src.Frames;
	import src.GameDataTracker;
	import src.JukeBox;
	import src.Ship;
	
	public class _Frame_Customize extends MovieClip
	{
		var background:Background;
		var gameData:GameDataTracker;
		var ShipReference:Ship;
		
		var BTMainMenu:GenericButton_TitleScreen;
		var BTPlayAgain:GenericButton_Restart;
		//var BTContinue:GenericButton_Continue;
		
		var sum_attackText:Text_ShipAttackStat;
		var sum_defenseText:Text_ShipDefenseStat;
		var sum_speedText:Text_ShipSpeedStat;
		var sum_healthText:Text_ShipHealthStat;
		
		var price_defensePixel:Text_DefensePixelModPrice;
		var price_speedPixel:Text_SpeedPixelModPrice;
		var price_attackPixel:Text_AttackPixelModPrice;
		
		var amount_perchase:Number;
		
		var ship_scrapTotalText:Text_ShipScrap;
		var MGC:PixelMod_Grid_Customizer;
		
		var BuyATK:ModSpawn_Attack;
		var BuySPEED:ModSpawn_Speed;
		var BuyDEF:ModSpawn_Defense;
		var RefSpawner:ModSpawn_;
		
		public function _Frame_Customize()
		{
			super();
			
			background = new Background();
			
			ShipReference = null;
			
			BTMainMenu = null;
			BTPlayAgain = null;	
			//BTContinue = null;
			
			sum_attackText = null;
			sum_defenseText = null;
			sum_speedText = null;
			sum_healthText = null;
			
			price_defensePixel = null;
			price_speedPixel = null;
			price_attackPixel = null;
			
			ship_scrapTotalText = null;
			MGC = null;
			
			BuyATK = null;
			BuySPEED = null;
			BuyDEF = null;	
			
			this.addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		public function init( e:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
			LoadFrame();
			amount_perchase = 0;
			addEventListener( Event.ENTER_FRAME, Update );
		}
		
		public function LoadFrame():void
		{
			if( gameData != null )
			{
				gameData.JB.Play( JukeBox.CUSTOM_MUSIC );
			}
				
			for(var child:int = 0; child < numChildren; ++child )
			{
				var childClip = getChildAt( child );
				
				switch( getQualifiedSuperclassName( childClip ) )
				{
					case getQualifiedClassName( GenericButton_ ):
						assignButtons( GenericButton_( childClip ) );
						break;
					
					case getQualifiedClassName( Text_ ):
						assignTextObjects( Text_( childClip ) );
						break;
					
					case getQualifiedClassName( ModSpawn_ ):
						assignModSpawner( ModSpawn_( childClip ) );
						break;
					
					default:
						assignRest( childClip );
						break;
				}
			}
			
			if( this.stage != null )
			{
				addChildAt( background, 0 );
				with( background )
				{
					width = this.stage.stageWidth;
					startY = this.stage.stageHeight;
					x = 0;
					y = startY; 
					scrollRate = 10;
				}
			}
			
			this.addEventListener( MouseEvent.CLICK, OnClick_Frame );
		}
		
		private function assignModSpawner( childClip:ModSpawn_ ):void
		{
			switch( getQualifiedClassName( childClip ) )
			{
				case getQualifiedClassName( ModSpawn_Attack ):
					BuyATK = ModSpawn_Attack( childClip );
					BuyATK.addEventListener(MouseEvent.CLICK, OnClick_AttackModSpawner );
					break;
				
				case getQualifiedClassName( ModSpawn_Speed ):
					BuySPEED = ModSpawn_Speed( childClip );
					BuySPEED.addEventListener(MouseEvent.CLICK, OnClick_SpeedModSpawner );
					break;
				
				case getQualifiedClassName( ModSpawn_Defense ):
					BuyDEF = ModSpawn_Defense( childClip );
					BuyDEF.addEventListener( MouseEvent.CLICK, OnClick_DefenseModSpawner );
					break;
			}
		}
		
		private function assignRest( childClip:MovieClip ):void
		{
			switch( getQualifiedClassName( childClip ) )
			{
				case getQualifiedClassName( PixelMod_Grid_Customizer ):
					MGC = PixelMod_Grid_Customizer( childClip );
					MGC.LoadShipReference( ShipReference );
					MGC.addEventListener( MouseEvent.CLICK, OnClick_Grid_Customizer );
					break;
				
				case getQualifiedClassName( Ship ):
					break;
			}
		}
		
		private function assignButtons( childClip:GenericButton_ ):void
		{
			switch( getQualifiedClassName( childClip ) )
			{
				case getQualifiedClassName( GenericButton_Restart ):
					BTPlayAgain = GenericButton_Restart( childClip );
					BTPlayAgain.addEventListener(MouseEvent.CLICK, returnPlayAgain );
					break;
				
				//case getQualifiedClassName( GenericButton_Continue ):
				//	BTContinue = GenericButton_Continue( childClip );
				//	BTContinue.addEventListener( MouseEvent.CLICK, returnPlayAgain );
				//	break;
				
				case getQualifiedClassName( GenericButton_TitleScreen ):
					BTMainMenu = GenericButton_TitleScreen( childClip );
					BTMainMenu.addEventListener( MouseEvent.CLICK, returnMainMenu ); 
					break;
			}
		}
		
		private function assignTextObjects( childClip:Text_ ):void
		{
			switch( getQualifiedClassName( childClip ) )
			{
				case getQualifiedClassName( Text_ShipHealthStat ):
					sum_healthText = Text_ShipHealthStat( childClip );
					sum_healthText.Value = String( 0 );
					break;
				
				case getQualifiedClassName( Text_ShipAttackStat ):
					sum_attackText = Text_ShipAttackStat( childClip );
					sum_attackText.Value = String( 0 );
					break;
				
				case getQualifiedClassName( Text_ShipDefenseStat ):
					sum_defenseText = Text_ShipDefenseStat( childClip );
					sum_defenseText.Value = String( 0 );
					break;
				
				case getQualifiedClassName( Text_ShipSpeedStat ):
					sum_speedText = Text_ShipSpeedStat( childClip );
					sum_speedText.Value = String( 0 );
					break;
				
				case getQualifiedClassName( Text_AttackPixelModPrice ):
					price_attackPixel = Text_AttackPixelModPrice( childClip );
					price_attackPixel.Value = String( 0 ) + "s";
					break;
				
				case getQualifiedClassName( Text_SpeedPixelModPrice ):
					price_speedPixel = Text_SpeedPixelModPrice( childClip );
					price_speedPixel.Value = String( 0 ) + "s";
					break;
				
				case getQualifiedClassName( Text_DefensePixelModPrice ):
					price_defensePixel = Text_DefensePixelModPrice( childClip );
					price_defensePixel.Value = String( 0 ) + "s";
					break;
				
				case getQualifiedClassName( Text_ShipScrap ):
					ship_scrapTotalText = Text_ShipScrap( childClip );
					ship_scrapTotalText.Value = "Scrap:" + String( 0 );
					break;
			}
		} 
				
		public function UpdateUI():void
		{
			ShipReference.RecalcModGrid();
			ship_scrapTotalText.Value = "Scrap:" + String( gameData.Scrap );

			sum_attackText.Value = String( ShipReference.ReportAttackStat );
			sum_speedText.Value = String( ShipReference.ReportSpeedStat );
			sum_defenseText.Value = String( ShipReference.ReportDefenseStat );
			sum_healthText.Value = String( ShipReference.ReportHealthStat );
			
			price_attackPixel.Value = String( (ShipReference.ReportAttackMods() + 1) * 20 );
			price_speedPixel.Value = String( (ShipReference.ReportSpeedMods() + 1) * 5 );
			price_defensePixel.Value = String( (ShipReference.ReportDefenseMods() + 1) * 50 );
		}
		
		public function Update( tick:Event ):void
		{
			if( enabled )
			{
				background.Update( tick );
				UpdateUI();
				
				if( RefSpawner != null )
				{
					RefSpawner.x = mouseX + RefSpawner.width + 5;
					RefSpawner.y = mouseY;
				}
			}
		}
		
		private function OnClick_AttackModSpawner( click:MouseEvent ):void
		{
			click.stopPropagation();
			JukeBox.PlaySE( JukeBox.CHOICE_SE );
			if( RefSpawner != null && getQualifiedClassName( RefSpawner ) == getQualifiedClassName( BuyATK ) )
			{
				return;
			}
			
			OnClick_Frame( click );
			
			if( gameData.Scrap < int( price_attackPixel.Value ) )
			{
				// do something to warn the player about being so bloody poor.
				return;
			}
			amount_perchase = Number( price_attackPixel.Value );
			
			// Spawns a spawner and moves it to the reference spawner's spot.
			RefSpawner = BuyATK.Spawn_ModSpawn();
			MGC.UpdateReferenceMod( RefSpawner );
			addChild( RefSpawner );
		}
		
		private function OnClick_DefenseModSpawner( click:MouseEvent ):void
		{
			click.stopPropagation();
			JukeBox.PlaySE( JukeBox.CHOICE_SE );
			if( RefSpawner != null && getQualifiedClassName( RefSpawner ) == getQualifiedClassName( BuyDEF ) )
			{
				return;
			}
			
			OnClick_Frame( click );
			
			if( gameData.Scrap < int( price_defensePixel.Value ) )
			{
				// do something to warn the player about being so bloody poor.
				return;
			}
			amount_perchase = Number( price_defensePixel.Value );
			
			// Spawns a spawner and moves it to the reference spawner's spot.
			RefSpawner = BuyDEF.Spawn_ModSpawn();
			MGC.UpdateReferenceMod( RefSpawner );
			addChild( RefSpawner );
		}
		
		private function OnClick_SpeedModSpawner( click:MouseEvent ):void
		{
			click.stopPropagation();
			JukeBox.PlaySE( JukeBox.CHOICE_SE );
			if( RefSpawner != null && getQualifiedClassName( RefSpawner ) == getQualifiedClassName( BuySPEED ) )
			{
				return;
			}
			
			OnClick_Frame( click );
			
			if( gameData.Scrap < int( price_speedPixel.Value ) )
			{
				// do something to warn the player about being so bloody poor.
				return;
			}
			amount_perchase = Number( price_speedPixel.Value );
			
			// Spawns a spawner and moves it to the reference spawner's spot.
			RefSpawner = BuySPEED.Spawn_ModSpawn();
			MGC.UpdateReferenceMod( RefSpawner );
			addChild( RefSpawner );
		}
		
		private function OnClick_Grid_Customizer( click:MouseEvent ):void
		{
			click.stopPropagation();
			
			gameData.SpendScrap( amount_perchase );
			
			if( RefSpawner != null && contains( RefSpawner ) )
			{
				JukeBox.PlaySE( JukeBox.ADD_MOD_SE );
				removeChild( RefSpawner );
				MGC.OnClick_ZoneGrid( click );
			
				RefSpawner = null;
				MGC.UpdateReferenceMod( null );
			}
			else
			{
				JukeBox.PlaySE( JukeBox.DELETE_MOD_SE );
				RefSpawner = null;
				MGC.UpdateReferenceMod( null );
				MGC.OnClick_ZoneGrid( click );
			}
			
			MGC.Produce_Ship_From_Grid();
		}
		
		private function OnClick_Frame( click:MouseEvent ):void
		{
			if( RefSpawner != null )
			{
				JukeBox.PlaySE( JukeBox.DELETE_MOD_SE );
				RefSpawner.visible = false;
				RefSpawner.enabled = false;
				RefSpawner.parent.removeChild( RefSpawner );
				RefSpawner = null;
			}
		}
		
		private function returnMainMenu( click:MouseEvent ):void
		{
			dispatchEvent( new Event( Frames.TITLE, true ) );
		}
		
		private function returnPlayAgain( click:MouseEvent ):void
		{
			dispatchEvent( new Event( Frames.GAME, true ) );
		}
		
		public function LoadGameData( data:GameDataTracker )
		{
			gameData = data;
		}
		
		public function LoadShipReference( sr:Ship ):void
		{
			this.ShipReference = sr;
		}
	}
}