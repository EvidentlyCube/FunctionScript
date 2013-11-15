package net.retrocade.fusi.tokens.special{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.core.function_script;
    import net.retrocade.fusi.errors.FusiCompilationError;
    import net.retrocade.fusi.errors.FusiError;
    import net.retrocade.fusi.tokens.FusiBaseToken;
    import net.retrocade.fusi.tokens.primitive.FusiStringToken;

    use namespace function_script;

    public class FusiGotoToken extends FusiBaseToken{
        public var labelName:String;

        public function FusiGotoToken(arguments:Vector.<FusiBaseToken>){
            super();

            tokenArguments = arguments;

            if (getArgumentCount() < 1){
                throw new FusiCompilationError("GOTO() requires one argument, " + getArgumentCount() + " given", FusiError.TOO_FEW_ARGUMENTS);
            } else if (getArgumentCount() > 1){
                throw new FusiCompilationError("GOTO() requires one argument, " + getArgumentCount() + " given", FusiError.TOO_MANY_ARGUMENTS);
            }

            var argument:* = tokenArguments[0];

            if (!(argument is FusiStringToken)){
                throw new FusiCompilationError("GOTO() requires its only argument to be plain string", FusiError.STRING_ARGUMENT_REQUIRED);
            }

            var stringToken:FusiStringToken = FusiStringToken(argument);

            labelName = stringToken.string;
        }
        
        override public function execute(fusiContext:FusiContext):* {
            fusiContext.__scriptRunner.parseGotoLabel();
        }
    }
}