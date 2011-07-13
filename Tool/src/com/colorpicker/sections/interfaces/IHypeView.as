package com.colorpicker.sections.interfaces {
	import flash.display.IBitmapDrawable;

	/**
	 * @author mikesven
	 */
	public interface IHypeView extends IBitmapDrawable {
		
		function init(colorList:Vector.<String>):void;
		function reset(colorList:Vector.<String>):void;
		function destroy():void;
		
	}
}
