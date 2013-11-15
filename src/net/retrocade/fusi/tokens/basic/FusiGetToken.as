package net.retrocade.fusi.tokens.basic{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.errors.FusiCompilationError;
    import net.retrocade.fusi.errors.FusiError;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    public class FusiGetToken extends FusiBaseToken{
        public function FusiGetToken(arguments:Vector.<FusiBaseToken>){
            super();

            tokenArguments = arguments;

            if (getArgumentCount() < 1){
                throw new FusiCompilationError("GET() requires at least one argument, " + getArgumentCount() + " given", FusiError.TOO_FEW_ARGUMENTS);
            } else if (getArgumentCount() > 2){
                throw new FusiCompilationError("GET() takes up to two argument, " + getArgumentCount() + " given", FusiError.TOO_MANY_ARGUMENTS);
            }
        }
        
        override public function execute(fusiContext:FusiContext):* {
            var name:String = getArgumentValue(0, fusiContext);
            var object:Object = getArgumentValue(1, fusiContext, fusiContext);
            
            return object[name];
        }
    }
}