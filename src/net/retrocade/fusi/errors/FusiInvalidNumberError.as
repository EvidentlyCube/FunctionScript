package net.retrocade.fusi.errors{
    public class FusiInvalidNumberError extends FusiError{
        public var givenNumber:String;
        
        public function FusiInvalidNumberError(givenNumber:String, message:*="", id:*=0)
        {
            super(message, id);
            
            this.givenNumber = givenNumber;
        }
    }
}