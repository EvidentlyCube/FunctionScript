package net.retrocade.fusi.core{
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;
    import flash.utils.getQualifiedClassName;
    
    import net.retrocade.fusi.errors.FusiInvalidFunctionError;
    import net.retrocade.fusi.tokens.FusiBaseToken;

    use namespace flash_proxy;
    use namespace function_script
    
    final public class FusiContext extends Proxy{
        function_script var __thisObject:Object;
        function_script var __virtualProperties:Array;
        function_script var __scriptRunner:FusiScriptRunner;
        
        public function FusiContext(thisObject:*){
            __thisObject = thisObject;
            __virtualProperties = [];
        }
        
        override flash_proxy function getProperty(name:*):*{
            name = name.localName;
            
            if (__thisObject && __thisObject.hasOwnProperty(name)){
                return __thisObject[name];
            } else {
                return __virtualProperties[name];
            }
        }
        
        override flash_proxy function setProperty(name:*, value:*):void{
            name = name.localName;
            
            if (__thisObject && __thisObject.hasOwnProperty(name)){
                __thisObject[name] = value;
            } else {
                __virtualProperties[name] = value;
            }
        }
        
        override flash_proxy function callProperty(name:*, ...parameters):*{
            name = name.localName;
            
            switch(name){
                case("valueOf"):
                    return this;
                    
                case("toString"):
                    return getQualifiedClassName(this);
            }
            
            if (__thisObject && __thisObject.hasOwnProperty(name)){
                Function(__thisObject[name]).apply(__thisObject, parameters);
            } else {
                throw new FusiInvalidFunctionError(name, "Tried to call non-existant method \"" + name + "\"");
            }
        }
    }
}