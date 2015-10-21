package core.display.ui 
{
	import core.IDestructable;
	import core.IUpdatable;
	import core.WorldStep;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public dynamic class UIComponent extends Sprite implements IDestructable, IUpdatable
	{
		
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		
		protected var subComponentsList:Vector.<UIComponent> = new Vector.<UIComponent>;
		
		protected var invaildLayout:Boolean = true;
		
		protected var _mouseInteraction:Boolean = true;
		
		public function UIComponent() 
		{
			
			preinitialzie();
			createChildren();
			configureChildren();
			updateDisplayList();
			initialize();
			layoutChildren();
			
			//addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		//protected function onAdded(e:Event):void 
		//{
		//	removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		//	layoutChildren();
		//}
		
		public function calculateizeFromChilds():Point
		{
			var point:Point = new Point();
			
			for (var i:int = 0; i < subComponentsList.length; i++)
			{
				var currentWidth:Number = subComponentsList[i].x + subComponentsList[i].width;
				var currentHeight:Number = subComponentsList[i].y + subComponentsList[i].height;
				
				if (currentWidth > point.x)
					point.x = currentWidth;
					
				if (currentHeight > point.y)
					point.y = currentHeight;
			}
			
			return point;
		}
		
		public function get mouseInteraction():Boolean
		{
			return _mouseInteraction;
		}
		
		public function set mouseInteraction(value:Boolean):void
		{
			this.mouseChildren = value;
			this.mouseEnabled = value;
		}
		
		public function invalidateLayout():void
		{
			invaildLayout = true;
		}
		
		public function removeComponents():void
		{
			for (var i:int = 0; i < subComponentsList.length; i++)
			{
				removeChild(subComponentsList[i])
			}
			
			subComponentsList = new Vector.<UIComponent>;
		}
		
		public function removeComponentAt(i:int):void 
		{
			removeChild(subComponentsList.splice(i, 1)[0]);
		}
		
		public function removeComponent(component:UIComponent):void
		{
			for (var i:int = 0; i < subComponentsList.length; i++)
			{
				if (subComponentsList[i] == component)
				{
					subComponentsList.splice(i, 1);
					break;
				}
			}
			
			removeChild(component);
		}
		
		public function addComponentAt(component:UIComponent, index:int):void
		{
			subComponentsList.push(component);
			
			addChildAt(component, index);
		}
		
		public function addComponent(component:UIComponent):void
		{
			subComponentsList.push(component);
			
			addChild(component);
		}
		
		public function update(worldStep:WorldStep = null):void
		{
			for (var i:int = 0; i < subComponentsList.length; i++)
			{
				subComponentsList[i].update(worldStep);
			}
			
			if(invaildLayout)
				layoutChildren();
		}
		
		public function setSize(width:Number, height:Number):void
		{
			_width = width;
			_height = height;
			
			invalidateLayout();
		}
		
		public function get measureHeight():Number
		{
			return super.height;
		}
		
		public function get measureWidth():Number
		{
			return super.width;
		}
		
		override public function get height():Number 
		{
			return _height;
		}
		
		override public function set height(value:Number):void 
		{
			_height = value;
		}
		
		override public function get width():Number 
		{
			return _width;
		}
		
		override public function set width(value:Number):void 
		{
			_width = value;
		}
		
		protected function updateDisplayList():void 
		{
			
		}
		
		/**
		 * Initialize system operations, call before create children etc...
		 */
		protected function preinitialzie():void 
		{
			
		}
		
		/**
		 * Setup event calaboration, initialize objects, etc... Call after childs created and added.
		 */
		protected function initialize():void
		{
			
		}
		
		/**
		 * Create sub chldren, sub components and containers.
		 */
		protected function createChildren():void
		{
			
		}
		
		/**
		 * specific configuration for childrens, specific params etc...
		 */
		protected function configureChildren():void
		{
			
		}
		
		/**
		 * Выравнивание потомков, вызывается после создания компонента и при изменении рамзмеров или чего то подобного
		 * вызывается после вхождения в новый кадр, если флаг <code>invaildLayout = true;</code>
		 */
		protected function layoutChildren():void
		{
			invaildLayout = false;
		}
		
		/**
		 * Убирает потомков (суб компоненты) из дисплей листа
		 */
		protected function destroyChildren():void
		{
			for (var i:int = 0; i < subComponentsList.length; i++)
			{
				removeChild(subComponentsList[i]);
			}
			
			subComponentsList = null;
		}
		
		/**
		 * Деструктор, по дефолту инициирует удаление потомков с дисплей листа
		 */
		public function destroy():void
		{
			destroyChildren();
		}
		
		public function onResize():void 
		{
			layoutChildren();
		}
		
		public function localPointToGlobal(point:Point):void
		{
			var theParent:Object = this;
			
			for (; theParent; )
			{
				point.x -= theParent.x;
				point.y -= theParent.y;
				
				theParent = theParent.parent;
			}
		}
		
	}

}