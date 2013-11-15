package{
    import flash.display.Sprite;
    
    import net.retrocade.fusi.core.FusiMachine;
    import net.retrocade.fusi.parser.FusiParserAlpha;
    
    public class Main extends Sprite{
        public function Main(){
            
        }
    }
}

/* Example script:

SPECIAL COMMANDS:
 - LABEL(x) - declares a label
 - GOTO(x) - moves the script pointer to the given label name
 - PAUSE - Stops execution of the code at this point and on next run continues from the next line
 - STOP - Stops execution of the code at this point and continues from the start on the next run
 - THIS - a special token which evaluates to the script object and its properties
 - GLOBAL - a special token which evaluates to the global object and its properties (defined in FusiMachine)
 - IF, ELSE and ENDIF work like that:
    IF
        <test>
        <if body>
    ELSE <optional>
        <else body>
    ENDIF

FUNCTIONS:
 - SET(<variable>,<value>,[object=THIS]) - sets variable named <variable> on <object> to <value>
 - GET(<variable>,[object=THIS]) - retrieves the value of variable named <variable> from <object>
 - ADD(<addend>,<addend>,[addend]...) - retrieves the value of adding all <addends>
 - SUB(<minuend>, <subtrahend>, [subtrahend]...) - retrieves the value of subtracting <subtrahend> from <minuend>
 - MUL(<multiplicand>,<multiplicand>,[multiplicand]...) - retrieves the value of multiplying all <multiplicands>
 - DIV(<dividend>,<divisor>) - retrieves the value of dividing <dividend> by <divisor>
 - CALL(<method>, [object=THIS], [arguments) - calls method named <method> on <object>
 - AND(<condition>,<condition>,[condition]...) - Returns true if all <conditions> evaluate to true
 - OR(<condition>,<condition>,[condition]...) - Returns true if any <condition> evaluates to true

*/