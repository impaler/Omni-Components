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

	public var format(get_format, set_format):TextFormat;
	public var _format:TextFormat;

	public var text(get_text, set_text):String;
	public var _text:String;

	public var fontName(get_fontName, set_fontName):String;
	public var _fontName:String;

	public var fontSize(get_fontSize, set_fontSize):Int;
	public var _fontSize:Int;

	public var selectable(get_selectable, set_selectable):Bool;
	public var _selectable:Bool;

	public var multiline(get_multiline, set_multiline):Bool;
	public var _multiline:Bool;

	public var wordWrap(get_wordWrap, set_wordWrap):Bool;
	public var _wordWrap:Bool;

#if ( flash || js )
	public var restrict(get_restrict, set_restrict):String;
	public var _restrict:String;
#end

	public var type(get_type, set_type):String;
	public var _type:String;

	public var align(get_align, set_align):String;
	public var _align:String;

	public var fontColor(get_fontColor, set_fontColor):Int;
	public var _fontColor:Int;

	public var fontBold(get_fontBold, set_fontBold):Bool;
	public var _fontBold:Bool;

	public var fontItalic(get_fontItalic, set_fontItalic):Bool;
	public var _fontItalic:Bool;

	public var fontUnderline(get_fontUnderline, set_fontUnderline):Bool;
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

	override public function get_width( ):Float
	{
		return textField.width;
	}

	override public function get_height( ):Float
	{
		return textField.height;
	}

	public function set_fontName( value:String ):String
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

	public function get_fontName( ):String
	{
		return _fontName;
	}

	public function set_text( value:String ):String
	{
		if( _text != value )
		{
			_text = value;
			textField.text = _text;
			invalidate( );
		}
		return _text;
	}

	public function get_text( ):String
	{
		return _text;
	}

	public function set_format( value:TextFormat ):TextFormat
	{
		_format = value;
		updateTextFormat( );

		return _format;
	}

	public function get_format( ):TextFormat
	{
		return _format;
	}

	public function set_fontSize( value:Int ):Int
	{
		_fontSize = value;
		updateTextFormat( );

		return _fontSize;
	}

	public function get_fontSize( ):Int
	{
		return _fontSize;
	}

	public function set_type( value:String ):String
	{
//todo
		_type = value;
		updateTextFormat( );

		return _type;
	}

	public function get_type( ):String
	{
		return _type;
	}

	public function set_align( value:String ):String
	{
//todo
		_align = value;
		updateTextFormat( );

		return _align;
	}

	public function get_align( ):String
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

	public function set_fontColor( value:Int ):Int
	{
//todo
		_fontColor = value;
		updateTextFormat( );

		return _fontColor;
	}

	public function get_fontColor( ):Int
	{
		return _fontColor;
	}

	public function set_selectable( value:Bool )
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

	public function get_selectable( ):Bool
	{
		return _selectable;
	}

	public function set_multiline( value:Bool )
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

	public function get_multiline( ):Bool
	{
		return _multiline;
	}

	public function set_wordWrap( value:Bool )
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

	public function get_wordWrap( ):Bool
	{
		return _wordWrap;
	}

#if (flash || js )
	

	

	

	public function set_restrict( value:String )
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

	public function get_restrict( ):String
	{
		return _restrict;
	}
#end

	public function get_fontBold( ):Bool
	{
		return _fontBold;
	}

	public function set_fontBold( value:Bool ):Bool
	{
		if( _fontBold != value )
		{
			_fontBold = value;
			updateTextFormat( );
		}
		return _fontBold;
	}

	public function get_fontItalic( ):Bool
	{
		return _fontItalic;
	}

	public function set_fontItalic( value:Bool ):Bool
	{
		if( _fontItalic != value )
		{
			_fontItalic = value;
			updateTextFormat( );
		}
		return _fontBold;
	}

	public function get_fontUnderline( ):Bool
	{
		return _fontUnderline;
	}

	public function set_fontUnderline( value:Bool ):Bool
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

	override public function get_styleId( ):String
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