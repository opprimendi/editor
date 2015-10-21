package core.display 
{
	import core.display.scenes.AbstractScene;
	import core.display.ui.UIComponent;
	import core.WorldTimeController;
	import flash.display.Stage;
	import flash.events.Event;

	public class DisplayManager 
	{
		private var stage:Stage;
		private var currentScene:AbstractScene;
		
		public var container:UIComponent = new UIComponent();
		
		public var worldTimeController:WorldTimeController;// = new WorldTimeController();
		
		public function DisplayManager(stage:Stage) 
		{
			this.stage = stage;
			
			stage.addChild(container)
			
			stage.addEventListener(Event.ENTER_FRAME, onUpdate);
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function onResize(e:Event):void 
		{
			if(currentScene)
				currentScene.onResize();
		}	
		
		private function onUpdate(e:Event):void 
		{
			worldTimeController.updateTime();
			
			if(currentScene)
				currentScene.update(worldTimeController.worldStep);
		}
		
		public function showScene(scene:AbstractScene):void
		{
			if (currentScene == scene)
				return;
				
			hideCurrentScene();
			
			currentScene = scene
			
			if(!currentScene.initialized)
				currentScene.internal_initialize();
				
			currentScene.activate();
			
			container.addComponent(currentScene.sceneView);
		}
		
		public function hideCurrentScene():void
		{
			if (!currentScene)
				return;
				
			currentScene.deactivete();
			container.removeComponent(currentScene.sceneView);
		}
	}
}