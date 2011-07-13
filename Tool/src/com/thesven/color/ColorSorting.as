package com.thesven.color {
	/**
	 * @author mikesven
	 */
	public class ColorSorting {
		
		public static function sortColorHSL(color1:String, color2:String):Number{
			
			//sorting based on HSL
			
			var rgb1 : Vector.<Number> = ColorSpaceConversionUtil.hexToRGB(color1);
			var rgb2 : Vector.<Number> = ColorSpaceConversionUtil.hexToRGB(color2);
			
			var hsl1:Vector.<Number> = ColorSpaceConversionUtil.rgbToHSL(rgb1);
			var hsl2:Vector.<Number> = ColorSpaceConversionUtil.rgbToHSL(rgb2);
			
			var toReturn:Number;
			
			if(hsl1[0] <= hsl2[0]) toReturn = -1;
			if(hsl1[0] >= hsl2[0]) toReturn = 1;
			if(hsl1[0] == hsl2[0]) toReturn = 0;
			
			if(hsl1[0] == hsl2[0] && hsl1[1] == hsl2[1]) toReturn = 0;
			if(hsl1[0] == hsl2[0] && hsl1[1] <= hsl2[1]) toReturn = -1;
			if(hsl1[0] == hsl2[0] && hsl1[1] >= hsl2[1]) toReturn = 1;
			
			if(hsl1[0] == hsl2[0] && hsl1[1] == hsl2[1] && hsl1[2] == hsl2[2]) toReturn = 0;
			if(hsl1[0] == hsl2[0] && hsl1[1] == hsl2[1] && hsl1[2] <= hsl2[2]) toReturn = -1;
			if(hsl1[0] == hsl2[0] && hsl1[1] == hsl2[1] && hsl1[2] >= hsl2[2]) toReturn = 1;
			
			return toReturn;
			
		}
		
		public static function sortColorHSV(color1:String, color2:String):Number{
			
			var rgb1 : Vector.<Number> = ColorSpaceConversionUtil.hexToRGB(color1);
			var rgb2 : Vector.<Number> = ColorSpaceConversionUtil.hexToRGB(color2);
			
			var hsv1:Vector.<Number> = ColorSpaceConversionUtil.rgbToHsv(rgb1);
			var hsv2:Vector.<Number> = ColorSpaceConversionUtil.rgbToHsv(rgb2);
			
			var toReturn:Number;
			
			if(hsv1[0] <= hsv2[0]) toReturn = -1;
			if(hsv1[0] >= hsv2[0]) toReturn = 1;
			if(hsv1[0] == hsv2[0]) toReturn = 0;
			
			if(hsv1[0] == hsv2[0] && hsv1[1] == hsv2[1]) toReturn = 0;
			if(hsv1[0] == hsv2[0] && hsv1[1] <= hsv2[1]) toReturn = -1;
			if(hsv1[0] == hsv2[0] && hsv1[1] >= hsv2[1]) toReturn = 1;
			
			if(hsv1[0] == hsv2[0] && hsv1[1] == hsv2[1] && hsv1[2] == hsv2[2]) toReturn = 0;
			if(hsv1[0] == hsv2[0] && hsv1[1] == hsv2[1] && hsv1[2] <= hsv2[2]) toReturn = -1;
			if(hsv1[0] == hsv2[0] && hsv1[1] == hsv2[1] && hsv1[2] >= hsv2[2]) toReturn = 1;
			
			return toReturn;
			
		}
		
		public static function sortColorLAB(color1:String, color2:String):Number{
			
			var rgb1 : Vector.<Number> = ColorSpaceConversionUtil.hexToRGB(color1);
			var rgb2 : Vector.<Number> = ColorSpaceConversionUtil.hexToRGB(color2);
			
			var xyz1:Vector.<Number> = ColorSpaceConversionUtil.rgbToXYZ(rgb1);
			var xyz2:Vector.<Number> = ColorSpaceConversionUtil.rgbToXYZ(rgb2);
			
			var lab1:Vector.<Number> = ColorSpaceConversionUtil.xyzToLAB(xyz1);
			var lab2:Vector.<Number> = ColorSpaceConversionUtil.xyzToLAB(xyz2);
			
			var toReturn:Number;
			if(lab1[0] <= lab2[0]) toReturn = -1;
			if(lab1[0] >= lab2[0]) toReturn = 1;
			if(lab1[0] == lab2[0]) toReturn = 0;
			
			if(lab1[0] == lab2[0] && lab1[1] == lab2[1]) toReturn = 0;
			if(lab1[0] == lab2[0] && lab1[1] <= lab2[1]) toReturn = -1;
			if(lab1[0] == lab2[0] && lab1[1] >= lab2[1]) toReturn = 1;
			
			if(lab1[0] == lab2[0] && lab1[1] == lab2[1] && lab1[2] == lab2[2]) toReturn = 0;
			if(lab1[0] == lab2[0] && lab1[1] == lab2[1] && lab1[2] <= lab2[2]) toReturn = -1;
			if(lab1[0] == lab2[0] && lab1[1] == lab2[1] && lab1[2] >= lab2[2]) toReturn = 1;
			
			return toReturn;
			
		}
		
	}
}
