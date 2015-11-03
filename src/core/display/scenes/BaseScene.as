package core.display.scenes 
{
	import core.IUpdatable;
	import core.WorldStep;

	public class BaseScene implements IUpdatable
	{
		public var initialized:Boolean;
		public var sceneId:int;
		public var sceneView:BaseSceneView;
		
		public function BaseScene(sceneId:int) 
		{
			super();
			
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