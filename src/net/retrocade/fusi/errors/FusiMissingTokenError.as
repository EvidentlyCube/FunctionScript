package net.retrocade.fusi.errors{
    public class FusiMissingTokenError extends FusiError{
        public var scriptLine:String;
        public function FusiMissingTokenError(line:String, message:*="", id:*=0){
            super(message, id);
            
            scriptLine = line;
        }
    }
}