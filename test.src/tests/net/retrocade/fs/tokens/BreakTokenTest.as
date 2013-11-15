package tests.net.retrocade.fs.tokens{
    import flexunit.framework.Assert;
    
    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.core.FusiMachine;
    import net.retrocade.fusi.parser.FusiParserAlpha;
    import net.retrocade.fusi.core.FusiScriptRunner;
    import net.retrocade.fusi.core.function_script;
    import net.retrocade.fusi.tokens.FusiBaseToken;
    import net.retrocade.fusi.tokens.flow.FusiPauseToken;
    import net.retrocade.fusi.tokens.special.FusiThisToken;
    
    import org.flexunit.asserts.assertEquals;
    
    public class BreakTokenTest{
        private var functionScript:FusiContext;
        private var functionScriptRunner:FusiScriptRunner;

        [Before]
        public function setUp():void{
            functionScript = new FusiContext({});
            functionScriptRunner = new FusiScriptRunner(new FusiMachine(), functionScript, new Vector.<FusiBaseToken>());
        }
        
        [Test]
        public function testExecute():void{
            var breakToken:FusiPauseToken = new FusiPauseToken();
            breakToken.execute(functionScript);
            
            assertEquals(true, functionScriptRunner.stopExecution);
        }
    }
}