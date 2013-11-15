package net.retrocade.fusi.factories{

    import net.retrocade.fusi.errors.FusiInvalidTokenError;
    import net.retrocade.fusi.tokens.FusiBaseToken;
    import net.retrocade.fusi.tokens.FusiTokenData;
    import net.retrocade.fusi.tokens.FusiTokenEnum;
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

    public class FusiTokenFactory{
        public static function isValidToken(token:String):Boolean{
            return FusiTokenEnum.hasName(token);
        }
        
        public static function getTokenInstance(tokenData:FusiTokenData):FusiBaseToken{
            switch(tokenData.type){
                case(FusiTokenEnum.ADD):
                    return new FusiAddToken(tokenData.arguments);

                case(FusiTokenEnum.AND):
                    return new FusiAndToken(tokenData.arguments);

                case(FusiTokenEnum.PAUSE):
                    return new FusiPauseToken();

                case(FusiTokenEnum.CALL):
                    return new FusiCallToken(tokenData.arguments);

                case(FusiTokenEnum.COMP):
                    return new FusiComparisionToken(tokenData.arguments);

                case(FusiTokenEnum.DIV):
                    return new FusiDivideToken(tokenData.arguments);

                case(FusiTokenEnum.ELSE):
                    return new FusiElseToken();

                case(FusiTokenEnum.ENDIF):
                    return new FusiEndifToken();

                case(FusiTokenEnum.GET):
                    return new FusiGetToken(tokenData.arguments);

                case(FusiTokenEnum.GLOBAL):
                    return new FusiGlobalToken();

                case(FusiTokenEnum.GOTO):
                    return new FusiGotoToken(tokenData.arguments);

                case(FusiTokenEnum.IF):
                    return new FusiIfToken(tokenData.arguments);

                case(FusiTokenEnum.LABEL):
                    return new FusiLabelToken(tokenData.arguments);

                case(FusiTokenEnum.MUL):
                    return new FusiMultiplyToken(tokenData.arguments);

                case(FusiTokenEnum.NOOP):
                    return new FusiNoopToken();

                case(FusiTokenEnum.OR):
                    return new FusiOrToken(tokenData.arguments);

                case(FusiTokenEnum.SET):
                    return new FusiSetToken(tokenData.arguments);

                case(FusiTokenEnum.STOP):
                    return new FusiStopToken();

                case(FusiTokenEnum.SUB):
                    return new FusiSubtractToken(tokenData.arguments);

                case(FusiTokenEnum.THIS):
                    return new FusiThisToken();

                default:
                    throw new FusiInvalidTokenError(tokenData.type.name, "\"" + tokenData.type.name + "\" is not a valid token");
            }
        }
    }
}