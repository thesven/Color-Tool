package 
{
	import com.thesven.color.ColorSorting;
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
		private var sortHSLButton:PushButton;
		private var sortHSVButton:PushButton;
		private var sortCIELABButton:PushButton;
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
			mainControllWindow.setSize(200, 210);
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
			
			sortHSLButton = new PushButton();
			sortHSLButton.label = "Sort on HSL Values";
			sortHSLButton.x = 10;
			sortHSLButton.setSize(180, 20);
			sortHSLButton.addEventListener(MouseEvent.CLICK, onSortButtonClick);
			mainControllContainer.addChild(sortHSLButton);
			
			sortHSVButton = new PushButton();
			sortHSVButton.label = "Sort on HSV Values";
			sortHSVButton.x = 10;
			sortHSVButton.setSize(180, 20);
			sortHSVButton.addEventListener(MouseEvent.CLICK, onSortButtonClick);
			mainControllContainer.addChild(sortHSVButton);
			
			sortCIELABButton = new PushButton();
			sortCIELABButton.label = "Sort on LAB Values";
			sortCIELABButton.x = 10;
			sortCIELABButton.setSize(180, 20);
			sortCIELABButton.addEventListener(MouseEvent.CLICK, onSortButtonClick);
			mainControllContainer.addChild(sortCIELABButton);
			
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
			palletViewWindow.setSize(794, 210);
			palletViewWindow.draggable = false;
			palletViewWindow.move(220, 10);
			palletViewWindow.title = "Pallet View";
			addChild(palletViewWindow);
			
			hypeWindow = new Window();
			hypeWindow.draggable = false;
			hypeWindow.title = "Hype View";
			hypeWindow.setSize(1004, 485);
			hypeWindow.move(10, 230);
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
		
			switch(PushButton(e.target).label){
				case "Use Grid View":
					currentHypeViewType = GridView;
					break;
				case "Use Swarm View":
					currentHypeViewType = SwarmView;
					break;
			}
		
			addHypeView();
		
		}
		
		private function onSortButtonClick(e : MouseEvent) : void {
			
			switch(PushButton(e.target).label){
				case "Sort on HSL Values":
					currentColorList.sort(ColorSorting.sortColorHSL);
					break;
				case "Sort on HSV Values":
					currentColorList.sort(ColorSorting.sortColorHSV);
					break;
				case "Sort on LAB Values":
					currentColorList.sort(ColorSorting.sortColorLAB);
					break;
			}
			
			if(palletView) initPalletView();
			if(hypeView) hypeView.reset(currentColorList);
		}

		private function onImageDataReady(e : ImageLoadingEvent) : void {
			
			currentColorList = GIFColorTableReader.readTable(e.data);
			
			ImageLoader(e.target).removeEventListener(ImageLoadingEvent.GIF_IMAGE_LOADED, onImageDataReady);
			
			initPalletView();
			addHypeView();
			
		}
		
		private function initPalletView():void{
			
			if(palletView){
				palletView.destroy();
				palletView = null; 
			}
			
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
