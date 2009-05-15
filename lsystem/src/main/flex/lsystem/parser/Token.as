package lsystem.parser
{

  public class Token
  {
    public var value:String;
    public var type:String;

    public function Token(type:String, value:String)
    {
      this.type=type;
      this.value=value;
    }
  }
}

