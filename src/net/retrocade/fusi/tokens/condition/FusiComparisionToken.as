package net.retrocade.fusi.tokens.condition{

    import net.retrocade.fusi.core.FusiContext;
    import net.retrocade.fusi.errors.FusiCompilationError;
    import net.retrocade.fusi.errors.FusiError;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    public class FusiComparisionToken extends FusiBaseToken{
        public static const CONDITION_EQUALS:String = "==";
        public static const CONDITION_EQUALS_STRICT:String = "===";
        public static const CONDITION_NOT_EQUALS:String = "!=";
        public static const CONDITION_NOT_EQUALS_STRICT:String = "!==";
        public static const CONDITION_SMALLER:String = "<";
        public static const CONDITION_SMALLER_OR_EQUAL:String = "<=";
        public static const CONDITION_GREATER:String = ">";
        public static const CONDITION_GREATER_OR_EQUAL:String = ">=";

        public function FusiComparisionToken(arguments:Vector.<FusiBaseToken>){
            super();

            tokenArguments = arguments;

            if (getArgumentCount() < 3){
                throw new FusiCompilationError("COMP() requires three arguments, " + getArgumentCount() + " given", FusiError.TOO_FEW_ARGUMENTS);
            } else if (getArgumentCount() > 3){
                throw new FusiCompilationError("COMP() requires three arguments, " + getArgumentCount() + " given", FusiError.TOO_MANY_ARGUMENTS);
            }
        }
        
        override public function execute(fusiContext:FusiContext):* {
            var valueLeft:* = getArgumentValue(0, fusiContext);
            var valueRight:* = getArgumentValue(2, fusiContext);
            var comparisionSign:* = getArgumentValue(1, fusiContext);

            switch(comparisionSign){
                case(CONDITION_EQUALS):
                    return valueLeft == valueRight;
                case(CONDITION_NOT_EQUALS):
                    return valueLeft != valueRight;
                case(CONDITION_EQUALS_STRICT):
                    return valueLeft === valueRight;
                case(CONDITION_NOT_EQUALS_STRICT):
                    return valueLeft !== valueRight;
                case(CONDITION_SMALLER):
                    return valueLeft < valueRight;
                case(CONDITION_SMALLER_OR_EQUAL):
                    return valueLeft <= valueRight;
                case(CONDITION_GREATER):
                    return valueLeft > valueRight;
                case(CONDITION_GREATER_OR_EQUAL):
                    return valueLeft >= valueRight;
                default:
                    throw new FusiCompilationError("Invalid comparison sign, " + comparisionSign);
            }
        }
    }
}