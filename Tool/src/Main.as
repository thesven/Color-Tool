package 
{
	import com.colorpicker.clipboard.ClipboardCopy;
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;
	import com.colorpicker.image.loading.ImageLoader;
	import com.colorpicker.image.loading.ImageLoadingEvent;
	import com.colorpicker.sections.hypeview.GridView;
	import com.colorpicker.sections.hypeview.SwarmView;
	import com.colorpicker.sections.interfaces.IHypeView;
	import com.colorpicker.sections.palletview.PalletView;
	import com.colorpicker.sections.palletview.events.PalletChangeEvent;
	import com.thesven.image.gif.colortable.GIFColorTableReader;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;


	[SWF(backgroundColor="#000000", frameRate="31", width="1024", height="768")]
	public class Main extends Sprite
	{
		
		private var mainControllWindow:Window;
		private var mainControllContainer:VBox;
		
		private var imageLoadingButton:PushButton;
		private var gridViewButton:PushButton;
		private var swarmViewButton:PushButton;
		private var copyToClipBoard:PushButton;
		
		private var palletViewWindow:Window;
		private var palletView:PalletView;
		
		private var hypeWindow:Window;
		private var hypeView:IHypeView;
		private var currentHypeViewType:Class = GridView;
		
		private var currentColorList:Vector.<String>;
		
		public function Main()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void{
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			mainControllWindow = new Window();
			mainControllWindow.setSize(200, 200);
			mainControllWindow.draggable = false;
			mainControllWindow.move(10, 10);
			mainControllWindow.title = "Main Controll";
			addChild(mainControllWindow);
			
			mainControllContainer = new VBox();
			mainControllContainer.y = 10;
			mainControllWindow.content.addChild(mainControllContainer);
			
			imageLoadingButton = new PushButton();
			imageLoadingButton.label = "Load Image";
			imageLoadingButton.x = 10;
			imageLoadingButton.setSize(180, 20);
			imageLoadingButton.addEventListener(MouseEvent.CLICK, onImageLoadButtonClick);
			mainControllContainer.addChild(imageLoadingButton);
			
			gridViewButton = new PushButton();
			gridViewButton.label = "Use Grid View";
			gridViewButton.x = 10;
			gridViewButton.setSize(180, 20);
			gridViewButton.addEventListener(MouseEvent.CLICK, onHypeViewButtonClick);
			mainControllContainer.addChild(gridViewButton);
			
			swarmViewButton = new PushButton();
			swarmViewButton.label = "Use Swarm View";
			swarmViewButton.x = 10;
			swarmViewButton.setSize(180, 20);
			swarmViewButton.addEventListener(MouseEvent.CLICK, onHypeViewButtonClick);
			mainControllContainer.addChild(swarmViewButton);
			
			copyToClipBoard = new PushButton();
			copyToClipBoard.label = "Copy Color List To Clipboard";
			copyToClipBoard.x = 10;
			copyToClipBoard.setSize(180, 20);
			copyToClipBoard.addEventListener(MouseEvent.CLICK, onDoListCopy);
			mainControllContainer.addChild(copyToClipBoard);
			
			palletViewWindow = new Window();
			palletViewWindow.setSize(794, 200);
			palletViewWindow.draggable = false;
			palletViewWindow.move(220, 10);
			palletViewWindow.title = "Pallet View";
			addChild(palletViewWindow);
			
			hypeWindow = new Window();
			hypeWindow.draggable = false;
			hypeWindow.title = "Hype View";
			hypeWindow.setSize(1004, 495);
			hypeWindow.move(10, 220);
			addChild(hypeWindow);
			
		}

		private function onDoListCopy(e:MouseEvent) : void {
			ClipboardCopy.CopyToClipboard(currentColorList);
		}
		
		private function onImageLoadButtonClick(e:MouseEvent):void{
			
			var imageLoader:ImageLoader = new ImageLoader();
			imageLoader.addEventListener(ImageLoadingEvent.GIF_IMAGE_LOADED, onImageDataReady);
			if(palletView) palletView.clearPalletView();
			
		}
		
		private function onHypeViewButtonClick(e:MouseEvent) : void {
		
			var target:String = PushButton(e.target).label;
			
			switch(target){
				case "Use Grid View":
					currentHypeViewType = GridView;
					break;
				case "Use Swarm View":
					currentHypeViewType = SwarmView;
					break;
			}
		
			addHypeView();
		
		}

		private function onImageDataReady(e : ImageLoadingEvent) : void {
			
			currentColorList = GIFColorTableReader.readTable(e.data);
			
			ImageLoader(e.target).removeEventListener(ImageLoadingEvent.GIF_IMAGE_LOADED, onImageDataReady);
			
			initPalletView();
			addHypeView();
			
		}
		
		private function initPalletView():void{
			
			palletView = new PalletView(currentColorList, palletViewWindow.width, palletViewWindow.height - 20);
			palletView.addEventListener(PalletChangeEvent.PALLET_CHANGE, updateColors);
			palletViewWindow.content.addChild(palletView);
			
		}
		
		private function addHypeView():void{
			
			if(hypeView != null){
				hypeWindow.content.removeChild(hypeView as DisplayObject);
				hypeView.destroy();
				hypeView = null;
			}
			
			hypeView = new currentHypeViewType();
			hypeWindow.addChild(DisplayObject(hypeView));
			hypeView.init(currentColorList);
			
		}
		
		private function updateColors(e:PalletChangeEvent):void{
			
			currentColorList = e.pallet;
			if(hypeView) hypeView.reset(currentColorList);
			
		}
			
		
	}
}
