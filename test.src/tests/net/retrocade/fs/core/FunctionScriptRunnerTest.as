package tests.net.retrocade.fs.core{

    import avmplus.factoryXml;

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.core.FusiMachine;
    import net.retrocade.fusi.parser.FusiParserAlpha;
    import net.retrocade.fusi.core.FusiScriptRunner;
    import net.retrocade.fusi.tokens.flow.FusiElseToken;
    import net.retrocade.fusi.tokens.flow.FusiEndifToken;
    import net.retrocade.fusi.tokens.FusiBaseToken;
    import net.retrocade.fusi.tokens.basic.FusiGetToken;
    import net.retrocade.fusi.tokens.flow.FusiIfToken;
    import net.retrocade.fusi.tokens.primitive.FusiBooleanToken;
    import net.retrocade.fusi.tokens.special.FusiNoopToken;
    
    import org.flexunit.asserts.assertEquals;

    public class FunctionScriptRunnerTest{
        private var runner:FusiScriptRunner;
        private var machine:FusiMachine;
        
        [Before]
        public function setUp():void{
            machine = new FusiMachine();
        }
        
        [Test]
        public function testGotoElseAndIf_simpleIf():void{
            var script:Vector.<FusiBaseToken> = new Vector.<FusiBaseToken>();
            script.push(new FusiIfToken(new <FusiBaseToken>[new FusiNoopToken()]));
            script.push(new FusiNoopToken());
            script.push(new FusiNoopToken());
            script.push(new FusiEndifToken());
            
            runner = new FusiScriptRunner(machine, new FusiContext({}), script);
            runner.currentLine = 1;
            runner.gotoElseEndif();
            
            assertEquals(4, runner.currentLine);
        }
        
        [Test]
        public function testGotoElseAndIf_nestedIf():void{
            var script:Vector.<FusiBaseToken> = new Vector.<FusiBaseToken>();
            script.push(new FusiIfToken(new <FusiBaseToken>[new FusiBooleanToken(false)]));
            script.push(new FusiNoopToken());
            script.push(new FusiNoopToken());
            script.push(new FusiIfToken(new <FusiBaseToken>[new FusiNoopToken()]));
            script.push(new FusiNoopToken());
            script.push(new FusiNoopToken());
            script.push(new FusiEndifToken());
            script.push(new FusiNoopToken());
            script.push(new FusiEndifToken());
            
            runner = new FusiScriptRunner(machine, new FusiContext({}), script);
            runner.currentLine = 1;
            runner.gotoElseEndif();
            
            assertEquals(9, runner.currentLine);
        }
        
        [Test]
        public function testGotoElseAndIf_else():void{
            var script:Vector.<FusiBaseToken> = new Vector.<FusiBaseToken>();
            script.push(new FusiIfToken(new <FusiBaseToken>[new FusiNoopToken()]));
            script.push(new FusiNoopToken());
            script.push(new FusiNoopToken());
            script.push(new FusiElseToken());
            script.push(new FusiNoopToken());
            script.push(new FusiEndifToken());
            
            runner = new FusiScriptRunner(machine, new FusiContext({}), script);
            runner.currentLine = 1;
            runner.gotoElseEndif();
            
            assertEquals(4, runner.currentLine);
        }
        
    }
}