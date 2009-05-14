package lsystem
{
	import flash.display.Shape;
	import flash.events.MouseEvent;
	
	import lsystem.parser.*;
	
	import mx.core.UIComponent;
	
	public class LSystemView extends UIComponent
	{
		private var rulesParser:RulesParser;
    	private var lSystem:LSystem;
    	
    	[Bindable]
    	public var source:String;
    	
    	[Bindable]
    	public var axiom:String;
    	
    	[Bindable]
    	public var startAngle:Number;
    	
    	[Bindable]
    	public var angle:Number;
    	
    	[Bindable]
    	public var order:Number;
    	
    	[Bindable]
    	public var lineThickness:Number;
    	
    	[Bindable]
    	public var lineLength:Number;
    	
    	private var startPoint:Shape;
    	private var background:Shape;
    	private var startX:int;
    	private var startY:int;
    	
    
		public function LSystemView()
		{
			super();			
			background = new Shape();    		
    		this.addChild(background);			   
			this.addEventListener(MouseEvent.CLICK,handleMouseClick);			     		
		}
		
		private function handleMouseClick(event:MouseEvent):void {
			startPoint.graphics.clear();
			startX = event.localX;
			startY =  event.localY;
			startPoint.graphics.beginFill(0xFF0000);
    		startPoint.graphics.drawCircle(event.localX, event.localY,5);
    		  						
		}
		
		protected override function commitProperties():void {
			super.commitProperties();
		}		
		
		protected override function measure():void {
			super.measure();
		}
		
		
		protected override function updateDisplayList(unscaledWidth:Number,
                                        unscaledHeight:Number):void
    	{	
    		super.updateDisplayList(unscaledWidth, unscaledHeight);
    		
    		background.graphics.clear();
    		background.graphics.beginFill(0xFFFFFF);
    		background.graphics.drawRect(x, y, unscaledWidth, unscaledHeight);    
    		
    		if(startPoint == null) {
    			startPoint = new Shape();    			
	    		startX = unscaledWidth/2;
				startY =  unscaledHeight/2;
				startPoint.graphics.clear();
				startPoint.graphics.beginFill(0xFF0000);
	    		startPoint.graphics.drawCircle(startX, startY,5); 
	    		
    			this.addChild(startPoint);	  
    		}	
    	}
    	
    	public function draw(iterationSteps:Number = -1):void {
    		rulesParser = new RulesParser( new Scanner(source));
      		var rules:Array = rulesParser.parse();
      		if(lSystem != null) {
      			this.removeChild(lSystem);
      		}
      		lSystem = new LSystem(axiom,rules,angle,order);
      		this.addChild(lSystem); 
    		lSystem.draw(startX, startY, startAngle, lineThickness, lineLength, iterationSteps);
    	}
		
		
		
	}
}