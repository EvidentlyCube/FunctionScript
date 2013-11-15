package net.retrocade.fusi.errors{
    public class FusiError extends Error{
        public static const TOO_MANY_ARGUMENTS:int = 1000;
        public static const TOO_FEW_ARGUMENTS:int = 1001;
        public static const STRING_ARGUMENT_NOT_SUPPORTED:int = 1002;
        public static const STRING_ARGUMENT_REQUIRED:int = 1003;
        public static const TOO_MANY_ARGUMENTS_FOR_CALL:int = 1004;
        public static const NOT_A_REAL_NUMBER:int = 2000;
        public static const INVALID_STRING:int = 2001;
        public static const UNEXPECTED_ENDIF:int = 3000;
        public static const USED_ELSE_OUTSIDE_IF:int = 3001;
        public static const USED_ELSE_INSIDE_ELSE:int = 3002;
        public static const ONLY_NUMERIC_ARGUMENTS:int = 5000;
        public static const EXCEEDED_MAX_LINES_EXECUTION:int = 6000;

        private var _errorCode:int;

        public function FusiError(message:*="", id:*=0){
            super(message, id);

            _errorCode = id;
        }

        public function get errorCode():int{
            return _errorCode;
        }
    }
}