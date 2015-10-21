package core.commands 
{
	/**
	 * ...
	 * @author Asfel
	 */
	public class CommandProcessor 
	{
		public var currentCommandIndex:int = 0;
		public var commandsStack:Vector.<Command> = new Vector.<Command>
		
		public function CommandProcessor() 
		{
			
		}
		
		public function pushCommand(command:Command):void
		{
			if (currentCommandIndex != commandsStack.length -1)
			{
				commandsStack.splice(currentCommandIndex, commandsStack.length - currentCommandIndex);
			}
			
			commandsStack.push(command);
			currentCommandIndex = commandsStack.length - 1;
			
			command.execute();
		}
		
		public function get canUndo():Boolean
		{
			return currentCommandIndex > -1;
		}
		
		public function get canRedo():Boolean
		{
			return currentCommandIndex < commandsStack.length - 1;
		}
		
		public function undo():void
		{
			if (!this.canUndo)
				return;
				
			commandsStack[currentCommandIndex].cancel();
			currentCommandIndex--;
		}
		
		public function redo():void
		{	
			if (!canRedo)
				return;
				
			currentCommandIndex++;		
			commandsStack[currentCommandIndex].execute();
		}
		
	}

}