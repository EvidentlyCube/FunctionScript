package net.retrocade.fusi.tokens.flow{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.core.function_script;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    use namespace function_script;
    
    public class FusiStopToken extends FusiBaseToken{
        public function FusiStopToken(){
            super();
        }
        
        override public function execute(fusiContext:FusiContext):* {
            fusiContext.__scriptRunner.currentLine = 0;
            fusiContext.__scriptRunner.stopExecution = true;
        }
    }
}