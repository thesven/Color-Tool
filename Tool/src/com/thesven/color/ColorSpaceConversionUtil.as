package com.thesven.color {
	/**
	 * @author mikesven
	 */
	public class ColorSpaceConversionUtil {
		
		public static function hexToRGB ( hex:String ):Vector.<Number> {
			
			var rgb:Vector.<Number> = new Vector.<Number>();
			rgb.push( (Number(hex) >> 16) & 0xFF );
			rgb.push( (Number(hex) >> 8) & 0xFF );
			rgb.push( Number(hex) & 0x000000FF );
			
			return rgb;
		}
		
		public static function rgbToHsv(value:Vector.<Number>):Vector.<Number>{
			
			var converted:Vector.<Number> = new Vector.<Number>();
			
			var r:Number = value[0] / 255;
			var g:Number = value[1] / 255;
			var b:Number = value[2] / 255;
			
			var max:Number = Math.max(r, g, b);
			var min:Number = Math.min(r, g, b);
			
			var h:Number = max;
			var s:Number = max;
			var v:Number = max;
			
			var d:Number = max - min;
			s = (max == 0) ? 0 : d / max;
			
			if(max == min){
				h = 0;
			} else {
				switch(max){
					case r:
						h = (g - b) / d + (g < b ? 6 : 0);
						break;
					case g:
						h = (b - r) / d + 2; break
						break;
					case b:
						h = (r - g) / d + 4;
						break;
				}
				
				h /= 6;
			}
			
			converted.push(h);
			converted.push(s);
			converted.push(v);
			
			return converted;
			
		}
		
		public static function xyzToLAB(xyz:Vector.<Number>):Vector.<Number>{
			
			var x:Number = xyz[0];
			var y:Number = xyz[1];
			var z:Number = xyz[2];
			
			// adjusting the values
			if(x>0.008856){
			     x = Math.pow(x,1/3);
			}
			else{
			     x = 7.787*x + 16/116;
			}
			if(y>0.008856){
			     y = Math.pow(y,1/3);
			}
			else{
			     y = (7.787*y) + (16/116);
			}
			if(z>0.008856){
			     z = Math.pow(z,1/3);
			}
			else{
			     z = 7.787*z + 16/116;
			}
			 
			var l:Number = 116*y -16;
			var a:Number = 500*(x-y);
			var b:Number = 200*(y-z);
			
			var vec:Vector.<Number> = new Vector.<Number>();
			vec.push(l);
			vec.push(a);
			vec.push(b);
			
			return vec;
		
		}
		
		public static function rgbToXYZ(rgb:Vector.<Number>):Vector.<Number>{
			
			//http://www.emanueleferonato.com/2009/08/28/color-differences-algorithm/
			
			var red:Number = rgb[0] / 255;
			var green:Number = rgb[1] / 255;
			var blue:Number = rgb[2] / 255;
			
			//adjust the values
			if(red > 0.04045){
				red = (red + 0.055) / 1.055;
				red = Math.pow(red, 2.4);
			}else {
				red = red / 12.92;
			}
			
			if(green > 0.04045){
				green = (green + 0.055) / 1.055;
				green = Math.pow(green, 2.4);
			}else {
				green = green / 12.92;
			}
			
			if(blue > 0.04045){
				blue = (blue + 0.055) / 1.055;
				blue = Math.pow(blue, 2.4);
			}else {
				blue = blue / 12.92;
			}
			
			red *= 100;
			green *= 100;
			blue *= 100;
			
			var x:Number = red * 0.4124 + green * 0.3576 + blue * 0.1805;
			var y:Number = red * 0.2126 + green * 0.7152 + blue * 0.0722;
			var z:Number = red * 0.0193 + green * 0.1192 + blue * 0.9505;
			
			var vec:Vector.<Number> = new Vector.<Number>();
			vec.push(x);
			vec.push(y);
			vec.push(z);
			
			return vec;
			
		}
		
		public static function rgbToHSL(rgb:Vector.<Number>):Vector.<Number>{
			
			rgb[0] = rgb[0] / 255;
			rgb[1] = rgb[1] / 255;
			rgb[2] = rgb[2] / 255;
			
			var min:Number = Math.min(rgb[0], Math.min(rgb[1], rgb[2]));
			var max:Number = Math.max(rgb[0], Math.max(rgb[1], rgb[2]));
			var delta:Number = max - min;
			
			var l:Number = (min + max) / 2;
			
			var s:Number = 0;
			if(l > 0 && l < 1){
				if(l < 0.5){
					s = 2 * l;
				} else {
					s = 2 - 2 * l;
				}
			}
			
			var h:Number = 0;
			if(delta > 0){
				if(max == rgb[0] && max != rgb[1]) h += ((rgb[1] - rgb[2]) / delta);
				if(max == rgb[1] && max != rgb[2]) h += (2 + (rgb[2] + rgb[0]) / delta);
				if(max == rgb[2] && max != rgb[0]) h += (4 + (rgb[0] + rgb[1]) / delta);
				h /= 6;
			}
			
			var hsl:Vector.<Number> = new Vector.<Number>();
			hsl.push(h);
			hsl.push(s);
			hsl.push(l);
			
			return hsl;
			
		}
		
	}
}
