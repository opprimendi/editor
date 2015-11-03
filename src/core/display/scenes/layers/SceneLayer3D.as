package core.display.scenes.layers 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.core.base.Object3D;
	import away3d.debug.AwayStats;
	import core.IUpdatable;
	import core.WorldStep;
	import flash.display3D.Context3DProfile;
	
	public class SceneLayer3D extends SceneLayer implements IUpdatable
	{
		public var scene:Scene3D;
		public var view:View3D;
		
		public function SceneLayer3D(camera3D:Camera3D = null, profile:String = Context3DProfile.BASELINE) 
		{
			super();
			
			scene = new Scene3D();
			view = new View3D(scene, camera3D, null, null, profile);
			
			//TODO: view params should be setup via special method and use viewParamsObject
			view.antiAlias = 4;
			
			addChild(view);
		}
		
		public function showStats():void
		{
			addChild(new AwayStats(view));
		}
		
		/**
		 * Add child to scene3D
		 * @param	child
		 * @return
		 */
		public function addChild3D(child:ObjectContainer3D):ObjectContainer3D
		{
			return scene.addChild(child);
		}
		
		/**
		 * Remove child from scene3D
		 * @param	child
		 */
		public function removeChild3D(child:ObjectContainer3D):void
		{
			scene.removeChild(child);
		}
		
		/**
		 * Update controllers and view
		 */
		override public function update(worldStep:WorldStep = null):void 
		{
			view.render();
			//view.renderer.context.enableErrorChecking = true;
		}
	}
}