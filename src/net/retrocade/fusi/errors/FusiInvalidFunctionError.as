package net.retrocade.fusi.errors{
    public class FusiInvalidFunctionError extends FusiError{
        public var functionName:String;
        
        public function FusiInvalidFunctionError(functionName:String, message:*="", id:*=0){
            super(message, id);
            
            this.functionName = functionName;
        }
    }
}