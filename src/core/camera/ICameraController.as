package core.camera 
{
	import core.IUpdatable;
	
	/**
	 * ...
	 * @author Asfel
	 */
	public interface ICameraController extends IUpdatable
	{
		function updatePanning(dx:Number, dy:Number):void;
		function updateRotation(dx:Number, dy:Number):void;
	}
	
}