package cn.is360.controls
{
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	
	import starling.display.DisplayObject;
	import starling.textures.Texture;
	
	public class VideoTime extends FeathersControl
	{
		
		/**
		 * The default value added to the <code>nameList</code> of the label.
		 *
		 * @see feathers.core.IFeathersControl#nameList
		 */
		public static const VIDEO_TIME_LABEL:String = "video-time-label";
		
		protected var _background:ImageLoader;
		
		/**
		 * The value added to the <code>nameList</code> of the label. This
		 * variable is <code>protected</code> so that sub-classes can customize
		 * the label name in their constructors instead of using the default
		 * name defined by <code>DEFAULT_CHILD_NAME_LABEL</code>.
		 *
		 * <p>For internal use in subclasses.</p>
		 *
		 * @see feathers.core.IFeathersControl#nameList
		 */
		protected var labelName:String = VIDEO_TIME_LABEL;
		
		/**
		 * The text renderer for the button's label.
		 *
		 * <p>For internal use in subclasses.</p>
		 */
		protected var labelTextRenderer:ITextRenderer;
		
		/**
		 * @private
		 */
		protected var _labelFactory:Function;
		
		/**
		 * A function used to instantiate the button's label text renderer
		 * sub-component. By default, the button will use the global text
		 * renderer factory, <code>FeathersControl.defaultTextRendererFactory()</code>,
		 * to create the label text renderer. The label text renderer must be an
		 * instance of <code>ITextRenderer</code>. To change properties on the
		 * label text renderer, see <code>defaultLabelProperties</code> and the
		 * other "<code>LabelProperties</code>" properties for each button
		 * state.
		 *
		 * <p>The factory should have the following function signature:</p>
		 * <pre>function():ITextRenderer</pre>
		 *
		 * <p>The following example gives the button a custom factory for the
		 * label text renderer:</p>
		 *
		 * <listing version="3.0">
		 * button.labelFactory = function():ITextRenderer
		 * {
		 *     return new TextFieldTextRenderer();
		 * }</listing>
		 *
		 * @default null
		 *
		 * @see feathers.core.ITextRenderer
		 * @see feathers.core.FeathersControl#defaultTextRendererFactory
		 * @see feathers.controls.text.BitmapFontTextRenderer
		 * @see feathers.controls.text.TextFieldTextRenderer
		 */
		public function get labelFactory():Function
		{
			return _labelFactory;
		}
		
		/**
		 * @private
		 */
		public function set labelFactory(value:Function):void
		{
			if(_labelFactory == value)
			{
				return;
			}
			_labelFactory = value;
			invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
		}
		
		public function VideoTime()
		{
			super();
		}
		
		/**
		 * @private
		 */
		protected var _label:String = "00:00/00:00";
		
		/**
		 * The text displayed on the button.
		 *
		 * <p>The following example gives the button some label text:</p>
		 *
		 * <listing version="3.0">
		 * button.label = "Click Me";</listing>
		 *
		 * @default null
		 */
		public function get label():String
		{
			return _label;
		}
		
		/**
		 * @private
		 */
		public function set label(value:String):void
		{
			if(_label == value)
			{
				return;
			}
			_label = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		
		public function set background(value:Texture):void
		{
			if (!_background)
			{
				_background = new ImageLoader();				
			}
			
			_background.source = value;
		}
		
		protected function instantiate():void
		{
			
		}

		override protected function initialize():void
		{
			addChild(_background);
		}
		
		/**
		 * Creates the label text renderer.
		 *
		 * <p>For internal use in subclasses.</p>
		 */
		protected function createLabel():void
		{
			if(labelTextRenderer)
			{
				removeChild(DisplayObject(labelTextRenderer), true);
				labelTextRenderer = null;
			}
			
			const factory:Function = _labelFactory != null ? _labelFactory : FeathersControl.defaultTextRendererFactory;
			labelTextRenderer = ITextRenderer(factory());
			labelTextRenderer.nameList.add(labelName);
			addChild(DisplayObject(labelTextRenderer));
		}
		
		/**
		 * @private
		 */
		protected function refreshLabelData():void
		{
			labelTextRenderer.text = _label;
			labelTextRenderer.visible = _label && _label.length > 0;
		}
		
		override protected function draw():void
		{
			const dataInvalid:Boolean = isInvalid(INVALIDATION_FLAG_DATA);
			const textRendererInvalid:Boolean = isInvalid(INVALIDATION_FLAG_TEXT_RENDERER);
			
			if(textRendererInvalid)
			{
				createLabel();
			}
			
			if(textRendererInvalid || dataInvalid)
			{
				refreshLabelData();
			}
			layout();
		}
		
		protected function layout():void
		{
//			_label.validate();
//			
//			_label.x = (actualWidth - _label.width) / 2;
//			_label.y = (actualHeight - _label.height) / 2;
		}
	}
}