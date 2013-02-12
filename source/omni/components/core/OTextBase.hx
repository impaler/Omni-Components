package omni.components.core;

import omni.utils.ColorUtils;
import omni.utils.ComponentUtils;
import omni.components.core.interfaces.IOComponent;
import omni.components.style.OBaseStyle;

import nme.Lib;
import nme.Assets;
import nme.text.AntiAliasType;
import nme.text.TextFormatAlign;
import nme.text.TextFieldAutoSize;
import nme.text.TextFieldType;
import nme.display.Sprite;
import nme.events.Event;
import nme.text.TextField;
import nme.text.TextFormat;

class OTextBase extends OComponent
{

	public var textField(default, null):TextField;

	public var format(getFormat, setFormat):TextFormat;
	public var _format:TextFormat;

	public var text(getText, setText):String;
	public var _text:String;

	public var fontName(getFontName, setFontName):String;
	public var _fontName:String;

	public var fontSize(getFontSize, setFontSize):Int;
	public var _fontSize:Int;

	public var selectable(getSelectable, setSelectable):Bool;
	public var _selectable:Bool;

	public var multiline(getMultiline, setMultiline):Bool;
	public var _multiline:Bool;

	public var wordWrap(getWordWrap, setWordWrap):Bool;
	public var _wordWrap:Bool;

#if ( flash || js )
	public var restrict(getRestrict, setRestrict):String;
	public var _restrict:String;
#end

	public var type(getType, setType):String;
	public var _type:String;

	public var align(getAlign, setAlign):String;
	public var _align:String;

	public var fontColor(getFontColor, setFontColor):Int;
	public var _fontColor:Int;

	public var fontBold(getFontBold, setFontBold):Bool;
	public var _fontBold:Bool;

	public var fontItalic(getFontItalic, setFontItalic):Bool;
	public var _fontItalic:Bool;

	public var fontUnderline(getFontUnderline, setFontUnderline):Bool;
	public var _fontUnderline:Bool;

	override public function destroy( ):Void
	{
		super.destroy( );

		textField = null;
		_format = null;
	}

	override public function createComponentMembers( ):Void
	{
		super.createComponentMembers( );

		textField = new TextField();
		sprite.addChild( textField );

//todo style layer
		textField.antiAliasType = AntiAliasType.ADVANCED;
		textField.border = true;
		textField.embedFonts = true;
	}

	public function updateTextFieldProperties( ):Void
	{
		textField.selectable = _selectable;
		textField.multiline = _multiline;
		textField.wordWrap = _wordWrap;
#if (flash || js)
		textField.restrict = _restrict;
#end

		if( textField.text != _text )
			textField.text = _text;
	}

	public function updateTextFormat( ):Void
	{

//		_fontBold,
//		_fontItalic,
//		_fontUnderline,

		_format = new TextFormat(
		_fontName, _fontSize, _fontColor, null, //todo			_fontBold,
		null, //todo			_fontItalic,
		null, //todo			_fontUnderline,
		null, //todo			_fontURL,
		null, //todo			_fontTarget,
		ComponentUtils.convertTextAlignmentFromString( _align ), null, //todo			_fontLeftMargin,
		null, //todo			_fontRightMargin,
		null, //todo			_fontIndent,
		null
//todo			_fontLeading
		);
		textField.defaultTextFormat = _format;
		textField.setTextFormat( _format ) ;
	}

//***********************************************************
//                  Properties
//***********************************************************

	override public function getWidth( ):Float
	{
		return textField.width;
	}

	override public function getHeight( ):Float
	{
		return textField.height;
	}

	public function setFontName( value:String ):String
	{
		if( value != _fontName )
		{
			_fontName = value;
			updateTextFormat( );
			return _fontName;
		}
		else
		{
			return null;
		}
	}

	public function getFontName( ):String
	{
		return _fontName;
	}

	public function setText( value:String ):String
	{
		if( _text != value )
		{
			_text = value;
			textField.text = _text;
			invalidate( );
		}
		return _text;
	}

	public function getText( ):String
	{
		return _text;
	}

	public function setFormat( value:TextFormat ):TextFormat
	{
		_format = value;
		updateTextFormat( );

		return _format;
	}

	public function getFormat( ):TextFormat
	{
		return _format;
	}

	public function setFontSize( value:Int ):Int
	{
		_fontSize = value;
		updateTextFormat( );

		return _fontSize;
	}

	public function getFontSize( ):Int
	{
		return _fontSize;
	}

	public function setType( value:String ):String
	{
//todo
		_type = value;
		updateTextFormat( );

		return _type;
	}

	public function getType( ):String
	{
		return _type;
	}

	public function setAlign( value:String ):String
	{
//todo
		_align = value;
		updateTextFormat( );

		return _align;
	}

