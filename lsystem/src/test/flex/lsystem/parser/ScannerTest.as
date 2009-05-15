package lsystem.parser
{
  import flexunit.framework.Assert;
  import flexunit.framework.TestCase;

  public class ScannerTest extends TestCase
  {
    // please note that all test methods should start with 'test' and should be public

    // Reference declaration for class to test
    private var scanner:Scanner;

    public function ScannerTest(methodName:String = null)
    {
      super(methodName);
    }

    override public function setUp():void
    {
      super.setUp();
    }

    override public function tearDown():void
    {
      super.tearDown();
    }

    public function testNextToken():void
    {
      var source:String = "X";
      scanner = new Scanner(source);
      var result:Token = scanner.nextToken();
      Assert.assertEquals("X", result.value);

      source = "X -> F";
      scanner = new Scanner(source);
      result = scanner.nextToken();
      Assert.assertEquals("X", result.value);
      result = scanner.nextToken();
      Assert.assertEquals("->", result.value);
      result = scanner.nextToken();
      Assert.assertEquals("F", result.value);
    }
  }
}