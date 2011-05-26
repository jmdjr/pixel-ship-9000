package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.getTimer;  
	
	public class FrameRate extends MovieClip
	{
		public var startTime:Number;  
		public var framesNumber:Number = 0;  
		public var fps:TextField = new TextField();
		
		public function FrameRate()
		{
			fpsCounter();  
		}
		
		public function fpsCounter():void  
		{  
			startTime = getTimer();  
			addChild(fps);  
			
			addEventListener(Event.ENTER_FRAME, checkFPS);  
		}  
		
		public function checkFPS(e:Event):void  
		{  
			var currentTime:Number = (getTimer() - startTime) / 1000;  
			
			framesNumber++;  
			
			if (currentTime > 1)  
			{  
				fps.text = "FPS: " + (Math.floor((framesNumber/currentTime)*10.0)/10.0);  
				startTime = getTimer();  
				framesNumber = 0;  
			}  
		}  
	}
}