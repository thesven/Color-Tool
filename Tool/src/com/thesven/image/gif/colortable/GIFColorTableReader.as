/*
 *bytes 0-5 are the header bytes
 *bytes 6-12 are the logical screen descriptor 6-7 canvas width, 8-9 canvas height 10 is the packed field, 11 background color index, 12 pixel aspec ratio
 */

package com.thesven.image.gif.colortable {
	import com.thesven.color.ColorSorting;

	import flash.utils.ByteArray;
	/**
	 * @author mikesven
	 */
	public class GIFColorTableReader {
		
		private static const HEX_CONV_VALUES:Vector.<String> = new Vector.<String>();
		private static const BYTE_VALUES:Vector.<uint> = new Vector.<uint>();
		private static const VALID_SIGNATURE_VALUES:Vector.<uint> = new Vector.<uint>();
		
		{
			// populate the hex conversion values vector
			HEX_CONV_VALUES.push(0);
			HEX_CONV_VALUES.push(1);
			HEX_CONV_VALUES.push(2);
			HEX_CONV_VALUES.push(3);
			HEX_CONV_VALUES.push(4);
			HEX_CONV_VALUES.push(5);
			HEX_CONV_VALUES.push(6);
			HEX_CONV_VALUES.push(7);
			HEX_CONV_VALUES.push(8);
			HEX_CONV_VALUES.push(9);
			HEX_CONV_VALUES.push("A");
			HEX_CONV_VALUES.push("B");
			HEX_CONV_VALUES.push("C");
			HEX_CONV_VALUES.push("D");
			HEX_CONV_VALUES.push("E");
			HEX_CONV_VALUES.push("F");
			
			BYTE_VALUES.push(128);
			BYTE_VALUES.push(64);
			BYTE_VALUES.push(32);
			BYTE_VALUES.push(16);
			BYTE_VALUES.push(8);
			BYTE_VALUES.push(4);
			BYTE_VALUES.push(2);
			BYTE_VALUES.push(1);
			
			//valid GIF89a header
			VALID_SIGNATURE_VALUES.push(47);
			VALID_SIGNATURE_VALUES.push(49);
			VALID_SIGNATURE_VALUES.push(46);
			VALID_SIGNATURE_VALUES.push(38);
			VALID_SIGNATURE_VALUES.push(39);
			VALID_SIGNATURE_VALUES.push(61);
		}
		
		public static function readTable(gifBytes:ByteArray):Vector.<String>{
			
			if(!checkForValidGIF98a(gifBytes)) throw new Error('GIFColorTableReader is only capable of parsing data from GIF98a format files');
			
			//find the color table size
			gifBytes.position = 10;
			var value:uint = gifBytes.readUnsignedByte();
			var lengthBinary:String = '00000' + byte2bin(value).slice(5, 8); //only the last 3 values of the binary are used for calulating the length
			var tableValue:int = binary2int(lengthBinary);
			var tableSize:int = Math.pow( 2, ( tableValue + 1) );
			
			//start to read the table bytes
			gifBytes.position = 13; //starting position for the Global Color Table
			
			var colorTable:Vector.<String> = new Vector.<String>();
			
			//loop over and gather all of the color info from the byte array.
			//each color will be comprised of 3 bytes r,g,b
			var i:int = 0;
			for(i; i < tableSize; i++){
				
				var r:uint = gifBytes.readUnsignedByte();
				var g:uint = gifBytes.readUnsignedByte();
				var b:uint = gifBytes.readUnsignedByte();
				var hex:String = "0x" + byte2hex(r)+byte2hex(g)+byte2hex(b);
				
				colorTable.push(hex);
			}
			
			colorTable.sort(ColorSorting.sortColorHSL);
			
			return colorTable;
			
		}
		
		private static function byte2hex( byte:uint ):String{
			
			if( byte > 255 ) byte = 255;
			var l:int = byte / 16;
			var r:int = byte % 16;
			
			return HEX_CONV_VALUES[l]+HEX_CONV_VALUES[r];
		
		}
		
		private static function byte2bin(byte:uint):String{
			
		    var bin:String = '';
		    
		    for(var i:uint = 0; i < 8; i++) {
		        bin += String((byte & (0x80 >> i)) >> (7 - i));
		    }
		    
		    return bin;
		
		}
		
		private static function binary2int(binary:String):Number{
			
			var decValue:Number = 0;
			var length: int = binary.length;
			for(var i:int = 0; i < length; i++){
				decValue += BYTE_VALUES[i] * Number(binary.charAt(i));
			}
			
			return decValue;
		}
		
		private static function checkForValidGIF98a(bytes:ByteArray):Boolean{
			
			bytes.position = 0;
			var totalLength:int = VALID_SIGNATURE_VALUES.length;
			var i:int = 0;
			for(i; i<totalLength; i++){
				var byte:int = bytes.readUnsignedByte();
				if(uint(byte2hex(byte)) != VALID_SIGNATURE_VALUES[i]) return false;
			}
			
			return true;
			
		}
		
	}
}
