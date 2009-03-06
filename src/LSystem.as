package {
  import flash.display.Sprite;
  import flash.geom.Point;

  public class LSystem
  {
    private var turtle:Turtle;
    
    private var _atom:String;
    private var _fProductions:Array;
    private var _xStr:String;
    private var _yStr:String;
    private var _angle:Number;
    private var _order:Number;
    
    private var finalPath:Array = new Array();   
    
    public function LSystem(atom:String, fProductions:Array, xStr:String, 
                   yStr:String, angle:Number, order:Number, sprite:Sprite ) {
      _atom  = atom;
      _fProductions  = fProductions;
      _xStr  = xStr;
      _yStr  = yStr;
      _angle = angle;
      _order = order;
      produceString(this._atom,_order);      
      turtle = new Turtle(new Point(100,150),degToRad(-85),0x000000,0.5,sprite);
    }
 
    public function get atom():String { return _atom; }
    public function get fProductions():Array { return _fProductions; }
    public function get xStr():String { return _xStr; }
    public function get yStr():String { return _yStr; }
    public function get angle():Number { return _angle; }
    
    
    
    public function iterate(iterationSteps:Number = 1):Boolean {
      if(iterationSteps <= 0 ) {
        iterationSteps = finalPath.length-1;
        if(iterationSteps==0) {
          return false;
        }
      }
      for (var i:uint=0;i<iterationSteps&&finalPath.length >= 0;i++) {
        if(finalPath.length >= 0) {
          switch (finalPath.pop()) {
            case 1:
              turtle.turn(degToRad(this.angle));
            break;
            case -1:
              turtle.turn(-degToRad(this.angle));
            break;
            case 0:
              turtle.forward(0.5, true);
            break;
            case 2:
              turtle.saveTurtle();
            break;
            case -2:
              turtle.restoreTurtle();
            break;
          }        
        }
      }
      return true;      
    }
        
    private function produceString(string:String, order:uint):void {
      for(var i:uint = 0; i < string.length; i++) {
        switch (string.charAt(i)) {
          case '+':
            //turtle.turn(degToRad(this.angle));
            finalPath.push(1);
          break;
          case '-':
            //turtle.turn(-degToRad(this.angle));
            finalPath.push(-1);
          break;
          case 'F':
            if(order > 0) {
              var randomNo:uint = Math.random() * (fProductions.length);
              var fStr:String = fProductions[randomNo];
              produceString(fStr, order - 1);
            
            } else {
                    //turtle.forward(1, isVisible);
                    finalPath.push(0);
            }
          break;
          case 'X':
            if(order > 0)
                    produceString(this.xStr, order - 1);
          break;
          case 'Y':
            if(order > 0)
                    produceString(this.yStr, order - 1);
          break;
          case '[':
            finalPath.push(2);
          break;
          case ']':
            finalPath.push(-2);
          break;
        }
      }
  }
    

    private function getLineAngleRad(deltaX:Number, deltaY:Number):Number {
      return Math.atan2(deltaY, deltaX);
    }
 
    private function getDistBetPts(pt1:Point, pt2:Point):Number {
      return Point.distance(pt1, pt2);
    }
 
    private function degToRad(deg:int):Number {
      return 2*Math.PI/360 * deg;;
    }
  }
}
