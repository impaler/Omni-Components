package omni.components.gui.text;
class TextArea
{
    public function new()
    {
    }
}

//todo
//	public var autoSize(getAutoSize, setAutoSize):String;
//	public var _autoSize:String;


//todo look at Textarea component
//	public var align(default, setAlign):Dynamic;
//the dimensions are not suitable for any size method
//	public var autoSize(default, null):Dynamic = "left";

//todo textarea
//	public function setAlign( value:Dynamic ):Dynamic
//	{
//		align = Std.string( value );
//		return align;
//	}

//
//private function onScrollBarChange(e:Event = null):void {
//	_textBase.scrollV = _scrollBar.value + 1;
//	moving = false;
//}
//
//private function onScrollBarMove(e:Event = null):void {
//	_textBase.scrollV = _scrollBar.value + 1;
//	moving = true;
//}


//private function onTextChange(e:Event = null):void {
//	_scrollBar.pageSize = _textBase.numLines - _textBase.maxScrollV + 1;
//	_scrollBar.contentSize = _textBase.numLines;
//}
//
//private function onTextScroll(e:Event = null):void {
//	if (!moving) _scrollBar.value = _textBase.scrollV - 1;
//}