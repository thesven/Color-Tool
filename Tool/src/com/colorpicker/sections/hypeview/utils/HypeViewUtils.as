package com.colorpicker.sections.hypeview.utils {
	import hype.extended.color.ColorPool;
	/**
	 * @author mikesven
	 */
	public class HypeViewUtils {
		
		public static function setColorPool(colorList : Vector.<String>, colorPool:ColorPool):void{
			
			for each(var color:String in colorList){
				var c:uint = uint(color);
				colorPool.addColor(c);
			}
			
		}
		
	}
}
