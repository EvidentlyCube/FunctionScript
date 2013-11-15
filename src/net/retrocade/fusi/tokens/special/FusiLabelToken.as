package net.retrocade.fusi.tokens.special{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.errors.FusiCompilationError;
    import net.retrocade.fusi.errors.FusiError;
    import net.retrocade.fusi.tokens.FusiBaseToken;
    import net.retrocade.fusi.tokens.primitive.FusiStringToken;

    public class FusiLabelToken extends FusiBaseToken{
        public var labelName:String;

        public function FusiLabelToken(arguments:Vector.<FusiBaseToken>){
            super();

            tokenArguments = arguments;

            if (getArgumentCount() < 1){
                throw new FusiCompilationError("LABEL() requires one argument, " + getArgumentCount() + " given", FusiError.TOO_FEW_ARGUMENTS);
            } else if (getArgumentCount() > 1){
                throw new FusiCompilationError("LABEL() requires one argument, " + getArgumentCount() + " given", FusiError.TOO_MANY_ARGUMENTS);
            }

            var argument:* = tokenArguments[0];

            if (!(argument is FusiStringToken)){
                throw new FusiCompilationError("LABEL() requires its only argument to be plain string", FusiError.STRING_ARGUMENT_REQUIRED);
            }

            var stringToken:FusiStringToken = FusiStringToken(argument);

            labelName = stringToken.string;
        }
        
        override public function execute(fusiContext:FusiContext):* {
            return fusiContext;
        }
    }
}