package lsystem.parser
{

  public class Scanner
  {
    private var _source:String;
    private var _tokens:Array;
    private var _pos:int;

    public function Scanner(source:String)
    {
      _pos = 0;
      _tokens = new Array();
      _source = source;
    }

    public function nextToken():Token
    {
      if (_tokens.length > 0)
      {
        return _tokens.shift();
      }
      skipWhites();
      if (isEOF())
      {
        return new Token("eof", null);
      }
      var c:String = _source.charAt(_pos++);
      var buf:String = "";
      var code:int = c.charCodeAt(0);
      if (isAlpha(code) || (c == '_'))
      {
        /*while (isAlpha(code) || (c == '_'))
           {
           buf += c;
           if (isEOF())
           {
           ++_pos;
           break;
           }
           c = _source.charAt(_pos++);
           code = c.charCodeAt(0);
           }
         --_pos;*/
        buf += c;
        return new Token("name", buf);
      }
      else if (c == "\n")
      {
        return new Token("eol", null);
      }
      else if (c == "-")
      {
        buf = c;
        while (!isEOF())
        {
          c = _source.charAt(_pos);
          if (c != '>')
          {
            break;
          }
          buf += c;
          _pos++;
        }
        return new Token("operator", buf);
      }
      else
      {
        return new Token("operator", c);
      }
    }

    public function pushBack(token:Token):void
    {
      _tokens.push(token);
    }

    protected function isAlpha(c:int):Boolean
    {
      return ((c >= 97) && (c <= 122)) || ((c >= 65) && (c <= 90));
    }

    protected function isEOF():Boolean
    {
      return (_pos >= _source.length);
    }

    protected function skipWhites():void
    {
      while (!isEOF())
      {
        var c:String = _source.charAt(_pos++);
        if ((c != " ") && (c != "\t"))
        {
          --_pos;
          break;
        }
      }
    }
  }
}