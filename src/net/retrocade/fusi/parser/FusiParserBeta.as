package net.retrocade.fusi.parser{

    import net.retrocade.fusi.core.*;
    import net.retrocade.fusi.core.FusiMachine;
    import net.retrocade.fusi.errors.FusiCompilationError;
    import net.retrocade.fusi.errors.FusiError;
    import net.retrocade.fusi.errors.FusiInvalidCharacterInParamsError;
    import net.retrocade.fusi.errors.FusiInvalidStringError;
    import net.retrocade.fusi.errors.FusiInvalidTokenError;
    import net.retrocade.fusi.errors.FusiMissingTokenError;
    import net.retrocade.fusi.factories.FusiTokenFactory;
    import net.retrocade.fusi.tokens.FusiBaseToken;
    import net.retrocade.fusi.tokens.FusiTokenData;
    import net.retrocade.fusi.tokens.FusiTokenEnum;
    import net.retrocade.fusi.tokens.flow.FusiElseToken;
    import net.retrocade.fusi.tokens.flow.FusiEndifToken;
    import net.retrocade.fusi.tokens.flow.FusiIfToken;
    import net.retrocade.fusi.tokens.primitive.FusiNumberToken;
    import net.retrocade.fusi.tokens.primitive.FusiStringToken;

    use namespace function_script;

    /**
     * The basic parser for the Function Script supports all basic constructs and has the following limitations:
     *  - Each token has to be separated with a semicolon:
     *    GET("x", GET("player"));
     *    GET("y", GET("player"));
     *    or
     *    GET("x", GET("player")); GET("y");
     *    are both correct.
     *  - For the sake of internal algorithms, braces { and } are considered separators equal to semicolon
     *  - Closing braces are a special case of element, as depending on the context, they'll insert ENDIF token
     *    in their place
     *
     * SPECIAL COMMANDS:
     * - LABEL(x) - declares a label
     * - GOTO(x) - moves the script pointer to the given label name
     * - PAUSE - Stops execution of the code at this point and on next run continues from the next line
     * - STOP - Stops execution of the code at this point and continues from the start on the next run
     * - THIS - a special token which evaluates to the script object and its properties
     * - GLOBAL - a special token which evaluates to the global object and its properties (defined in FusiMachine)
     * - IF, ELSE and ENDIF work like that:
     *      IF(<condition>)
     *          <if body>
     *      ELSE [else is optional]
     *          <else body>
     *      ENDIF
     *
     * FUNCTIONS:
     * - SET(<variable>,<value>,[object=THIS]) - sets variable named <variable> on <object> to <value>
     * - GET(<variable>,[object=THIS]) - retrieves the value of variable named <variable> from <object>
     * - ADD(<addend>,<addend>,[addend]...) - retrieves the value of adding all <addends>
     * - SUB(<minuend>, <subtrahend>, [subtrahend]...) - retrieves the value of subtracting <subtrahend> from <minuend>
     * - MUL(<multiplicand>,<multiplicand>,[multiplicand]...) - retrieves the value of multiplying all <multiplicands>
     * - DIV(<dividend>,<divisor>) - retrieves the value of dividing <dividend> by <divisor>
     * - CALL(<method>, [object=THIS], [arguments) - calls method named <method> on <object>
     * - AND(<condition>,<condition>,[condition]...) - Returns true if all <conditions> evaluate to true
     * - OR(<condition>,<condition>,[condition]...) - Returns true if any <condition> evaluates to true
     */
    final public class FusiParserBeta{
        public function FusiParserBeta(){
        }

        public function parseScript(script:String):Vector.<FusiBaseToken>{
            script = FusiMachine.standarizeLinefeeds(script);
            
            var stringTokens:Vector.<String> = splitIntoStringTokens(script);
            
            var currentLine:int = 0;
            var parsedLines:Vector.<FusiBaseToken> = new Vector.<FusiBaseToken>(stringTokens.length);
            
            var ifCount:int = 0;
            var elseStack:Vector.<Boolean> = new Vector.<Boolean>(10);
            
            var newToken:FusiBaseToken;
            
            for each(var line:String in stringTokens){
                line = FusiMachine.trimWhitespace(line);
                
                if (line.length == 0){
                    continue;
                }
                
                newToken = createToken(line);
                
                if (newToken is FusiIfToken){
                    ifCount++;
                    
                } else if (newToken is FusiEndifToken){
                    elseStack[ifCount] = false;
                    ifCount--;
                    
                    if (ifCount < 0){
                        throw new FusiCompilationError("Endif without a matching if", FusiError.UNEXPECTED_ENDIF);
                    }
                } else if (newToken is FusiElseToken){
                    if (elseStack[ifCount]){
                        throw new FusiCompilationError("Else inside another else", FusiError.USED_ELSE_INSIDE_ELSE);
                    } else if (ifCount == 0){
                        throw new FusiCompilationError("Used else outside an if", FusiError.USED_ELSE_OUTSIDE_IF);
                    } else {
                        elseStack[ifCount] = true;
                    }
                }
                
                parsedLines[currentLine++] = newToken;
            }
            
            return parsedLines;
        }

        function_script function splitIntoStringTokens(script:String):Vector.<String>{
            var stringTokens:Vector.<String> = new Vector.<String>();

            var scriptLength:uint = script.length;
            var i:uint = 0;

            var currentTokenStartAt:uint = 0;
            var insideString:Boolean = false;

            while (i < scriptLength){
                var charCode:uint = script.charCodeAt(i);

                switch(charCode){
                    case(59): // ;
                    case(123): // {
                    case(125): // }
                            if (!insideString){
                                var stringToken:String = FusiMachine.trimWhitespace(
                                        script.substring(currentTokenStartAt, i)
                                );

                                if (stringToken.length > 0){
                                    stringTokens.push(stringToken);
                                }

                                currentTokenStartAt = i + 1;
                            }
                        break;

                    case(34): // "
                            insideString = !insideString;
                        break;

                    case(92): // \
                            if (insideString){
                                i += 1;
                            }
                        break;
                }

                i += 1;
            }

            return stringTokens;
        }

        private function createToken(tokenString:String):FusiBaseToken{
            var tokenNameMatch:Array = tokenString.match(/^[a-zA-Z]+/);

            if (tokenNameMatch && tokenNameMatch.length){
                return extractSecondaryToken(tokenString, tokenNameMatch[0]);

            } else if (tokenString.charAt(0) === '"'){
                return extractStringToken(tokenString);

            } else {
                return extractNumberToken(tokenString);
            }
        }

        private static function extractNumberToken(tokenString:String):FusiNumberToken{
            var tokenValueNumber:Number = parseFloat(tokenString);
            if (isNaN(tokenValueNumber)){
                throw new FusiMissingTokenError(tokenString, "No token found");
            }

            return new FusiNumberToken(tokenValueNumber);
        }

        private function extractSecondaryToken(tokenString:String, tokenName:String):FusiBaseToken{
            var tokenData:FusiTokenData = new FusiTokenData();

            if (FusiTokenFactory.isValidToken(tokenName)){
                tokenData.type = FusiTokenEnum.byName(tokenName);

                var argumentsAsString:Vector.<String> = splitParametersString(tokenString.substr(tokenName.length));

                var l:int = argumentsAsString.length;

                for (var i:int = 0; i < l; i++){
                    tokenData.arguments.push(createToken(argumentsAsString[i]));
                }

            } else {
                throw new FusiInvalidTokenError(tokenName, "Unknown token");
            }

            return FusiTokenFactory.getTokenInstance(tokenData);
        }

        public static function splitParametersString(paramString:String):Vector.<String>{
            var index:int = 0;
            var length:int = paramString.length;
            var parenthesisCount:uint = 0;
            
            var insideString:Boolean = false;
            var currentChar:String;
            var currentCharCode:int;
            
            var parameter:String = "";
            var paramsList:Vector.<String> = new Vector.<String>();
            
            if (paramString.length == 0){
                return paramsList;
            }
            
            do {
                currentCharCode = paramString.charCodeAt(index);
                currentChar = paramString.charAt(index++);
                
                switch(currentCharCode){
                    case(40): // (
                        parameter += (parenthesisCount > 0 ? currentChar : '');
                        if (!insideString){
                            parenthesisCount++;
                        }
                        break;
                    
                    case(41): // )
                        if (!insideString){
                            parenthesisCount--;
                        }
                        parameter += (parenthesisCount > 0 ? currentChar : '');
                        break;
                    
                    case(34): // "
                        insideString = !insideString;
                        parameter += currentChar;
                        break;
                    
                    case(92): // \
                        if (insideString){
                            parameter += paramString.substr(index - 1, 2);
                            index++;
                        } else {
                            throw new FusiInvalidCharacterInParamsError(paramString, "Backslash used outside string");
                        }
                        break;
                    
                    case(44): // ,
                        if (parenthesisCount == 1 && !insideString){
                            paramsList.push(FusiMachine.trimWhitespace(parameter));
                            parameter = "";
                        } else {
                            parameter += currentChar;
                        }
                        break;
                    
                    default:
                        parameter += currentChar;
                        break;
                }
            } while(parenthesisCount > 0 && index < length);
            
            if (parenthesisCount != 0){
                throw new FusiInvalidCharacterInParamsError(paramString, "Number of parentheses didn't match after string ended");
            }
            
            if (index != length){
                throw new FusiInvalidCharacterInParamsError(paramString, "Closed param list but still had characters left");
            }
            
            paramsList.push(FusiMachine.trimWhitespace(parameter));
            
            return paramsList;
        }

        protected static function extractStringToken(string:String):FusiStringToken{
            var firstChar:String = string.charAt(0);
            var stringLength:uint = string.length;

            var currentCharacter:String;

            var index:int = 0;
            do {
                currentCharacter = string.charAt(++index);

                if (currentCharacter === "\\"){
                    index += 1;
                }
            } while (index < stringLength && currentCharacter !== firstChar);

            if (currentCharacter !== firstChar){
                throw new FusiInvalidStringError("Invalid string found: " + string, FusiError.INVALID_STRING);
            }

            return new FusiStringToken(string.substring(1, index));
        }
    }
}