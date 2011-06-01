package src
{
	import BulletDance.mp3;
	import ConflictofHearts.mp3;
	import UnfriendlyRave.mp3;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class JukeBox
	{
		public static var TITLE_MUSIC:Sound = new BulletDance.mp3();
		public static var GAME_MUSIC:Sound = new BulletDance.mp3();
		public static var CUSTOM_MUSIC:Sound = new UnfriendlyRave.mp3();
		public static var BOSS_MUSIC:Sound = new ConflictofHearts.mp3();
		
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
	}
}