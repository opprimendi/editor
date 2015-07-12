package core.display.scenes.mainScene.view 
{
	import core.display.Layer3D;
	import core.display.scenes.AbstractSceneView;
	
	public class MainSceneView extends AbstractSceneView 
	{
		public var layerView:Layer3D;
		
		public function MainSceneView() 
		{
			super();
		}
		
		override protected function createChildren():void 
		{
			super.createChildren();
			
			layerView = new Layer3D();
		}
		
		override protected function configureChildren():void 
		{
			super.configureChildren();
			
			layerView.showStats();
		}
		
		override protected function updateDisplayList():void 
		{
			super.updateDisplayList();
			
			addComponent(layerView);
		}
		
	}

}