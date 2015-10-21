package core.display.scenes 
{
	import core.display.ui.UIComponent;
	
	public class AbstractSceneView extends UIComponent 
	{
		protected var isActive:Boolean;
		
		public function AbstractSceneView() 
		{
			
		}
		
		public function deactivate():void
		{
			isActive = false;
		}
		
		public function activate():void
		{
			isActive = true;
		}
	}

}