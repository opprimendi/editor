package core.display.scenes.mainScene 
{
	import core.commands.CommandProcessor;
	import core.display.scenes.AbstractScene;
	import core.display.scenes.mainScene.data.MainSceneContext;
	import core.display.scenes.mainScene.view.MainSceneView;
	import core.external.keyboard.KeyBoardController;
	import core.WorldStep;
	import flash.ui.Keyboard;
	
	public class MainScene extends AbstractScene
	{
		public var sceneContext:MainSceneContext = new MainSceneContext();
		
		protected var commandProcessor:CommandProcessor;
		protected var mainSceneView:MainSceneView;
		protected var keyboardController:KeyBoardController;
		
		public function MainScene(sceneId:int) 
		{
			super(sceneId);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			mainSceneView = new MainSceneView();
			sceneView = mainSceneView;
			
			sceneContext.layerView = mainSceneView.layerView;
			
			commandProcessor = new CommandProcessor();
			
			keyboardController = new KeyBoardController(mainSceneView);
		}
		
		override public function update(worldStep:WorldStep = null):void 
		{
			super.update(worldStep);
			
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