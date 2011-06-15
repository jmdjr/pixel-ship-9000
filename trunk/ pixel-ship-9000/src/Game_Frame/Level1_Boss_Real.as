package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	import src.PhysVector2D;

	public class Level1_Boss_Real extends EnemyObject
	{
		var TopLeftPosition:Boolean;
		var blackImage:MovieClip = new Level1_Boss_Black();
		var whiteImage:MovieClip = new Level1_Boss_White();
		var PhantomBoss:Level1_Boss_Phantom = new Level1_Boss_Phantom();
		
		public function Level1_Boss_Real()
		{
			super();
			_CurrentClass = Level1_Boss_Real;
			fullHealth = 20;
			PrimaryWeapon = new Level1_Boss_Bullet_Real();
			ResetHealth();
			addEventListener( Event.ADDED, LoadPhantom );
			
			speed = 1;
		}
		
		private function LoadPhantom( e:Event ):void
		{
			this.removeEventListener( Event.ADDED, LoadPhantom );
			parent.addChild( PhantomBoss );
			PhantomBoss.Initialize();
			PhantomBoss.LoadPlayerReference( ShipReference );
			
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
				PhantomBoss.y = 675;
			}
			else
			{
				x = 375;
				y = 675;
				
				TopLeftPosition = false;
				
				velocity.Equal( PhysVector2D.UP );
				PhantomBoss.setVelocity = PhysVector2D.DOWN;
				
				PhantomBoss.x = 125;
				PhantomBoss.y = -125;
			}
		}
		
		public function DecideWhichSpawnImage()
		{
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
		
		protected function RestartPlay():void
		{
			DecideWhichSpawnImage();
			DecideWhichSpawnPoint();
		}
		
		protected override function DoMoveChecks():void
		{
			super.DoMoveChecks();
			PhantomBoss.doMoveChecks();
			
			if( TopLeftPosition && this.y > 125 )
			{
				velocity.Equal( PhysVector2D.ZERO );
				PhantomBoss.setVelocity = PhysVector2D.ZERO;
			}
			else if( !TopLeftPosition && this.y <= 375 )
			{
				velocity.Equal( PhysVector2D.ZERO );
				PhantomBoss.setVelocity = PhysVector2D.ZERO;
			}
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