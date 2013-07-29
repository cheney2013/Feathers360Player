package cn.is360.theme
{
	import cn.is360.controls.PlayButton;
	import cn.is360.controls.VideoTime;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.DisplayListWatcher;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	
	import flash.text.TextFormat;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class YouKuPlayerTheme extends DisplayListWatcher
	{
		protected static const DEFAULT_TEXT_COLOR:uint = 0x72D1E9;
		
		[Embed(source="/../assets/images/pause_up.png")]
		protected var pauseButtonUpSkin:Class;
		
		[Embed(source="/../assets/images/pause_over.png")]
		protected var pauseButtonOverSkin:Class;
		
		[Embed(source="/../assets/images/pause_down.png")]
		protected var pauseButtonDownSkin:Class;
		
		[Embed(source="/../assets/images/pause_disable.png")]
		protected var pauseButtonDisableSkin:Class;
		
		[Embed(source="/../assets/images/play_up.png")]
		protected var playButtonUpSkin:Class;
		
		[Embed(source="/../assets/images/play_over.png")]
		protected var playButtonOverSkin:Class;
		
		[Embed(source="/../assets/images/play_down.png")]
		protected var playButtonDownSkin:Class;
		
		[Embed(source="/../assets/images/play_disable.png")]
		protected var playButtonDisableSkin:Class;
		
		[Embed(source="/../assets/images/videotime_bg.png")]
		protected var videoTimeSkin:Class; 
		
		protected var _scaleToDPI:Boolean;
		
		protected var videoTimeTextFormat:TextFormat;
		
		public function YouKuPlayerTheme(container:DisplayObjectContainer=null, scaleToDPI:Boolean=true)
		{
			if(!container)
			{
				container = Starling.current.stage;
			}
			super(container)
			_scaleToDPI = scaleToDPI;
			initialize();
		}
		
		protected static function textRendererFactory():ITextRenderer
		{
			const renderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			renderer.embedFonts = true;
			return renderer;
		}
		
		protected function initialize():void
		{
			FeathersControl.defaultTextRendererFactory = textRendererFactory;
			
			videoTimeTextFormat = new TextFormat("Arial", 12, DEFAULT_TEXT_COLOR);
			
			setInitializerForClass( PlayButton, playButtonInitializer );
			setInitializerForClass( VideoTime, videoTimeInitializer );
			setInitializerForClass( Label, videoTimeLabelInitializer, VideoTime.VIDEO_TIME_LABEL );
		}
		
		private function playButtonInitializer( button:PlayButton ):void
		{
			button.upSkin = new Image(Texture.fromBitmap(new pauseButtonUpSkin(), false));
			button.hoverSkin = new Image(Texture.fromBitmap(new pauseButtonOverSkin(), false));
			button.downSkin = new Image(Texture.fromBitmap(new pauseButtonDownSkin(), false));
			button.disabledSkin = new Image(Texture.fromBitmap(new pauseButtonDisableSkin(), false));
			
			button.selectedUpSkin = new Image(Texture.fromBitmap(new playButtonUpSkin(), false));
			button.selectedHoverSkin = new Image(Texture.fromBitmap(new playButtonOverSkin(), false));
			button.selectedDownSkin = new Image(Texture.fromBitmap(new playButtonDownSkin(), false));
			button.selectedDisabledSkin = new Image(Texture.fromBitmap(new playButtonDisableSkin(), false));
		}
		
		private function videoTimeInitializer( videoTime:VideoTime ):void
		{
			videoTime.background = Texture.fromBitmap(new videoTimeSkin(), false);
		}
		
		private function videoTimeLabelInitializer( label:Label ):void
		{
			label.textRendererProperties.textFormat = videoTimeTextFormat;
		}
	}
}