package editor.display.scenes.editorScene 
{
	import away3d.cameras.Camera3D;
	import core.camera.CameraManager;
	import core.camera.HoverCameraController;
	import core.commands.CommandProcessor;
	import core.display.scenes.BaseScene;
	import core.external.keyboard.KeyBoardController;
	import core.WorldStep;
	import editor.display.scenes.editorScene.EditorSceneView;
	import editor.display.scenes.editorScene.factory.CreationFactories;
	import flash.ui.Keyboard;
	
	public class EditorScene extends BaseScene
	{
		private var editorSceneContext:EditorSceneContext;
		
		private var cameraManager:CameraManager;
		private var camera:Camera3D;
		
		protected var commandProcessor:CommandProcessor;
		protected var editorSceneView:EditorSceneView;
		protected var keyboardController:KeyBoardController;
		
		public function EditorScene(sceneId:int) 
		{
			super(sceneId);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			createComponents();
			addUiInteraction();
		}
		
		private function createComponents():void 
		{
			editorSceneContext = new EditorSceneContext();
			editorSceneContext.camera = camera = new Camera3D();
			
			editorSceneView = new EditorSceneView(editorSceneContext);
			sceneView = editorSceneView;
			
			
			commandProcessor = new CommandProcessor();
			keyboardController = new KeyBoardController(sceneView);
			
			
			cameraManager = new CameraManager(editorSceneView.layer3D, camera, new HoverCameraController(camera));
			
			
			var creationFactory:CreationFactories = new CreationFactories(commandProcessor);
			creationFactory.currentSceneView = editorSceneView;
		}
		
		private function addUiInteraction():void 
		{
			
		}
		
		override public function update(worldStep:WorldStep = null):void 
		{
			super.update(worldStep);
			
			cameraManager.update(worldStep);
			
			if (keyboardController.isKeyDown(Keyboard.CONTROL))
			{
				if (keyboardController.isKeyDown(Keyboard.Z))
					undo();
				else if (keyboardController.isKeyDown(Keyboard.Y))
					redo();
			}
		}
		
		private function redo():void 
		{
			commandProcessor.redo();
		}
		
		private function undo():void 
		{
			commandProcessor.undo();
		}
		
	}

}