package lsystem
{
	import flash.events.MouseEvent;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import lsystem.parser.*;
	
	public class LSystemView extends UIComponent
	{
		private var rulesParser:RulesParser;
    	private var lSystem:LSystem;
    	
    	[Bindable]
    	public var source:String;
    	
    	[Bindable]
    	public var angle:Number;
    	
    	[Bindable]
    	public var order:Number;
    
		public function LSystemView()
		{
			super();
			     		
		}
		
		protected override function updateDisplayList(unscaledWidth:Number,
                                        unscaledHeight:Number):void
    	{
    		
    		
    	}
    	
    	public function draw():void {
    		rulesParser = new RulesParser( new Scanner(source));
      		var rules:Array = rulesParser.parse();
      		lSystem = new LSystem("X",rules,angle,order); 
    		lSystem.draw(this, width/2, height-10);
    	}
		
		
		
	}
}