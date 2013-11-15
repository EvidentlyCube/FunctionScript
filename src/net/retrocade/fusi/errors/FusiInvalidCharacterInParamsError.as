package net.retrocade.fusi.errors{
    public class FusiInvalidCharacterInParamsError extends FusiError{
        public var paramsString:String;
        public function FusiInvalidCharacterInParamsError(paramsString:String, message:*="", id:*=0){
            super(message, id);
            
            this.paramsString = paramsString;
        }
    }
}