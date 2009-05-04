package
{
  import flash.display.Sprite;
  import flash.geom.Point;

  public class Turtle
  {
    private var curPos:Point;
    private var curPosOriginal:Point;
    private var curDirRad:Number;
    private var color:uint;
    private var lineThickness:uint;
    private var sprite:Sprite;
    private var stateStack:Array;

    // curPos is the current position of the turtle
    // curDir is the current direction of the turtle in radians
    // color is the color of the line drawn by turtle
    // lineThickness is the thickness of said line
    // sprite is the Sprite we're drawing on
    public function Turtle(_curPos:Point, _curDir:Number, _color:uint, _lt:uint, _sprite:Sprite)
    {
      curPos = new Point(_curPos.x, _curPos.y);
      curPosOriginal = new Point(_curPos.x, _curPos.y);
      curDirRad = _curDir;
      color = _color;
      lineThickness = _lt;
      sprite = _sprite;
      stateStack = new Array();
      resetTurtle();
    }

    // turn turtle to given angle, angle is given in radians
    public function turnTo(angleNew:Number):void
    {
      curDirRad = angleNew;
    }

    // turn the turtle by the angle increment, angle given in radians
    public function turn(angleIncrement:Number):void
    {
      curDirRad += angleIncrement;
    }

    // move the turtle forward in current direction by dist amount
    // if turtle is visible draw line along movement path, else 
    // just move the turtle invisibly.
    public function forward(distance:Number, isVisible:Boolean):void
    {
      curPos.x += (distance * Math.cos(curDirRad));
      curPos.y += (distance * Math.sin(curDirRad));
      if (isVisible)
      {
        sprite.graphics.lineStyle(lineThickness, color);
        sprite.graphics.lineTo(curPos.x, curPos.y);
      }
      else
      {
        sprite.graphics.moveTo(curPos.x, curPos.y);
      }
    }

    public function saveTurtle():void
    {
      var curState:Object = new Object;
      curState.curPos = new Point(curPos.x, curPos.y);
      curState.curDirRad = curDirRad;
      stateStack.push(curState);
    }

    public function restoreTurtle():void
    {
      if (stateStack.length > 0)
      {
        var curState:Object = stateStack.pop();
        curPos.x = curState.curPos.x;
        curPos.y = curState.curPos.y;
        curDirRad = curState.curDirRad;
        sprite.graphics.moveTo(curPos.x, curPos.y);
      }
    }

    // Reset the turtle
    public function resetTurtle():void
    {
      sprite.graphics.clear();
      curPos.x = curPosOriginal.x;
      curPos.y = curPosOriginal.y;
      sprite.graphics.moveTo(curPos.x, curPos.y);
    }

    private function getLineAngleRad(deltaX:Number, deltaY:Number):Number
    {
      return Math.atan2(deltaY, deltaX);
    }

    private function getDistBetPts(pt1:Point, pt2:Point):Number
    {
      return Point.distance(pt1, pt2);
    }
  }
}