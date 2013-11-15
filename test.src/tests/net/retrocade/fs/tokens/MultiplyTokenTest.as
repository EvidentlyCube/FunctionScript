package tests.net.retrocade.fs.tokens{
    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.errors.FusiCompilationError;
    import net.retrocade.fusi.errors.FusiError;
    import net.retrocade.fusi.errors.FusiRuntimeError;
    import net.retrocade.fusi.tokens.FusiBaseToken;
    import net.retrocade.fusi.tokens.FusiTokenData;
    import net.retrocade.fusi.tokens.math.FusiMultiplyToken;
    import net.retrocade.fusi.tokens.primitive.FusiNumberToken;
    import net.retrocade.fusi.tokens.primitive.FusiStringToken;

    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.fail;

    public class MultiplyTokenTest{
        private var functionScript:FusiContext;
        
        [Before]
        public function setUp():void{
            functionScript = new FusiContext({});
        }
        
        [Test]
        public function testMultiply():void{
            var tokenData:FusiTokenData = new FusiTokenData();
            tokenData.arguments.push(new FusiNumberToken(2));
            tokenData.arguments.push(new FusiNumberToken(3));
            tokenData.arguments.push(new FusiNumberToken(4));
            
            var token:FusiMultiplyToken = new FusiMultiplyToken(tokenData.arguments);
            
            var result:Number = token.execute(functionScript);
            assertEquals(2 * 3 * 4, result);
        }
        
        [Test]
        public function testMultiply_float():void{
            var tokenData:FusiTokenData = new FusiTokenData();
            tokenData.arguments.push(new FusiNumberToken(1.5));
            tokenData.arguments.push(new FusiNumberToken(2));
            
            var token:FusiMultiplyToken = new FusiMultiplyToken(tokenData.arguments);
            
            var result:Number = token.execute(functionScript);
            assertEquals(1.5 * 2, result);
        }
        
        [Test]
        public function testMultiply_noArguments():void{
            try{
                new FusiMultiplyToken(new Vector.<FusiBaseToken>());
                fail("Failed");
            } catch (error:FusiCompilationError){
                assertEquals(FusiError.TOO_FEW_ARGUMENTS, error.errorCode);
            }
        }
        
        [Test]
        public function testMultiply_stringArgument():void{
            var tokenData:FusiTokenData = new FusiTokenData();
            tokenData.arguments.push(new FusiNumberToken(1.5));
            tokenData.arguments.push(new FusiStringToken("string"));
            
            try{
                new FusiMultiplyToken(tokenData.arguments);
                fail("Failed");
            } catch (error:FusiCompilationError){
                assertEquals(FusiError.STRING_ARGUMENT_NOT_SUPPORTED, error.errorCode);
            }
        }
        
        
        [Test]
        public function testMultiply_stringArgumentRuntime():void{
            var tokenData:FusiTokenData = new FusiTokenData();
            tokenData.arguments.push(new FusiNumberToken(1.5));
            tokenData.arguments.push(new FusiNumberToken(1.5));
            
            var token:FusiMultiplyToken = new FusiMultiplyToken(tokenData.arguments);
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