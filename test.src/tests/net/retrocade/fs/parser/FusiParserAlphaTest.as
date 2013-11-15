package tests.net.retrocade.fs.parser
{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.core.FusiMachine;
    import net.retrocade.fusi.errors.FusiCompilationError;
    import net.retrocade.fusi.errors.FusiError;
    import net.retrocade.fusi.parser.FusiParserAlpha;
    import net.retrocade.fusi.tokens.FusiBaseToken;
    import net.retrocade.fusi.tokens.basic.FusiGetToken;
    import net.retrocade.fusi.tokens.primitive.FusiStringToken;

    import org.flexunit.asserts.assertEquals;
    import org.flexunit.asserts.assertTrue;
    import org.flexunit.asserts.fail;

    public class FusiParserAlphaTest
    {		
        private var parser:FusiParserAlpha;
        private var functionScript:FusiContext;
        
        [Before]
        public function setUp():void{
            parser = new FusiParserAlpha();
            functionScript = new FusiContext({});
        }
        
        [Test]
        public function testParseToken_noParams():void{
            var result:Vector.<String> = FusiParserAlpha.splitParametersString("()");
            
            assertEquals(1, result.length);
            assertEquals("", result[0]);
        }
        
        [Test]
        public function testParseToken_oneParam():void{
            var result:Vector.<String> = FusiParserAlpha.splitParametersString("(param)");
            
            assertEquals(1, result.length);
            assertEquals("param", result[0]);
        }
        
        [Test]
        public function testParseToken_twoParams():void{
            var result:Vector.<String> = FusiParserAlpha.splitParametersString("(param1,param2)");
            
            assertEquals(2, result.length);
            assertEquals("param1", result[0]);
            assertEquals("param2", result[1]);
        }
        
        [Test]
        public function testParseToken_paramsTrimmed():void{
            var result:Vector.<String> = FusiParserAlpha.splitParametersString("( param1   , param2   )");
            
            assertEquals(2, result.length);
            assertEquals("param1", result[0]);
            assertEquals("param2", result[1]);
        }
        
        [Test]
        public function testParseToken_stringParam():void{
            var result:Vector.<String> = FusiParserAlpha.splitParametersString('("test", "par)", "par(", "\\"", ",")');
            
            assertEquals(5, result.length);
            assertEquals('"test"', result[0]);
            assertEquals('"par)"', result[1]);
            assertEquals('"par("', result[2]);
            assertEquals('"\\""', result[3]);
            assertEquals('","', result[4]);
        }
        
        [Test]
        public function testParseToken_realTest():void{
            var result:Vector.<String> = FusiParserAlpha.splitParametersString('("name", GET("player", GET("instance", "object")))');
            
            assertEquals(2, result.length);
            assertEquals('"name"', result[0]);
            assertEquals('GET("player", GET("instance", "object"))', result[1]);
        }
        
        [Test]
        public function testParseScript():void{
            var result:Vector.<FusiBaseToken> = parser.parseScript("GET(1)");
            
            assertEquals(1, result.length);
            assertTrue(result[0] is FusiGetToken);
            assertEquals(1, result[0].getArgumentValue(0, functionScript));
        }
        
        [Test]
        public function testParseScript_nestedFunctions():void{
            var result:Vector.<FusiBaseToken> = parser.parseScript('GET(GET("a"), GET("played"))');
            
            assertEquals(1, result.length);
            assertTrue(result[0] is FusiGetToken);
            
            var rawArguments:Vector.<FusiBaseToken> = result[0].getRawArguments();
            
            assertEquals(2, rawArguments.length);
            assertTrue(rawArguments[0] is FusiGetToken);
            assertTrue(rawArguments[1] is FusiGetToken);
            
            var rawArguments1:Vector.<FusiBaseToken> = rawArguments[0].getRawArguments();
            var rawArguments2:Vector.<FusiBaseToken> = rawArguments[1].getRawArguments();
            
            assertEquals(1, rawArguments1.length);
            assertEquals(1, rawArguments2.length);
            assertTrue(rawArguments1[0] is FusiStringToken);
            assertTrue(rawArguments2[0] is FusiStringToken);
            assertEquals("a", rawArguments1[0].execute(functionScript));
            assertEquals("played", rawArguments2[0].execute(functionScript));
        }
        
        [Test]
        public function testParseScript_ifs():void{
            var script:String = "GET(1)\n" +
                "IF(GET(1))\n" +
                "  GET(1)\n" +
                "ELSE\n" +
                "  GET(1)\n" +
                "ENDIF";
            
            var result:int = parser.parseScript(script).length;
            assertEquals(6, result);
        }
        
        [Test]
        public function testParseScript_nestedIfs():void{
            var script:String = "GET(1)\n" +
                "IF(GET(1))\n" +
                "  GET(1)\n" +
                "  IF(GET(1))\n" +
                "  ELSE\n" +
                "    GET(1)\n" +
                "  ENDIF\n" +
                "ELSE\n" +
                "  GET(1)\n" +
                "  IF(GET(1))\n" +
                "  ELSE\n" +
                "    GET(1)\n" +
                "  ENDIF\n" +
                "ENDIF";
            
            var result:int= parser.parseScript(script).length;
            assertEquals(14, result);
        }
        
        [Test]
        public function testParseScript_elseOutsideIf():void{
            var script:String = "GET(1)\n" +
                "ELSE";
            
            try {
                parser.parseScript(script);
                fail("Failed");
            } catch (error:FusiCompilationError){
                assertEquals(FusiError.USED_ELSE_OUTSIDE_IF, error.errorCode);
            }
        }
        
        [Test]
        public function testParseScript_endifWithoutIf():void{
            var script:String = "GET(1)\n" +
                "ENDIF";
            
            try {
                parser.parseScript(script);
                fail("Failed");
            } catch (error:FusiCompilationError){
                assertEquals(FusiError.UNEXPECTED_ENDIF, error.errorCode);
            }
        }
        
        
        [Test]
        public function testParseScript_doubleElse():void{
            var script:String = "GET(1)\n" +
                "IF(GET(1))\n" +
                "ELSE\n" +
                "  GET(1)\n" +
                "ELSE\n" +
                "  GET(1)\n" +
                "ENDIF";
            
            try {
                parser.parseScript(script);
                fail("Failed");
            } catch (error:FusiCompilationError){
                assertEquals(FusiError.USED_ELSE_INSIDE_ELSE, error.errorCode);
            }
        }
    }
}