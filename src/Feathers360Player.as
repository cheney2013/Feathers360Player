package
{
	import cn.is360.skin.Main;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	[SWF(width="960",height="640",frameRate="60",backgroundColor="#4a4137")]
	public class Feathers360Player extends Sprite
	{
		public function Feathers360Player()
		{			
			if(stage)
			{
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			mouseEnabled = mouseChildren = false;
			loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}
		
		private var _starling:Starling;
		
		private function loaderInfo_completeHandler(event:Event):void
		{
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			_starling = new Starling(Main, stage);
			_starling.enableErrorChecking = false;
			//_starling.showStats = true;
			//_starling.showStatsAt(HAlign.LEFT, VAlign.BOTTOM);
			_starling.start();
			
			stage.addEventListener(Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
			stage.addEventListener(Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);
		}
		
		private function stage_resizeHandler(event:Event):void
		{
			_starling.stage.stageWidth = stage.stageWidth;
			_starling.stage.stageHeight = stage.stageHeight;
			
			const viewPort:Rectangle = _starling.viewPort;
			viewPort.width = stage.stageWidth;
			viewPort.height = stage.stageHeight;
			try
			{
				_starling.viewPort = viewPort;
			}
			catch(error:Error) {}
			//_starling.showStatsAt(HAlign.LEFT, VAlign.BOTTOM);
		}
		
		private function stage_deactivateHandler(event:Event):void
		{
			_starling.stop();
			stage.addEventListener(Event.ACTIVATE, stage_activateHandler, false, 0, true);
		}
		
		private function stage_activateHandler(event:Event):void
		{
			stage.removeEventListener(Event.ACTIVATE, stage_activateHandler);
			_starling.start();
		}
	}
}