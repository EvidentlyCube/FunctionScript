package net.retrocade.fusi.core{

    import net.retrocade.fusi.parser.FusiParserAlpha;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    use namespace function_script;

    public class FusiMachine{
        function_script var parser:FusiParserAlpha;
        
        public var maxLinesPerExecution:int = 10000;
        private var _globalContext:FusiContext;
        
        public function FusiMachine(){
            parser = new FusiParserAlpha();
            _globalContext = new FusiContext(null);
        }

        public function getScriptRunner(script:String, thisObject:Object):IFusiScriptRunner{
            var compiledScript:Vector.<FusiBaseToken> = parser.parseScript(script);

            var functionScript:FusiContext = new FusiContext(thisObject);
            var scriptRunner  :FusiScriptRunner = new FusiScriptRunner(this, functionScript, compiledScript);
            
            return scriptRunner;
        }

        public function set globalObject(value:*):void{
            _globalContext.__thisObject = value;
        }
        
        function_script function getParser():FusiParserAlpha{
            return parser;
        }
        
        function_script static function standarizeLinefeeds(string:String):String{
            return string.replace(/(\r\n|\n\r)/gi, "\n");
        }
        
        function_script static function trimWhitespace(line:String):String{
            return line.replace(/^\s+|\s+$/gi, "");
        }

        public function get globalContext():FusiContext {
            return _globalContext;
        }

        function_script static function evaluatesToTrue(value:*):Boolean {
            return !(value === null || value === 0 || value === false || (value is Number && isNaN(value)));
        }
    }
}