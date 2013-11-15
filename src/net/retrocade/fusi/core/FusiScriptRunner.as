package net.retrocade.fusi.core{

    import net.retrocade.fusi.errors.FusiError;
    import net.retrocade.fusi.errors.FusiRuntimeError;
    import net.retrocade.fusi.tokens.FusiBaseToken;
    import net.retrocade.fusi.tokens.flow.FusiElseToken;
    import net.retrocade.fusi.tokens.flow.FusiEndifToken;
    import net.retrocade.fusi.tokens.flow.FusiIfToken;
    import net.retrocade.fusi.tokens.special.FusiGotoToken;
    import net.retrocade.fusi.tokens.special.FusiLabelToken;

    use namespace function_script;

    public class FusiScriptRunner implements IFusiScriptRunner{
        public var functionScriptMachine:FusiMachine;
        public var currentLine:int = 0;
        public var totalLines :int = 0;
        public var stopExecution:Boolean = false;
        public var functionScript:FusiContext;
        public var script:Vector.<FusiBaseToken>;

        private var _labelMap:Array;

        public function FusiScriptRunner(
                functionScriptMachine:FusiMachine,
                functionScript:FusiContext,
                script:Vector.<FusiBaseToken>
        ){
            this.functionScript = functionScript;
            this.script = script;
            this.functionScriptMachine = functionScriptMachine;
         
            totalLines = script.length;
            
            functionScript.__scriptRunner = this;

            _labelMap = [];

            buildLabelMap(script);
        }

        private function buildLabelMap(script:Vector.<FusiBaseToken>):void {
            var i:uint = 0;
            var l:uint = script.length;
            for (; i < l; i++) {
                var scriptToken:FusiBaseToken = script[i];

                if (scriptToken is FusiLabelToken) {
                    _labelMap[FusiLabelToken(scriptToken).labelName] = i;
                }
            }
        }
        
        public function run():void{
            stopExecution = false;
            
            var linesExecuted:int = 0;
            
            if (currentLine == totalLines){
                currentLine = 0;
            }
            
            while(currentLine < totalLines && !stopExecution){
                script[currentLine++].execute(functionScript);
                
                if (++linesExecuted == functionScriptMachine.maxLinesPerExecution){
                    throw new FusiRuntimeError("Exceeded script max lines execution limit per frame", FusiError.EXCEEDED_MAX_LINES_EXECUTION);
                }
            }
        }
        
        public function getProperty(name:String):*{
            return functionScript[name];
        }
        
        public function setProperty(name:String, value:*):void{
            functionScript[name] = value;
        }
        
        public function parseGotoLabel():void{
            var labelName:String = FusiGotoToken(script[currentLine - 1]).labelName;

            currentLine = _labelMap[labelName];
        }
        
        public function gotoElseEndif():void{
            var ifCount:int = 1;
            var inElse:Boolean = false;
            var currentToken:FusiBaseToken;
            
            do {
                currentToken = script[currentLine++];
                
                if (currentToken is FusiIfToken){
                    ifCount++;
                } else if (currentToken is FusiEndifToken){
                    if (inElse){
                        inElse = false;
                    } else {
                        ifCount--;
                    }
                } else if (currentToken is FusiElseToken){
                    inElse = true;
                    ifCount--;
                }
                
            } while(ifCount > 0);
        }
    }
}