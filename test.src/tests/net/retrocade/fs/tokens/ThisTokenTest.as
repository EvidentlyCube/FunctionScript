package tests.net.retrocade.fs.tokens{
    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.tokens.special.FusiThisToken;
    
    import org.flexunit.asserts.assertEquals;
    
    public class ThisTokenTest{
        private var functionScript:FusiContext;

        [Before]
        public function setUp():void{
            functionScript = new FusiContext({});
        }
        
        [Test]
        public function testExecute():void{
            var thisToken:FusiThisToken = new FusiThisToken();
            var result:* = thisToken.execute(functionScript);
            
            assertEquals(functionScript, result);
        }
    }
}