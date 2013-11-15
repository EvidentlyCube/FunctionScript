package net.retrocade.fusi.errors{

    public class FusiInvalidTokenError extends FusiError{
        public var givenToken:String;
        public function FusiInvalidTokenError(givenToken:String, message:*="", id:*=0)
        {
            super(message, id);
            
            this.givenToken = givenToken;
        }
    }
}