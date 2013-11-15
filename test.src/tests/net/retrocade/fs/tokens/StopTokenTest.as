package tests.net.retrocade.fs.tokens{
    import flexunit.framework.Assert;
    
    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.core.FusiMachine;
    import net.retrocade.fusi.parser.FusiParserAlpha;
    import net.retrocade.fusi.core.FusiScriptRunner;
    import net.retrocade.fusi.core.function_script;
    import net.retrocade.fusi.tokens.FusiBaseToken;
    import net.retrocade.fusi.tokens.flow.FusiPauseToken;
    import net.retrocade.fusi.tokens.flow.FusiStopToken;
    import net.retrocade.fusi.tokens.special.FusiThisToken;
    
    import org.flexunit.asserts.assertEquals;
    
    public class StopTokenTest{
        private var functionScript:FusiContext;
        private var functionScriptRunner:FusiScriptRunner;

        [Before]
        public function setUp():void{
            functionScript = new FusiContext({});
            functionScriptRunner = new FusiScriptRunner(new FusiMachine(), functionScript, new Vector.<FusiBaseToken>());
        }
        
        [Test]
        public function testExecute():void{
            functionScriptRunner.currentLine = 10;
            
            var breakToken:FusiStopToken = new FusiStopToken();
            breakToken.execute(functionScript);
            
            assertEquals(0, functionScriptRunner.currentLine);
            assertEquals(true, functionScriptRunner.stopExecution);
        }
    }
}