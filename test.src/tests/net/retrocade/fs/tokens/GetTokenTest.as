package tests.net.retrocade.fs.tokens
{
    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.core.FusiMachine;
    import net.retrocade.fusi.parser.FusiParserAlpha;
    import net.retrocade.fusi.errors.FusiCompilationError;
    import net.retrocade.fusi.errors.FusiError;
    import net.retrocade.fusi.tokens.FusiBaseToken;
    import net.retrocade.fusi.tokens.FusiTokenData;
    import net.retrocade.fusi.tokens.basic.FusiGetToken;
    import net.retrocade.fusi.tokens.primitive.FusiStringToken;

    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.fail;

    public class GetTokenTest{
        private var functionScript:FusiContext;
        
        [Before]
        public function setUp():void{
            functionScript = new FusiContext({
                test:1234, 
                testObject:{
                    subtest:9876
                }
            });
        }
        
        [Test]
        public function testGetToken():void{
            var tokenData:FusiTokenData = new FusiTokenData();
            tokenData.arguments.push(new FusiStringToken("test"));
            
            var token:FusiGetToken = new FusiGetToken(tokenData.arguments);
            assertEquals(1, token.getArgumentCount());
        }
        
        [Test]
        public function testGetToken_zeroArguments():void{
            try{
                new FusiGetToken(new Vector.<FusiBaseToken>());
                fail("Failed");
            } catch (error:FusiCompilationError){
                assertEquals(FusiError.TOO_FEW_ARGUMENTS, error.errorCode);
            }
        }
        
        [Test]
        public function testGetToken_tooManyArguments():void{
            var tokenData:FusiTokenData = new FusiTokenData();
            tokenData.arguments.push(new FusiStringToken("test"));
            tokenData.arguments.push(new FusiStringToken("test"));
            tokenData.arguments.push(new FusiStringToken("test"));
            tokenData.arguments.push(new FusiStringToken("test"));
            
            try{
                new FusiGetToken(tokenData.arguments);
                fail("Failed");
            } catch (error:FusiCompilationError){
                assertEquals(FusiError.TOO_MANY_ARGUMENTS, error.errorCode);
            }
        }
        
        [Test]
        public function testExecute_oneArgument():void{
            var tokenData:FusiTokenData = new FusiTokenData();
            tokenData.arguments.push(new FusiStringToken("test"));
            
            var token:FusiGetToken = new FusiGetToken(tokenData.arguments);
            var result:Number = token.execute(functionScript);
            
            assertEquals(1234, result);
        }
        
        
        [Test]
        public function testExecute_twoArguments():void{
            var subTokenData:FusiTokenData = new FusiTokenData();
            subTokenData.arguments.push(new FusiStringToken("testObject"));

            var subToken:FusiGetToken = new FusiGetToken(subTokenData.arguments);
            var tokenData:FusiTokenData = new FusiTokenData();
            tokenData.arguments.push(new FusiStringToken("subtest"));
            tokenData.arguments.push(subToken);
            
            var token:FusiGetToken = new FusiGetToken(tokenData.arguments);
            var result:Number = token.execute(functionScript);
            
            assertEquals(9876, result);
        }
    }
}