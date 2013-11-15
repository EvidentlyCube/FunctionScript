package net.retrocade.fusi.tokens.math{

    import flash.utils.getQualifiedClassName;

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.errors.FusiCompilationError;
    import net.retrocade.fusi.errors.FusiError;
    import net.retrocade.fusi.errors.FusiRuntimeError;
    import net.retrocade.fusi.tokens.FusiBaseToken;
    import net.retrocade.fusi.tokens.primitive.FusiStringToken;

    public class FusiDivideToken extends FusiBaseToken{
        public function FusiDivideToken(arguments:Vector.<FusiBaseToken>){
            super();

            tokenArguments = arguments;

            if (getArgumentCount() < 2){
                throw new FusiCompilationError("Too little arguments passed, DIV() requires at least two", FusiError.TOO_FEW_ARGUMENTS);
            } else {
                for each(var argument:FusiBaseToken in tokenArguments){
                    if (argument is FusiStringToken){
                        throw new FusiCompilationError("DIV", FusiError.STRING_ARGUMENT_NOT_SUPPORTED);
                    }
                }
            }
        }
        
        override public function execute(fusiContext:FusiContext):* {
            var i:int = 0;
            var l:uint = getArgumentCount();
            
            var result:Number = NaN;
            var divisor:*;
            
            for(; i < l; i++){
                divisor = getArgumentValue(i, fusiContext);
                
                if (!(divisor is Number)){
                    throw new FusiRuntimeError("Only numeric arguments are supported, \"" + getQualifiedClassName(divisor)
                        + "\" given on argument " + i, FusiError.ONLY_NUMERIC_ARGUMENTS);
                }
                
                if (isNaN(result)){
                    result = divisor;
                } else {
                    result /= divisor;
                }
            }
            
            return result;
        }
    }
}