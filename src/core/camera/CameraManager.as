package core.camera 
{
	import away3d.cameras.Camera3D;
	import core.IUpdatable;
	import core.WorldStep;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class CameraManager implements IUpdatable
	{
		//camera was rotated
		public var dragging:Boolean = false;
		//camera was pan
		public var panning:Boolean = false;
		
		//speed for camera zooming
		public var wheelSpeed:Number = 10;
		//speed for camera dragging
		public var mouseSpeed:Number = 1;	
		
		//click point
		private var click:Point = new Point();		
		private var pan:Point = new Point();	
		
		//current cammera controller e.g hover, first person, fly camera, etc..
		private var cameraController:ICameraController;
		
		//instance to display and listen events from
		private var instance:Sprite;
		private var camera:Camera3D;
		
		/**
		 * 
		 * @param	instance - instance to display and listen events such mouse events
		 * @param	camera - camera to be controlled by camera controller
		 * @param	cameraController - camera controller
		 */
		public function CameraManager(instance:Sprite, camera:Camera3D, cameraController:ICameraController) 
		{
			this.cameraController = cameraController;
			this.camera = camera;
			this.instance = instance;
			
			initialize();
		}
		
		private function initialize():void 
		{
			instance.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);			
			instance.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);	
			instance.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);	
			instance.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);	
			instance.addEventListener(Event.MOUSE_LEAVE, onMouseLeave);	
			instance.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		public function update(worldStep:WorldStep = null):void
		{
			if (panning)
				updatePanning();
				
			if (dragging)
				updateRotation();
			
			cameraController.update(worldStep);
		}
		
		/**
		 * Process panning type action and pass it to camera controller
		 */
		private function updatePanning():void
		{
			var dx:Number = (instance.mouseX - pan.x);
			var dy:Number = (instance.mouseY - pan.y);
			
			pan.x = instance.mouseX;
			pan.y = instance.mouseY;	
			
			cameraController.updatePanning(dx, dy);
		}
		
		/**
		 * Process rotation action and pass it to camera controller
		 */
		public function updateRotation():void
		{
			var dx:Number = instance.mouseX - click.x;
			var dy:Number = instance.mouseY - click.y;
			
			click.x = instance.mouseX;
			click.y = instance.mouseY;
			
			cameraController.updateRotation(dx * mouseSpeed, dy * mouseSpeed)
		}
		
		private function onMouseWheel(e:MouseEvent):void 
		{
			
		}
		
		private function onMouseLeave(e:Event):void 
		{
			dragging = false;
			panning = false;
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
			dragging = false;
			panning = false;
		}
		
		private function onMouseOver(e:MouseEvent):void 
		{
			
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			dragging = false;
			panning = false;
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			click.x = instance.mouseX;
			click.y = instance.mouseY;				
			
			if (panning)
			{
				pan.x = instance.mouseX;
				pan.y = instance.mouseY;
				panning = true;
			}
			else 
				dragging = true;				
				
			//hasMoved = false;
		}
		
	}

}