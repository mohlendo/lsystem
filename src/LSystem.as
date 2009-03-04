package {
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.geom.Point;

  public class LSystem extends Sprite
  {
    private var turtle:Turtle;
    
    private var _atom:String;
    private var _fStr:String;
    private var _xStr:String;
    private var _yStr:String;
    private var _angle:Number;
    private var _order:Number;
    
    private var processingString:Array = new Array();
    private var step:Number;    
    
    public function LSystem(atom:String, fStr:String, xStr:String, 
                   yStr:String, angle:Number, order:Number ) {
      _atom  = atom;
      _fStr  = fStr;
      _xStr  = xStr;
      _yStr  = yStr;
      _angle = angle;
      _order = order;
      this.processingString.push(atom);
      this.step = _order;
      this.x=100;
      this.y=100;
      
      turtle = new Turtle(new Point(0,0),0,0x000000,0.5,this);
    }
 
    public function get atom():String { return _atom; }
    public function get fStr():String { return _fStr; }
    public function get xStr():String { return _xStr; }
    public function get yStr():String { return _yStr; }
    public function get angle():Number { return _angle; }
    
    public function run():void {
      this.addEventListener(Event.ENTER_FRAME, nextStep);            
    }
    
    private function nextStep(event:Event):void {
        var s = this.processingString.pop();
        for(var i:uint = 0; i < s.length; i++) {
          switch (s.charAt(i)) {
            case '+':
              turtle.turn(degToRad(this.angle));
            break;
            case '-':
              turtle.turn(-degToRad(this.angle));
            break;
            case 'F':
              if(step > 0) {
                      this.processingString.push(this.fStr);
                      step = step -1;
                      return;
              } else {
                      turtle.forward(1, true);
              }
            break;
            case 'X':
              if(step > 0) {
                      this.processingString.push(this.xStr);
                      this.step = step - 1;
                      return;
              }
            break;
            case 'Y':
              if(step > 0) {
                this.processingString.push(this.yStr);
                this.step = step - 1;
              }
            break;
          }
        }
           
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
                    turtle.forward(1, isVisible);
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
