package
{
  import flash.display.Sprite;
  import flash.events.Event;

  public class Main extends Sprite
  {
    var l:LSystem;
    public function Main()
    {
      x=200;
      y=150;
      super();
      //Koch Kurve
      //l = new LSystem("F", "F-F++F-F", "", "", 60,4, this);
      //QuadKochIslandSP
      //l = new LSystem("F+F+F+F", "F+F-F-FF+F+F-F", "", "", 90,4, this);
      //Hilbert Kurve
      //l = new LSystem("X", "F", "-YF+XFX+FY-", "+XF-YFY-FX+", 90,5, this);
      //Drachen Kurve
      l = new LSystem("X", "F", "X+YF+", "-FX-Y", 90,12, this);
      //SierpinskiArrowheadSP
      //l = new LSystem("YF", "F", "YF+XF+Y", "XF-YF-X", 60,8, this);      
      this.addEventListener(Event.ENTER_FRAME,me); 
      
    }
    function me(e:Event):void {
          if(!l.iterate(1000)) {
            this.removeEventListener(Event.ENTER_FRAME,me);
          }
    }
    
    
    
  }
}