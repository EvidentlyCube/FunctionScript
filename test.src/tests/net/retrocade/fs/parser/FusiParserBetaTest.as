/**
 * Created with IntelliJ IDEA.
 * User: mzarzycki
 * Date: 15.11.13
 * Time: 16:17
 * To change this template use File | Settings | File Templates.
 */
package tests.net.retrocade.fs.parser {

    import net.retrocade.fusi.core.function_script;
    import net.retrocade.fusi.parser.FusiParserBeta;

    import org.flexunit.asserts.assertEquals;

    use namespace function_script;

    public class FusiParserBetaTest {
        public var parser:FusiParserBeta;

        public function FusiParserBetaTest() {
        }

        [Before]
        public function setup():void{
            parser = new FusiParserBeta();
        }

        [Test]
        public function shouldSplitTokensOnSemicolons():void {
            var script:String = 'GET("a");GET("b");';

            var stringTokens:Vector.<String> = parser.splitIntoStringTokens(script);

            assertEquals(2, stringTokens.length);
            assertEquals('GET("a")', stringTokens[0]);
            assertEquals('GET("b")', stringTokens[1]);
        }

        [Test]
        public function shouldSplitTokensOnSemicolonsAndBraces():void {
            var script:String = 'IF("a"){GET("b");}GET("c");';

            var stringTokens:Vector.<String> = parser.splitIntoStringTokens(script);

            assertEquals(3, stringTokens.length);
            assertEquals('IF("a")', stringTokens[0]);
            assertEquals('GET("b")', stringTokens[1]);
            assertEquals('GET("c")', stringTokens[2]);
        }

        [Test]
        public function shouldSkipUnnecessaryWhitespaceWhenSplittingTokens():void {
            var script:String = '  IF("a")   {  GET("b")\n\n;\n\n  \n}\nGET("c")\n;';

            var stringTokens:Vector.<String> = parser.splitIntoStringTokens(script);

            assertEquals(3, stringTokens.length);
            assertEquals('IF("a")', stringTokens[0]);
            assertEquals('GET("b")', stringTokens[1]);
            assertEquals('GET("c")', stringTokens[2]);
        }
    }
}
