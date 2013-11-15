package net.retrocade.fusi.tokens.primitive{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.errors.FusiCompilationError;
    import net.retrocade.fusi.errors.FusiError;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    public class FusiNumberToken extends FusiBaseToken{
        public var number:Number;
        
        public function FusiNumberToken(number:Number){
            super();
            
            this.number = number;
            
            if (isNaN(this.number)){
                throw new FusiCompilationError("Given number couldn't be parsed to a real number, \"" + number + "\" given", FusiError.NOT_A_REAL_NUMBER);
            }
        }

        //noinspection JSUnusedLocalSymbols
        override public function execute(fusiContext:FusiContext):* {
            return number;
        }
    }
}