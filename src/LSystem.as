package {
  import flash.display.Sprite;
  import flash.geom.Point;

  public class LSystem extends Sprite
  {
    private var turtle:Turtle;
    
    private var _atom:String;
    private var _fStr:String;
    private var _xStr:String;
    private var _yStr:String;
    private var _angle:Number;
    
    public function LSystem(__atom:String, __fStr:String, __xStr:String, 
                   __yStr:String, __angle:Number) {
      _atom  = __atom;
      _fStr  = __fStr;
      _xStr  = __xStr;
      _yStr  = __yStr;
      _angle = __angle;
      this.x=100;
      this.y = 100;
      
      turtle = new Turtle(new Point(0,0),0,0x000000,0.5,this);
    }
 
    public function get atom():String { return _atom; }
    public function get fStr():String { return _fStr; }
    public function get xStr():String { return _xStr; }
    public function get yStr():String { return _yStr; }
    public function get angle():Number { return _angle; }
    
    public function run():void {
      this.produceString(this.atom,10,true);      
    }
    
    
    private function produceString(string:String, order:uint, isVisible:Boolean):void {
      for(var i:uint = 0; i < string.length; i++) {
        switch (string.charAt(i)) {
          case '+':
            turtle.turn(degToRad(this.angle));
          break;
          case '-':
            turtle.turn(-degToRad(this.angle));
          break;
          case 'F':
            if(order > 0) {
                    produceString(this.fStr, order - 1, isVisible);
            } else {
                    turtle.forward(5, isVisible);
            }
          break;
          case 'X':
            if(order > 0)
                    produceString(this.xStr, order - 1, isVisible);
          break;
          case 'Y':
            if(order > 0)
                    produceString(this.yStr, order - 1, isVisible);
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
 
    private function degToRad(deg:uint):Number {
      return deg * (Math.PI / 180);
    }
  }
}
