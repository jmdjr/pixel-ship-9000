package src.Customize_Frame
{
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class Text_ extends MovieClip
	{
		private var _className:Class;
		private var _TextField:TextField;
		
		public function Text_()
		{
			super();
			_className = Text_;
			
			_TextField = TextField( this.getChildAt( 0 ));
		}
		
		public function get Value():String
		{ 
			return _TextField.text; 
		}
		
		public function set Value( _v:String ):void
		{
			_TextField.text = _v;
		}
		
	}
}