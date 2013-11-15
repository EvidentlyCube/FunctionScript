package net.retrocade.fusi.tokens.basic{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    public class FusiSetToken extends FusiBaseToken{
        public function FusiSetToken(arguments:Vector.<FusiBaseToken>){
            super();

            tokenArguments = arguments;
        }
        
        override public function execute(fusiContext:FusiContext):* {
            var name:String = getArgumentValue(0, fusiContext);
            var setTo:* = getArgumentValue(1, fusiContext);
            var object:Object = getArgumentValue(2, fusiContext, fusiContext);
            
            object[name] = setTo;
            
            return object[name];
        }
    }
}