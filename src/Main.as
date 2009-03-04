package
{
  import flash.display.Sprite;

  public class Main extends Sprite
  {
    public function Main()
    {
      super();
      var l:LSystem = new LSystem("YF", "F", "YF+XF+Y", "XF-YF-X", 60)
      this.addChild(l)
      l.run();
    }
    
  }
}