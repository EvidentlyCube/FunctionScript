package net.retrocade.fusi.tokens.special{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    public class FusiThisToken extends FusiBaseToken{
        public function FusiThisToken(){
            super();
        }
        
        override public function execute(fusiContext:FusiContext):* {
            return fusiContext;
        }
    }
}