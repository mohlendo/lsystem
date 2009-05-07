package
{
  import flash.display.Sprite;
  import flash.events.Event;

  public class Main extends Sprite
  {
    private var parser:RulesParser;
    private var lSystem:LSystem;
    
    public function Main()
    {
      x=150;
      y=300;
      super();
      parser = new RulesParser( new Scanner("X -> F-[[X]+X]+F[+FX]-X\n"
      +"F -> FF"));
      var rules:Array = parser.parse();
      for each(var r:Rule in rules) {
        trace(r.variable + " " + r.expression);
      }
      lSystem = new LSystem("X",rules,27,6,this);
      this.addEventListener(Event.ENTER_FRAME, iterate);
    }
    
    private function iterate(e:Event):void
    {
      if (!lSystem.iterate(1000))
      {
        this.removeEventListener(Event.ENTER_FRAME, iterate);
      }
      
    }
  }
}