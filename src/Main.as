package
{
  import flash.display.Sprite;
  import flash.events.Event;

  public class Main extends Sprite
  {
    private var l:LSystem;
    public function Main()
    {
      x=200;
      y=150;
      super();
      var productions:Array = new Array();
      //Koch Kurve
      //l = new LSystem("F", "F-F++F-F", "", "", 60,4, this);
      //QuadKochIslandSP
      //l = new LSystem("F+F+F+F", "F+F-F-FF+F+F-F", "", "", 90,4, this);
      //Hilbert Kurve
      //l = new LSystem("X", "F", "-YF+XFX+FY-", "+XF-YFY-FX+", 90,5, this);
      //Drachen Kurve
      //l = new LSystem("X", "F", "X+YF+", "-FX-Y", 90,12, this);
      //SierpinskiArrowheadSP
      //l = new LSystem("YF", "F", "YF+XF+Y", "XF-YF-X", 60,8, this);      
      //Levy C curve
      //productions.push("+F--F+");
      //l = new LSystem("F",productions,"","",45,12,this);
      //l = new LSystem("X","FF","F-[[X]+X]+F[+FX]-X","",22, 6, this);
      /*productions.push("FF-[-F+F+F]+[+F-F-F]");
      productions.push("FF-[-F+F][FF]+[+F-F]");
      l = new LSystem("X", productions, "YYYYF", "", 22,4, this);*/
      productions.push("F[+F]F[-F]F");
      l = new LSystem("F",productions,"","",18,1,this);
      this.addEventListener(Event.ENTER_FRAME,me); 
      
    }
    private function me(e:Event):void {
          if(!l.iterate(-1)) {
            this.removeEventListener(Event.ENTER_FRAME,me);
          }
    }
    
    
    
  }
}