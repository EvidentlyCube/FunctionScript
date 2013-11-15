package tests.net.retrocade.fs.tokens{
    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.core.FusiMachine;
    import net.retrocade.fusi.parser.FusiParserAlpha;
    import net.retrocade.fusi.errors.FusiCompilationError;
    import net.retrocade.fusi.errors.FusiError;
    import net.retrocade.fusi.errors.FusiRuntimeError;
    import net.retrocade.fusi.tokens.FusiBaseToken;
    import net.retrocade.fusi.tokens.FusiTokenData;
    import net.retrocade.fusi.tokens.math.FusiAddToken;
    import net.retrocade.fusi.tokens.primitive.FusiNumberToken;
    import net.retrocade.fusi.tokens.primitive.FusiStringToken;

    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.fail;

    public class AddTokenTest{
        private var functionScript:FusiContext;
        
        [Before]
        public function setUp():void{
            functionScript = new FusiContext({});
        }
        
        [Test]
        public function testAddition():void{
            var tokenData:FusiTokenData = new FusiTokenData();
            tokenData.arguments.push(new FusiNumberToken(10));
            tokenData.arguments.push(new FusiNumberToken(13));
            tokenData.arguments.push(new FusiNumberToken(17));
            tokenData.arguments.push(new FusiNumberToken(23));
            tokenData.arguments.push(new FusiNumberToken(67));
            
            var token:FusiAddToken = new FusiAddToken(tokenData.arguments);
            
            var result:Number = token.execute(functionScript);
            assertEquals(10+13+17+23+67, result);
        }
        
        [Test]
        public function testAddition_float():void{
            var tokenData:FusiTokenData = new FusiTokenData();
            tokenData.arguments.push(new FusiNumberToken(1.5));
            tokenData.arguments.push(new FusiNumberToken(1.5));
            
            var token:FusiAddToken = new FusiAddToken(tokenData.arguments);
            
            var result:Number = token.execute(functionScript);
            assertEquals(1.5+1.5, result);
        }
        
        [Test]
        public function testAddition_noArguments():void{
            try{
                new FusiAddToken(new Vector.<FusiBaseToken>());
                fail("Failed");
            } catch (error:FusiCompilationError){
                assertEquals(FusiError.TOO_FEW_ARGUMENTS, error.errorCode);
            }
        }
        
        [Test]
        public function testAddition_stringArgument():void{
            var tokenData:FusiTokenData = new FusiTokenData();
            tokenData.arguments.push(new FusiNumberToken(1.5));
            tokenData.arguments.push(new FusiStringToken("string"));
            
            try{
                new FusiAddToken(tokenData.arguments);
                fail("Failed");
            } catch (error:FusiCompilationError){
                assertEquals(FusiError.STRING_ARGUMENT_NOT_SUPPORTED, error.errorCode);
            }
        }
        
        
        [Test]
        public function testAddition_stringArgumentRuntime():void{
            var tokenData:FusiTokenData = new FusiTokenData();
            tokenData.arguments.push(new FusiNumberToken(1.5));
            tokenData.arguments.push(new FusiNumberToken(1.5));
            
            var token:FusiAddToken = new FusiAddToken(tokenData.arguments);
            token.addArgument(new FusiStringToken("lol"));
            
            try{
                token.execute(functionScript);
                fail("Failed");
            } catch (error:FusiRuntimeError){
                assertEquals(FusiError.ONLY_NUMERIC_ARGUMENTS, error.errorCode);
            }
        }
    }
}