package
{
  import flash.display.Sprite;
  import flash.errors.EOFError;
  import flash.geom.Point;
  import flash.utils.ByteArray;

  public class LSystem
  {
    private var turtle:Turtle;
    private var _atom:String;
    private var _fProductions:Array;
    private var _xStr:String;
    private var _yStr:String;
    private var _angle:Number;
    private var _order:Number;
    private var finalPath:ByteArray = new ByteArray();

    public function LSystem(atom:String, fProductions:Array, xStr:String, yStr:String, angle:Number, order:Number, sprite:Sprite)
    {
      _atom = atom;
      _fProductions = fProductions;
      _xStr = xStr;
      _yStr = yStr;
      _angle = angle;
      _order = order;
      turtle = new Turtle(new Point(-100, 100), degToRad(-85), 0x659D32, 0.5, sprite);
      produceString(this._atom, _order);
      finalPath.position = 0;
    }

    public function get atom():String
    {
      return _atom;
    }

    public function get fProductions():Array
    {
      return _fProductions;
    }

    public function get xStr():String
    {
      return _xStr;
    }

    public function get yStr():String
    {
      return _yStr;
    }

    public function get angle():Number
    {
      return _angle;
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
              turtle.forward(3, true);
              break;
            case 4:
              turtle.saveTurtle();
              break;
            case 5:
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
            //turtle.turn(degToRad(this.angle));
            break;
          case '-':
            finalPath.writeByte(2);
            //turtle.turn(-degToRad(this.angle));
            break;
          case 'F':
            if (order > 0)
            {
              var randomNo:uint = Math.random() * (fProductions.length);
              var fStr:String = fProductions[randomNo];
              produceString(fStr, order - 1);
            }
            else
            {
              finalPath.writeByte(3);
              //turtle.forward(10, true);
            }
            break;
          case 'X':
            if (order > 0)
              produceString(this.xStr, order - 1);
            break;
          case 'Y':
            if (order > 0)
              produceString(this.yStr, order - 1);
            break;
          case '[':
            finalPath.writeByte(4);
            //turtle.saveTurtle();
            break;
          case ']':
            finalPath.writeByte(5);
            //turtle.restoreTurtle();
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
      ;
    }
  }
}