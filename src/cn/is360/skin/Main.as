package cn.is360.skin
{
	import cn.is360.controls.PlayButton;
	import cn.is360.controls.VideoTime;
	import cn.is360.theme.YouKuPlayerTheme;
	
	import feathers.controls.Callout;
	import feathers.controls.Label;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite
	{
		public function Main()
		{
			//we'll initialize things after we've been added to the stage
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
		}
		
		/**
		 * The Feathers Button control that we'll be creating.
		 */
		protected var button:PlayButton;
		
		protected var videoTime:VideoTime;
		
		/**
		 * Where the magic happens. Start after the main class has been added
		 * to the stage so that we can access the stage property.
		 */
		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			//create the theme. this class will automatically pass skins to any
			//Feathers component that is added to the stage. components do not
			//have default skins, so you must always use a theme or skin the
			//components manually. you should always create a theme immediately
			//when your app starts up to ensure that all components are
			//properly skinned.
			//see http://wiki.starling-framework.org/feathers/themes
//			new MetalWorksMobileTheme();
			new YouKuPlayerTheme();
			
//			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
//			skinSelector.defaultValue = Texture.fromBitmap(new playButtonUpSkin() as Bitmap, false);
//			skinSelector.setValueForState(Texture.fromBitmap(new playButtonDownSkin() as Bitmap, false), Button.STATE_DOWN, false);
//			skinSelector.setValueForState(Texture.fromBitmap(new playButtonDisableSkin as Bitmap, false), Button.STATE_DISABLED, false);
//			skinSelector.displayObjectProperties =
//			{
//				width: 60,
//				height: 60,
//				textureScale: 1
//			};
			
			//create a button and give it some text to display.
			button = new PlayButton();
//			button.addEventListener(Event.CHANGE, toggleButton_changeHandler);
			
			//an event that tells us when the user has tapped the button.
//			button.addEventListener(Event.TRIGGERED, button_triggeredHandler);
			
			//add the button to the display list, just like you would with any
			//other Starling display object. this is where the theme give some
			//skins to the button.
			addChild(button);
			
			//the button won't have a width and height until it "validates". it
			//will validate on its own before the next frame is rendered by
			//Starling, but we want to access the dimension immediately, so tell
			//it to validate right now.
			button.validate();
			
			//center the button
			button.y = stage.stageHeight - button.height;
			
			videoTime = new VideoTime();
			videoTime.x = button.x + button.width;
			videoTime.y = button.y;
			addChild(videoTime);
		}
		
		private function toggleButton_changeHandler(event:Event):void
		{
			const label:Label = new Label();
			label.text = "Hi, I'm Feathers!\nHave a nice day.";
			Callout.show(label, button);
		}
	}
}