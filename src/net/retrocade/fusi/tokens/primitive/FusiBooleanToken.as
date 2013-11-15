package net.retrocade.fusi.tokens.primitive{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    public class FusiBooleanToken extends FusiBaseToken{
        public var boolean:Boolean;
        
        public function FusiBooleanToken(boolean:Boolean){
            super();
            
            this.boolean = boolean;
        }

        //noinspection JSUnusedLocalSymbols
        override public function execute(fusiContext:FusiContext):* {
            return boolean;
        }
    }
}