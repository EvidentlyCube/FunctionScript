package net.retrocade.fusi.tokens{

    import net.retrocade.fusi.core.FusiContext;

    public class FusiBaseToken{
        protected var tokenArguments:Vector.<FusiBaseToken>;
        
        public function FusiBaseToken(){}
        
        public function getRawArguments():Vector.<FusiBaseToken>{
            return tokenArguments;
        }
        
        public function getArgumentCount():uint{
            return tokenArguments.length;
        }
        
        public function getArgumentValue(index:int, functionScript:FusiContext, defaultTo:* = null):*{
            if (tokenArguments.length <= index){
                if (defaultTo !== null){
                    return defaultTo;
                } else {
                    throw new ArgumentError("Tried to access unexistant argument: " + index + " out of " + tokenArguments.length);
                }
            }
            
            return tokenArguments[index].execute(functionScript);
        }

        public function addArgument(argument:FusiBaseToken):void{
            tokenArguments.push(argument);
        }

        //noinspection JSUnusedLocalSymbols
        public function execute(fusiContext:FusiContext):* {
            
        }
    }
}