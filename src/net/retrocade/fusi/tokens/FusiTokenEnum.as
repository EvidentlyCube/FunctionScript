package net.retrocade.fusi.tokens {

    import flash.errors.MemoryError;

    import net.retrocade.fusi.tokens.basic.FusiCallToken;

    import net.retrocade.fusi.tokens.basic.FusiGetToken;
    import net.retrocade.fusi.tokens.basic.FusiSetToken;
    import net.retrocade.fusi.tokens.condition.FusiAndToken;
    import net.retrocade.fusi.tokens.condition.FusiComparisionToken;
    import net.retrocade.fusi.tokens.condition.FusiOrToken;
    import net.retrocade.fusi.tokens.flow.FusiPauseToken;
    import net.retrocade.fusi.tokens.flow.FusiElseToken;
    import net.retrocade.fusi.tokens.flow.FusiEndifToken;
    import net.retrocade.fusi.tokens.flow.FusiIfToken;
    import net.retrocade.fusi.tokens.flow.FusiStopToken;
    import net.retrocade.fusi.tokens.math.FusiAddToken;
    import net.retrocade.fusi.tokens.math.FusiDivideToken;
    import net.retrocade.fusi.tokens.math.FusiMultiplyToken;
    import net.retrocade.fusi.tokens.math.FusiSubtractToken;
    import net.retrocade.fusi.tokens.special.FusiGlobalToken;
    import net.retrocade.fusi.tokens.special.FusiGotoToken;
    import net.retrocade.fusi.tokens.special.FusiLabelToken;
    import net.retrocade.fusi.tokens.special.FusiNoopToken;
    import net.retrocade.fusi.tokens.special.FusiThisToken;

    public class FusiTokenEnum {
        private static var _creationLock:Boolean = false;
        private static var _collection:Vector.<FusiTokenEnum> = new Vector.<FusiTokenEnum>();

        public static var ADD:FusiTokenEnum = new FusiTokenEnum(0, "ADD", FusiAddToken);
        public static var AND:FusiTokenEnum = new FusiTokenEnum(1, "AND", FusiAndToken);
        public static var PAUSE:FusiTokenEnum = new FusiTokenEnum(2, "PAUSE", FusiPauseToken);
        public static var CALL:FusiTokenEnum = new FusiTokenEnum(3, "CALL", FusiCallToken);
        public static var COMP:FusiTokenEnum = new FusiTokenEnum(4, "COMP", FusiComparisionToken);
        public static var DIV:FusiTokenEnum = new FusiTokenEnum(5, "DIV", FusiDivideToken);
        public static var ELSE:FusiTokenEnum = new FusiTokenEnum(6, "ELSE", FusiElseToken);
        public static var ENDIF:FusiTokenEnum = new FusiTokenEnum(7, "ENDIF", FusiEndifToken);
        public static var GET:FusiTokenEnum = new FusiTokenEnum(8, "GET", FusiGetToken);
        public static var GLOBAL:FusiTokenEnum = new FusiTokenEnum(9, "GLOBAL", FusiGlobalToken);
        public static var GOTO:FusiTokenEnum = new FusiTokenEnum(10, "GOTO", FusiGotoToken);
        public static var IF:FusiTokenEnum = new FusiTokenEnum(11, "IF", FusiIfToken);
        public static var LABEL:FusiTokenEnum = new FusiTokenEnum(12, "LABEL", FusiLabelToken);
        public static var MUL:FusiTokenEnum = new FusiTokenEnum(13, "MUL", FusiMultiplyToken);
        public static var NOOP:FusiTokenEnum = new FusiTokenEnum(14, "NOOP", FusiNoopToken);
        public static var OR:FusiTokenEnum = new FusiTokenEnum(15, "OR", FusiOrToken);
        public static var SET:FusiTokenEnum = new FusiTokenEnum(16, "SET", FusiSetToken);
        public static var STOP:FusiTokenEnum = new FusiTokenEnum(17, "STOP", FusiStopToken);
        public static var SUB:FusiTokenEnum = new FusiTokenEnum(18, "SUB", FusiSubtractToken);
        public static var THIS:FusiTokenEnum = new FusiTokenEnum(19, "THIS", FusiThisToken);

        {
            _creationLock = true;
        }

        private var _id:int;
        private var _name:String;
        private var _metadata:Object;

        public function get id():int {
            return _id;
        }

        public function get name():String {
            return _name;
        }

        public function get metadata():Object {
            return _metadata;
        }

        public function get tokenClass():Class{
            return _metadata as Class;
        }

        public function FusiTokenEnum(id:int, name:String, metadata:Object = null) {
            if (_creationLock) {
                throw new MemoryError("Cannot create instances of Enum class");
            }

            _id = id;
            _name = name;
            _metadata = metadata;

            _collection.push(this);
        }

        public static function byId(id:int):FusiTokenEnum {
            for each(var element:FusiTokenEnum in _collection) {
                if (element._id == id) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid ID");
        }

        public static function byName(name:String):FusiTokenEnum {
            for each(var element:FusiTokenEnum in _collection) {
                if (element._name == name) {
                    return element;
                }
            }

            throw new ArgumentError("Invalid name");
        }

        public static function hasId(id:int):Boolean{
            for each(var element:FusiTokenEnum in _collection) {
                if (element._id == id) {
                    return true;
                }
            }

            return false;
        }

        public static function hasName(name:String):Boolean{
            for each(var element:FusiTokenEnum in _collection) {
                if (element._name == name) {
                    return true;
                }
            }

            return false;
        }
    }
}
