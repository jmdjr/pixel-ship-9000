package Juke_Box.increase
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	public class wav extends Sound
	{
		public function wav(stream:URLRequest=null, context:SoundLoaderContext=null)
		{
			super(stream, context);
		}
	}
}