package Juke_Box
{
	import Juke_Box.AFerociousOpponent.mp3;
	import Juke_Box.BulletDance.mp3;
	import Juke_Box.ConflictofHearts.mp3;
	import Juke_Box.UnfriendlyRave.mp3;
	import Juke_Box.attack2.wav;
	import Juke_Box.choice2.wav;
	import Juke_Box.explode2.wav;
	import Juke_Box.explode7.wav;
	import Juke_Box.fall1.wav;
	import Juke_Box.increase.wav;
	import Juke_Box.shot1.wav;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class JukeBox
	{
		public static var TITLE_MUSIC:Sound = new Juke_Box.AFerociousOpponent.mp3();
		public static var GAME_MUSIC:Sound = new Juke_Box.BulletDance.mp3();
		public static var CUSTOM_MUSIC:Sound = new Juke_Box.UnfriendlyRave.mp3();
		public static var BOSS_MUSIC:Sound = new Juke_Box.ConflictofHearts.mp3();
		
		public static var EXPLODE_SE:Sound = new Juke_Box.explode2.wav();
		public static var ATTACK1_SE:Sound = new Juke_Box.shot1.wav();
		public static var ATTACK2_SE:Sound = new Juke_Box.attack2.wav();
		public static var CHOICE_SE:Sound = new Juke_Box.choice2.wav();
		public static var ADD_MOD_SE:Sound = new Juke_Box.increase.wav();
		public static var DELETE_MOD_SE:Sound = new Juke_Box.fall1.wav();
		public static var EXPLODE_ATTACK_SE:Sound = new Juke_Box.explode7.wav();
		
		public static var WorldChannel:SoundChannel;
		
		public function JukeBox()
		{
			 
		}
		
		public static function Play( StaticName:Sound ):void
		{
			if( StaticName != null )
			{
				if( WorldChannel != null )
				{
					Stop();
				}
				
				WorldChannel = StaticName.play(0, 100);
			}
		}
		
		public static function Stop():void
		{
			WorldChannel.stop(); 
		}
		
		public static function PlaySE( SEName:Sound ):void
		{
			var temp:Sound = SEName;
			temp.play(0, 0);
		}
	}
}