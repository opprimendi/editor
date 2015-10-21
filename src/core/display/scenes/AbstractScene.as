package core.display.scenes 
{
	import core.IUpdatable;
	import core.WorldStep;

	public class AbstractScene implements IUpdatable
	{
		public var initialized:Boolean;
		public var sceneId:int;
		public var sceneView:AbstractSceneView;
		
		public function AbstractScene(sceneId:int) 
		{
			this.sceneId = sceneId;
		}
		
		public function internal_initialize():void 
		{
			if (initialized)
				return;
				
			initialized = true;
			initialize();
			postInitialize();
		}
		
		protected function initialize():void
		{
			
		}
		
		public function postInitialize():void
		{
			
		}
		
		public function update(worldStep:WorldStep = null):void 
		{
			sceneView.update(worldStep);
		}
		
		public function onResize():void 
		{
			sceneView.onResize();
		}
		
		public function activate():void 
		{
			sceneView.activate();
		}
		
		public function deactivete():void 
		{
			sceneView.deactivate();
		}
		
		
	}

}