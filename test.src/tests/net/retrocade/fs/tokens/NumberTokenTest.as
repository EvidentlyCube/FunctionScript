package tests.net.retrocade.fs.tokens
{
    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.core.FusiMachine;
    import net.retrocade.fusi.parser.FusiParserAlpha;
    import net.retrocade.fusi.errors.FusiCompilationError;
    import net.retrocade.fusi.errors.FusiError;
    import net.retrocade.fusi.tokens.primitive.FusiNumberToken;

    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.fail;

    public class NumberTokenTest{
        private var functionScript:FusiContext;
        
        [Before]
        public function setUp():void{
            functionScript = new FusiContext({});
        }
        
        [Test]
        public function testExecute():void{
            var token:FusiNumberToken = new FusiNumberToken(1234);
            assertEquals(1234, token.execute(functionScript));
        }
        
        [Test]
        public function testNumberToken():void{
            var token:FusiNumberToken = new FusiNumberToken(1234);
            assertEquals(1234, token.number);
        }
        
        [Test]
        public function testNumberToken_fraction():void{
            var token:FusiNumberToken = new FusiNumberToken(5.5);
            assertEquals(5.5, token.number);
        }
        
        [Test]
        public function testNumberToken_notANumber():void{
            try{
                new FusiNumberToken(NaN);
                fail("Failed");
            } catch (error:FusiCompilationError){
                assertEquals(FusiError.NOT_A_REAL_NUMBER, error.errorCode);
            }
            
        }
    }
}