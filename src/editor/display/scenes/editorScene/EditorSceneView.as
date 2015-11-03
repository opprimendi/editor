package editor.display.scenes.editorScene 
{
	import away3d.primitives.WireframePlane;
	import core.display.scenes.BaseSceneView;
	import core.display.scenes.layers.SceneLayer3D;
	
	public class EditorSceneView extends BaseSceneView 
	{
		private var editorSceneContext:EditorSceneContext;
		public var layer3D:SceneLayer3D;
		
		public function EditorSceneView(editorSceneContext:EditorSceneContext) 
		{
			super();
			
			this.editorSceneContext = editorSceneContext;
			
			initialize();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			createLayers();
			setupScene3D();
		}
		
		private function createLayers():void 
		{
			layer3D = new SceneLayer3D(editorSceneContext.camera);
			addLayer(layer3D);
		}
		
		/**
		 * Create base scene content such axis mesh or orientation mesh etc...
		 */
		private function setupScene3D():void 
		{
			var axis:WireframePlane = new WireframePlane(1000, 1000, 20, 20, 0xEEEEEE, 0.3, "xz");
			layer3D.addChild3D(axis);
			
			layer3D.showStats();
		}
	}
}