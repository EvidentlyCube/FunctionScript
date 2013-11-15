package net.retrocade.fusi.tokens.condition{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.core.FusiMachine;
    import net.retrocade.fusi.core.function_script;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    use namespace function_script;

    public class FusiOrToken extends FusiBaseToken{
        public function FusiOrToken(arguments:Vector.<FusiBaseToken>){
            super();

            tokenArguments = arguments;
        }
        
        override public function execute(fusiContext:FusiContext):* {
            for (var i:int = 0; i < tokenArguments.length; i++){
                var tokenArgument:FusiBaseToken = tokenArguments[i];
                var result:* = tokenArgument.execute(fusiContext);
                
                if (FusiMachine.evaluatesToTrue(result)){
                    return true;
                }
            }

            return false;
        }
    }
}