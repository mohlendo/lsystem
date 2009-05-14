package lsystem
{
  import flash.display.Shape;
  import flash.errors.EOFError;
  import flash.geom.Point;
  import flash.utils.ByteArray;
  
  import lsystem.parser.Rule;
  import lsystem.rendering.Turtle;

  public class LSystem extends Shape
  {
    private var turtle:Turtle;
    private var _start:String;
    private var _rules:Array;
    
    private var _angle:Number;
    private var _order:Number;
    private var _fProductions:Array;
    
    private var finalPath:ByteArray = new ByteArray();

    public function LSystem(start:String, rules:Array,  angle:Number, order:Number)
    {
      _start = start;
      _rules = rules;
      _angle = angle;
      _order = order;
      _fProductions = new Array();
      
      for each (var r:Rule in rules) {
        if (r.variable == "F") {
          _fProductions.push(r.expression);
        }
      }
      
      produceString(this._start, _order);
      finalPath.position = 0;
    }

    public function get start():String
    {
      return _start;
    }

    public function get rules():Array
    {
      return _rules;
    }
    
    public function get angle():Number
    {
      return _angle;
    }
    
    public function draw(x:Number, y:Number, startAngle:Number):void {
    	turtle = new Turtle(new Point(x,y), degToRad(startAngle), 0x659D32, 0.5, this.graphics);
      	iterate(-1);    	
    }

    public function iterate(iterationSteps:Number = 1):Boolean
    {
      if (iterationSteps <= 0)
      {
        iterationSteps = finalPath.length - 1;
        if (iterationSteps == 0)
        {
          return false;
        }
      }
      var eof:Boolean = false;
      for (var i:uint = 0; i < iterationSteps && !eof; i++)
      {
        if (finalPath.length >= 0)
        {
          
          var step:int;
          try {
            step = finalPath.readByte();
          
          } catch(e:EOFError) {
                return true
          }

          switch (step)
          {
            case 1:
              turtle.turn(degToRad(this.angle));
              break;
            case 2:
              turtle.turn(-degToRad(this.angle));
              break;
            case 3:
              turtle.turn(degToRad(180));
              break;
            case 4:
              turtle.forward(3, true);
              break;
            case 5:
              turtle.saveTurtle();
              break;
            case 6:
              turtle.restoreTurtle();
              break;
            
          }
        }
      }
      return true;
    }

    private function produceString(string:String, order:uint):void
    {
      for (var i:uint = 0; i < string.length; i++)
      {
        switch (string.charAt(i))
        {
          case '+':
            finalPath.writeByte(1);
            break;
          case '-':
            finalPath.writeByte(2);
            break;
          case '|':
            finalPath.writeByte(3);
            break;
          case 'F':
            if (order > 0)
            {
              var randomNo:uint = Math.random() * (_fProductions.length);
              var fStr:String = _fProductions[randomNo];
              produceString(fStr, order - 1);
            }
            else
            {
              finalPath.writeByte(4);
            }
            break;
          case '[':
            finalPath.writeByte(5);
            break;
          case ']':
            finalPath.writeByte(6);
            break;
          default:
            if (order > 0)
              for each (var r:Rule in _rules) {
                if(r.variable == string.charAt(i))
                  produceString(r.expression, order - 1);
              }
            break;
          
          
        }
      }
    }
    
    private function getLineAngleRad(deltaX:Number, deltaY:Number):Number
    {
      return Math.atan2(deltaY, deltaX);
    }

    private function getDistBetPts(pt1:Point, pt2:Point):Number
    {
      return Point.distance(pt1, pt2);
    }

    private function degToRad(deg:Number):Number
    {
      return 2.0 * Math.PI / 360.0 * deg;
    }
  }
}