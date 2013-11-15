package net.retrocade.fusi.tokens.primitive{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    public class FusiStringToken extends FusiBaseToken{
        public var string:String;
        
        public function FusiStringToken(string:String){
            super();
            
            this.string = string.replace(/^"|"$/g, "");
        }

        //noinspection JSUnusedLocalSymbols
        override public function execute(fusiContext:FusiContext):* {
            return string;
        }
    }
}