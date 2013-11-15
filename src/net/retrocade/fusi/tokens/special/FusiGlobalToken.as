package net.retrocade.fusi.tokens.special{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.core.function_script;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    use namespace function_script;

    public class FusiGlobalToken extends FusiBaseToken{
        public function FusiGlobalToken(){
            super();
        }
        
        override public function execute(fusiContext:FusiContext):* {
            return fusiContext.__scriptRunner.functionScriptMachine.globalContext;
        }
    }
}