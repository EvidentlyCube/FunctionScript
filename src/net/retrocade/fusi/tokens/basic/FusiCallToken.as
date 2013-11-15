package net.retrocade.fusi.tokens.basic{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.errors.FusiCompilationError;
    import net.retrocade.fusi.errors.FusiError;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    public class FusiCallToken extends FusiBaseToken{
        public function FusiCallToken(arguments:Vector.<FusiBaseToken>){
            super();

            tokenArguments = arguments;

            if (getArgumentCount() > 7){
                throw new FusiCompilationError("Functions with " + (getArgumentCount() - 2) + " are not supported, max 7 arguments supported.", FusiError.TOO_MANY_ARGUMENTS_FOR_CALL);
            }
        }
        
        override public function execute(fusiContext:FusiContext):* {
            var methodName:String = getArgumentValue(0, fusiContext);
            var callee    :Object = getArgumentValue(1, fusiContext, fusiContext);
            var arguments :Array = [];
            
            for(var i:int = 2, l:int = getArgumentCount(); i < l; i++){ 
                arguments.push(getArgumentValue(i, fusiContext));
            }

            return callee[methodName].apply(null, arguments);
        }
    }
}