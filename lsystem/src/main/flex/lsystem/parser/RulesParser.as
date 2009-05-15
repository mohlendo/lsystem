package lsystem.parser
{

  public class RulesParser
  {
    private var _token:Token;
    private var _scanner:Scanner;

    public function RulesParser(scanner:Scanner)
    {
      _scanner = scanner;
    }

    public function parse():Array
    {
      var rules:Array = new Array()
      _token = _scanner.nextToken();
      while (_token.type != "eof")
      {
        rules.push(parseRule());
        _token = _scanner.nextToken();
      }

      if (_token.type == "eof")
      {
        return rules;
      }
      else
      {
        throw new Error("Unexpected token");
      }
    }


    private function parseRule():Rule
    {
      var left:String;
      var right:String;
      left = parseVariable();
      right = parseExpression();
      return new Rule(left, right);
    }

    private function parseVariable():String
    {
      var result:String = "";
      while (_token.type == "name")
      {
        result += _token.value;
        _token = _scanner.nextToken();
      }
      if (_token.type == "operator" && _token.value == "->")
      {
        _token = _scanner.nextToken();
      }
      return result;
    }

    private function parseExpression():String
    {
      var result:String = "";
      while (_token.type != "eol" && _token.type != "eof")
      {
        result += _token.value;
        _token = _scanner.nextToken();
      }
      return result;
    }
  }
}



