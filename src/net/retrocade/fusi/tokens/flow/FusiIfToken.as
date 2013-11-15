package net.retrocade.fusi.tokens.flow{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.core.FusiMachine;
    import net.retrocade.fusi.core.function_script;
    import net.retrocade.fusi.errors.FusiCompilationError;
    import net.retrocade.fusi.errors.FusiError;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    use namespace function_script;
    
    public class FusiIfToken extends FusiBaseToken{
        public function FusiIfToken(arguments:Vector.<FusiBaseToken>){
            super();

            tokenArguments = arguments;

            if (getArgumentCount() < 1){
                throw new FusiCompilationError("IF() requires one argument, " + getArgumentCount() + " given", FusiError.TOO_FEW_ARGUMENTS);
            } else if (getArgumentCount() > 1){
                throw new FusiCompilationError("IF() requires one argument, " + getArgumentCount() + " given", FusiError.TOO_MANY_ARGUMENTS);
            }
        }
        
        override public function execute(fusiContext:FusiContext):* {
            var result:* = getArgumentValue(0, fusiContext);

            if (!FusiMachine.evaluatesToTrue(result)){
                fusiContext.__scriptRunner.gotoElseEndif();
            }
        }
    }
}