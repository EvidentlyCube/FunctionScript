package net.retrocade.fusi.tokens.flow{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.core.function_script;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    use namespace function_script;
    
    public class FusiElseToken extends FusiBaseToken{
        public function FusiElseToken(){
            super();
        }
        
        override public function execute(fusiContext:FusiContext):* {
            fusiContext.__scriptRunner.gotoElseEndif();
        }
    }
}