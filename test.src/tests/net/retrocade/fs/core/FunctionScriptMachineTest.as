package tests.net.retrocade.fs.core{

    import net.retrocade.fusi.core.FusiMachine;
    import net.retrocade.fusi.core.FusiScriptRunner;
    import net.retrocade.fusi.core.IFusiScriptRunner;
    import net.retrocade.fusi.core.function_script;

    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertNotNull;

    public class FunctionScriptMachineTest{
        private var machine:FusiMachine;

        [Before]
        public function setUp():void{
            machine = new FusiMachine();
        }

        [Test]
        public function testGetParser():void{
            assertNotNull(machine.function_script::getParser());
        }
        
        [Test]
        public function testGetScriptRunner():void{
            var testScript:String = 'SET("test1", 15)\n' +
                                    'SET("test2", 18)\n' +
                                    'SET("test3", ADD(GET("test1"), GET("test2")))';

            var runner:IFusiScriptRunner = machine.getScriptRunner(testScript, {});
            var runnerInstance:FusiScriptRunner = FusiScriptRunner(runner);
            
            assertEquals(3, runnerInstance.script.length);
            
            runnerInstance.run();
            
            assertEquals(33, runnerInstance.getProperty('test3'));
        }
        
        [Test]
        public function testStandarizeLinefeeds():void{
            var script:String = "abc\r\nabc\n\r";
            var standarized:String = FusiMachine.function_script::standarizeLinefeeds(script);
            
            assertEquals("abc\nabc\n", standarized);
        }
        
        [Test]
        public function testTrimWhitespace():void{
            var script:String = "    abc   ";
            var trimmed:String = FusiMachine.function_script::trimWhitespace(script);
            
            assertEquals("abc", trimmed);
        }
    }
}