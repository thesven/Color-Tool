package com.thesven.image.jpeg.colortable {
	import com.thesven.color.ColorSorting;

	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * @author mikesven
	 */
	public class JPEGAverageColorTable {
		
		public static function averageColours( source:BitmapData, colours:int ):Vector.<String>{
			var averages:Vector.<String> = new Vector.<String>();
			var columns:int = Math.round( Math.sqrt( colours ) );
		
			var row:int = 0;
			var col:int = 0;
		
			var x:int = 0;
			var y:int = 0;
		
			var w:int = Math.round( source.width / columns );
			var h:int = Math.round( source.height / columns );
		
			for (var i:int = 0; i < colours; i++)
			{
				var rect:Rectangle = new Rectangle( x, y, w, h );
		
				var box:BitmapData = new BitmapData( w, h, false );
				box.copyPixels( source, rect, new Point() );
		
				averages.push( "0x" + averageColour( box ).toString(16) );
				box.dispose();
		
				col = i % columns;
		
				x = w * col;
				y = h * row;
		
				if ( col == columns - 1 ) row++;
			}
			
			removeDup(averages);
			averages.sort(ColorSorting.sortColorHSL);
			
			return averages;
		}
		
		public static function averageColour( source:BitmapData ):uint{
			var red:Number = 0;
			var green:Number = 0;
			var blue:Number = 0;
		
			var count:Number = 0;
			var pixel:Number;
		
			for (var x:int = 0; x < source.width; x++)
			{
				for (var y:int = 0; y < source.height; y++)
				{
					pixel = source.getPixel(x, y);
		
					red += pixel >> 16 & 0xFF;
					green += pixel >> 8 & 0xFF;
					blue += pixel & 0xFF;
		
					count++;
				}
			}
		
			red /= count;
			green /= count;
			blue /= count;
		
			return red << 16 | green << 8 | blue;
		}
		
		private static function removeDup(ac:Vector.<String>):void{
			
		    for (var i:int = 0; i < ac.length - 1; i++){
				for (var j:int = i + 1; j < ac.length; j++){
		        
					if (ac[i] === ac[j]){
		                ac.splice(j, 1);
					}
				    
				}
			}
		}
		
		
	}
}
