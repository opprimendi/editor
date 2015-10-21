package core
{
	
	public class WorldTimeController 
	{
		public var lastTime:Number = new Date().getTime();
		
		public var currentTime:Number = 0;// new Date().getTime();
		
		public var worldStep:WorldStep = new WorldStep();
		public var playRate:Number = 1;
		
		public function WorldTimeController() 
		{
			if (lastTime == 0)
				lastTime = currentTime;
		}
		
		/**
		 * Корректируем время
		 * @param	time
		 */
		public function correctTime(time:Number):void
		{
			currentTime = time;
			lastTime = currentTime;
		}
		
		/**
		 * Исходя из реального времени прошлого кадра и текущего считаем сколько на самом деле прошло времени между кадрами
		 */
		public function updateTime():void
		{
			var actualTime:Number = new Date().getTime();
			
			var dt:Number = actualTime - lastTime;
			
			if (playRate != 1)
				dt *= playRate;
			
			lastTime = actualTime
			this.currentTime += dt;
			
			worldStep.time = this.currentTime;
			worldStep.dt = dt;
			//Считаем какая часть секунды прошла, т.к это нужно будет во многих вычеслениях
			worldStep.partOfSecond = dt / 1000;
		}
		
	}

}