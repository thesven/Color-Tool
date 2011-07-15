package com.colorpicker.sections.hypeview {
	import hype.framework.rhythm.SimpleRhythm;
	import flash.geom.ColorTransform;
	import hype.framework.display.BitmapCanvas;
	import hype.extended.behavior.Swarm;
	import hype.extended.color.ColorPool;
	import hype.framework.core.ObjectPool;
	import hype.framework.behavior.BehaviorStore;

	import com.colorpicker.sections.hypeview.utils.HypeViewUtils;
	import com.colorpicker.sections.interfaces.IHypeView;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author mikesven
	 */
	public class SwarmView extends Sprite implements IHypeView {
		
		private var objPool:ObjectPool;
		private var colorPool:ColorPool;
		private var clipContainer:Sprite;
		private var bmc:BitmapCanvas;
		private var colorTrans:ColorTransform = new ColorTransform(1, 1, 1, 1, -1, -1, -1, -1);
		private var fadeRhythm:SimpleRhythm;
		
		public function SwarmView() {
			
		}

		public function init(colorList : Vector.<String>) : void {
			
			
			objPool = new ObjectPool([Geo01, Geo02, Geo03, Geo04, Geo05], 25);
			
			colorPool = new ColorPool();
			HypeViewUtils.setColorPool(colorList, colorPool);
			
			objPool.onRequestObject = onPoolRequest;
			objPool.onReleaseObject = onPoolRelease;
			
			clipContainer = new Sprite();
			addChild(clipContainer);
			clipContainer.visible = false;
			
			bmc = new BitmapCanvas(parent.parent.width, parent.parent.height, true);
			addChild(bmc);
			bmc.startCapture(clipContainer, true);
			
			fadeRhythm = new SimpleRhythm(fadeOut);
			fadeRhythm.start();
			
			objPool.requestAll();
		}

		public function reset(colorList : Vector.<String>) : void {
			
			colorPool = new ColorPool();
			HypeViewUtils.setColorPool(colorList, colorPool);
			objPool.activeSet.forEach(reColor);
		
		}

		public function destroy() : void {
			fadeRhythm.stop();
			fadeRhythm = null;
			objPool.activeSet.forEach(startRelease);
			colorPool = null;
			objPool.destroy();
		}
		
		private function reColor(clip:MovieClip):void{
			colorPool.colorChildren(clip);
		}
		
		private function onPoolRequest(clip:MovieClip):void{
			
			clip.x = parent.parent.width / 2;
			clip.y = parent.parent.height / 2;
			clip.scaleX = clip.scaleY = (Math.random() * 0.75) + 0.5;
			
			colorPool.colorChildren(clip);
			
			var swarm:Swarm = new Swarm(clip, new Point(parent.parent.width / 2, parent.parent.height / 2), 10, 0.05, 20);
			swarm.start();
			swarm.store("swarm");
			clipContainer.addChild(clip);
			
		}
		
		private function startRelease(clip:MovieClip):void{
			objPool.release(clip);
		}
		
		private function onPoolRelease(clip:MovieClip):void{
			removeChild(clip);
		}
		
		private function fadeOut(r:SimpleRhythm):void{
			
			bmc.colorTransform(colorTrans);
			
		}
		
	}
}
