package com.colorpicker.clipboard {
	import flash.desktop.ClipboardFormats;
	import flash.desktop.Clipboard;
	/**
	 * @author mikesven
	 */
	public class ClipboardCopy {
		
		public static function CopyToClipboard(values:Vector.<String>):void{
		
			var toCopy:String = createStringList(values);
			
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, toCopy);
			
		}
		
		private static function createStringList(values:Vector.<String>):String{
			
			var s:String = "";
			
			var len:int = values.length;
			var i:int = 0;
			for(i; i < len; i++){
				s += values[i];
				if(i < len -1) s+= ", ";
			}
			
			return s;
		}
		
	}
}