	public function getAlign( ):String
	{
		return _align;
	}

//	public function setAutoSize( value:String ):String
//	{
//		//todo
//		_autoSize = value;
//		updateTextFieldProperties( );
//
//		return _autoSize;
//	}
//
//	public function getAutoSize( ):String
//	{
//		return _autoSize;
//	}

	public function setFontColor( value:Int ):Int
	{
//todo
		_fontColor = value;
		updateTextFormat( );

		return _fontColor;
	}

	public function getFontColor( ):Int
	{
		return _fontColor;
	}

	public function setSelectable( value:Bool )
	{
		if( _selectable != value )
		{
			_selectable = value;
			if( textField != null )
			{
				textField.selectable = _selectable;
			}
		}
		return _selectable;
	}

	public function getSelectable( ):Bool
	{
		return _selectable;
	}

	public function setMultiline( value:Bool )
	{
		if( _multiline != value )
		{
			_multiline = value;
			if( textField != null )
			{
				textField.multiline = _multiline;
			}
		}
		return _multiline;
	}

	public function getMultiline( ):Bool
	{
		return _multiline;
	}

	public function setWordWrap( value:Bool )
	{
		if( _wordWrap != value )
		{
			_wordWrap = value;
			if( textField != null )
			{
				textField.wordWrap = _wordWrap;
			}
		}
		return _wordWrap;
	}

	public function getWordWrap( ):Bool
	{
		return _wordWrap;
	}

#if (flash || js )
	

	

	public function setRestrict( value:String )
	{
		if( _restrict != value )
		{
			_restrict = value;
			if( textField != null )
			{
				textField.restrict = _restrict;
			}
		}
		return _restrict;
	}

	public function getRestrict( ):String
	{
		return _restrict;
	}
#end

	public function getFontBold( ):Bool
	{
		return _fontBold;
	}

	public function setFontBold( value:Bool ):Bool
	{
		if( _fontBold != value )
		{
			_fontBold = value;
			updateTextFormat( );
		}
		return _fontBold;
	}

	public function getFontItalic( ):Bool
	{
		return _fontItalic;
	}

	public function setFontItalic( value:Bool ):Bool
	{
		if( _fontItalic != value )
		{
			_fontItalic = value;
			updateTextFormat( );
		}
		return _fontBold;
	}

	public function getFontUnderline( ):Bool
	{
		return _fontUnderline;
	}

	public function setFontUnderline( value:Bool ):Bool
	{
		if( _fontUnderline != value )
		{
			_fontUnderline = value;
			updateTextFormat( );
		}
		return _fontBold;
	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function getStyleId( ):String
	{
		return TextBaseStyle.styleString;
	}

}

class TextBaseStyle extends OBaseStyle
{

	public static var styleString:String = "TextBaseStyle";

	public var selectable:Bool;
	public var multiline:Bool;
	public var wordWrap:Bool;
	public var fontSize:Int;
	public var fontName:String;
	public var fontColor:Int;
	public var defaultText:String;

//type dynamic as a workaround for flash/cpp type check inconsistency
	public var type(default, setType):Dynamic;

//todo Restrict is not available on cpp neko yet?
	public var restrict:String;

	public function new( )
	{
		super( );
		styleID = styleString;

		selectable = false;
		multiline = false;
		wordWrap = false;
		fontSize = 15;
		var font = Assets.getFont( "assets/themes/color/text/roboto-regular.ttf" );
		fontName = font.fontName;
		fontColor = ColorUtils.BLACK;
		defaultText = "Hello World";
	}

	public override function initStyle( value:IOComponent ):Void
	{
		super.initStyle( value );

//todo defaults??
		var textComponent = cast ( value, OTextBase);
		textComponent._fontName = fontName;
		textComponent._selectable = selectable;
		textComponent._multiline = multiline;
		textComponent._wordWrap = wordWrap;
		textComponent._fontSize = fontSize;
		textComponent._type = type;
		textComponent._align = ComponentUtils.convertTextAlignmentToString( TextFormatAlign.LEFT );
		textComponent._fontColor = fontColor;
#if (flash || js)
		textComponent._restrict = restrict;
#end
		if( defaultText != null && textComponent._text == null )
			textComponent._text = defaultText;
	}

	override public function update( value:IOComponent ):Void
	{
		var textBase = cast ( value, OTextBase);

		textBase.updateTextFieldProperties( );
		textBase.updateTextFormat( );

		textBase.textField.width = textBase._width;
		textBase.textField.height = textBase._height;
	}

	public function setType( value:Dynamic ):String
	{
		type = Std.string( value );
		return type;
	}

	override public function destroy( ):Void
	{
	}
}