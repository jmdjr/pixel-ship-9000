package src
{
	import AFerociousOpponent.mp3;
	import BulletDance.mp3;
	import ConflictofHearts.mp3;
	import UnfriendlyRave.mp3;
	
	import explode2.wav;
	import attack2.wav;
	import shot1.wav;
	import choice2.wav;
	import fall1.wav;
	import increase.wav;
	import explode7.wav;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class JukeBox
	{
		public static var TITLE_MUSIC:Sound = new AFerociousOpponent.mp3();
		public static var GAME_MUSIC:Sound = new BulletDance.mp3();
		public static var CUSTOM_MUSIC:Sound = new UnfriendlyRave.mp3();
		public static var BOSS_MUSIC:Sound = new ConflictofHearts.mp3();
		
		public static var EXPLODE_SE:Sound = new explode2.wav();
		public static var ATTACK1_SE:Sound = new shot1.wav();
		public static var ATTACK2_SE:Sound = new attack2.wav();
		public static var CHOICE_SE:Sound = new choice2.wav();
		public static var ADD_MOD_SE:Sound = new increase.wav();
		public static var DELETE_MOD_SE:Sound = new fall1.wav();
		public static var EXPLODE_ATTACK_SE:Sound = new explode7.wav();
		
		private var WorldChannel:SoundChannel;
		
		public function JukeBox()
		{
			WorldChannel = new SoundChannel();
			WorldChannel = TITLE_MUSIC.play();
			WorldChannel.stop();
		}
		
		public function Play( StaticName:Sound ):void
		{
			Stop();
			WorldChannel = StaticName.play(0, 100);
		}
		
		public function Stop():void
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