package core.display 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	import away3d.primitives.WireframePlane;
	import core.camera.CameraManager;
	import core.camera.HoverCameraController;
	import core.display.ui.UIComponent;
	import core.WorldStep;
	import flash.events.Event;
	
	public class Layer3D extends UIComponent 
	{
		
		public var scene:Scene3D;
		
		public var camera:Camera3D;
		
		private var camraManager:CameraManager;
		
		public var view:View3D;
		
		public function Layer3D() 
		{
			super();
			
			scene = new Scene3D();
		
			setupCamera();
			
			view = new View3D(scene, camera);
			view.antiAlias = 4;
			
			addChild(view);
			
			setupScene();
			
			view.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		public function showStats():void
		{
			addChild(new AwayStats(view));
		}
		
		private function onAdded(e:Event):void 
		{
			view.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
		}
		
		/**
		 * Create base scene content such axis mesh or orientation mesh etc...
		 */
		private function setupScene():void 
		{
			var axis:WireframePlane = new WireframePlane(1000, 1000, 20, 20, 0xEEEEEE, 0.3, "xz");
			addChild3D(axis);
		}
		
		/**
		 * Create cameras and configure them
		 */
		private function setupCamera():void
		{
			camera = new Camera3D();
			camraManager = new CameraManager(this, camera, new HoverCameraController(camera));
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
			camraManager.update(worldStep);
			view.render();
			view.renderer.context.enableErrorChecking = true;
		}
		
	}

}