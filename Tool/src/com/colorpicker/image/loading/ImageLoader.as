//http://blog.soulwire.co.uk/code/actionscript-3/extract-average-colours-from-bitmapdata
package com.colorpicker.image.loading {
	import flash.events.ProgressEvent;
	import flash.net.FileFilter;
	import flash.events.SecurityErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * @author mikesven
	 */
	public class ImageLoader extends EventDispatcher {
		
		private var fileRef:FileReference;
		private var extension:String;
		
		public function ImageLoader() {
	
			init();		
		
		}
		
		private function init():void{
			
			fileRef = new FileReference();
			fileRef.addEventListener(Event.SELECT, onFileSelect);
			fileRef.browse([new FileFilter("Images", "*.gif;*.jpg;*.jpeg;*.JPG;*.JPEG")]);
			
		}
		
		private function onFileSelect(e : Event) : void {
			
			fileRef.removeEventListener(Event.SELECT, onFileSelect);
			fileRef.addEventListener(Event.COMPLETE, onFileLoadComplete);
			fileRef.addEventListener(ProgressEvent.PROGRESS, onFileLoadProgress);
			
			extension = fileRef.extension;
			
			fileRef.load();
		
		}

		private function onFileLoadComplete(e : Event) : void {
			
			fileRef.removeEventListener(Event.COMPLETE, onFileLoadComplete);
			fileRef.removeEventListener(ProgressEvent.PROGRESS, onFileLoadProgress);
			
			dispatchEvent(new ImageLoadingEvent(ImageLoadingEvent.IMAGE_LOADED, fileRef.data, extension, true, false));
			
			fileRef = null;
		}

		private function onFileLoadProgress(e : ProgressEvent) : void {
			dispatchEvent(e);
		}
		
		

		
	}
}
