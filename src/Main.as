package
{
  import flash.display.Sprite;

  public class Main extends Sprite
  {
    public function Main()
    {
      super();
      var l:LSystem = new LSystem("F", "F-F++F-F", "", "", 60, 8)
      this.addChild(l)
      l.run();
    }
    
  }
}