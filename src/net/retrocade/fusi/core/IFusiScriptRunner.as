package net.retrocade.fusi.core{
    public interface IFusiScriptRunner{
        function run():void;
        function getProperty(name:String):*;
        function setProperty(name:String, value:*):void;
    }
}