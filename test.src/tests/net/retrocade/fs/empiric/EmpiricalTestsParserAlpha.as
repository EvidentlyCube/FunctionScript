/**
 * Created by Skell on 14.11.13.
 */
package tests.net.retrocade.fs.empiric {
    import net.retrocade.fusi.core.FusiMachine;
    import net.retrocade.fusi.core.IFusiScriptRunner;

    import org.flexunit.asserts.assertEquals;

    public class EmpiricalTestsParserAlpha {
        public var testVarInt:int = 0;
        public var testVarString:String = "";


        private var machine:FusiMachine;


        [Before]
        public function setup():void{
            machine = new FusiMachine();
        }

        [Test]
        public function shouldSetIntegerTo10():void{
            var script:String = 'SET("testVarInt", 10)';

            var runner:IFusiScriptRunner = machine.getScriptRunner(script, this);

            runner.run();

            assertEquals(10, testVarInt);
        }

        [Test]
        public function shouldSetStringToTestString():void{
            var script:String = 'SET("testVarString", "testString")';

            var runner:IFusiScriptRunner = machine.getScriptRunner(script, this);

            runner.run();

            assertEquals("testString", testVarString);
        }

        [Test]
        public function shouldCalculateFactorialOf10():void{
            var script:String = 'SET("step", 1)\n' +
                'SET("sum", 1)\n'+
                'LABEL("loop")\n'+
                'IF(COMP(GET("step"), "<=", 10))\n'+
                '  SET("sum", MUL(GET("step"), GET("sum")))\n'+
                '  SET("step", ADD(GET("step"), 1))\n'+
                '  GOTO("loop")\n'+
                'ELSE\n'+
                '  SET("testVarInt", GET("sum"))\n'+
                'ENDIF';


            var runner:IFusiScriptRunner = machine.getScriptRunner(script, this);

            runner.run();

            assertEquals(10*9*8*7*6*5*4*3*2, testVarInt);
        }

        [Test]
        public function shouldUtiliseGlobalContext():void{
            var script1:String = 'SET("test", 10, GLOBAL)\n' +
                'SET("test", 50)';
            var script2:String = 'SET("test", 110)\n' +
                'SET("testVarInt", GET("test", GLOBAL))';

            var runner1:IFusiScriptRunner = machine.getScriptRunner(script1, this);
            var runner2:IFusiScriptRunner = machine.getScriptRunner(script2, this);

            runner1.run();
            runner2.run();

            assertEquals(testVarInt, 10);
        }

        [Test]
        public function shouldCallThisObjectFunctionWhichSetsTestVariable():void{
            var script1:String = 'CALL("fromScriptFunction", THIS, 54)';

            var runner:IFusiScriptRunner = machine.getScriptRunner(script1, this);
            runner.run();

            assertEquals(testVarInt, 54);
        }

        public function fromScriptFunction(value:Number):void{
            testVarInt = value;
        }
    }
}

/**

 SET("step", 1)
 SET("sum", 1)
 LABEL("loop")
 IF
   COMP(GET("step"), "<=", 10)
   SET("sum", MUL(GET("step"), GET("sum")))
   SET("step", ADD(GET("step"), 1))
   GOTO("loop")
 ELSE
   SET("testVarInt", GET("sum"))
 ENDIF

 */