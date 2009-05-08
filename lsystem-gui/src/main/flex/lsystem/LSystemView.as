package lsystem
{
	import lsystem.parser.RulesParser;
	import lsystem.parser.Scanner;
	
	import mx.core.UIComponent;
	
	public class LSystemView extends UIComponent
	{
		private var rulesParser:RulesParser;
    	private var lSystem:LSystem;
    
		public function LSystemView()
		{
			super();
			rulesParser = new RulesParser( new Scanner("X -> F-[[X]+X]+F[+FX]-X\n"
      +"F -> FF"));
      		var rules:Array = rulesParser.parse();
      		lSystem = new LSystem("X",rules,27,6,this);
		}
		
		protected override function updateDisplayList(unscaledWidth:Number,
                                        unscaledHeight:Number):void
    	{
    		lSystem.iterate(-1);
    	}
		
		
		
	}
}