package net.retrocade.fusi.tokens.special{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    public class FusiNoopToken extends FusiBaseToken{
        public function FusiNoopToken(){
            super();
        }

        //noinspection JSUnusedLocalSymbols
        override public function execute(fusiContext:FusiContext):* {
            return null;
        }
    }
}