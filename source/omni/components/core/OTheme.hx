package omni.components.core;

import omni.components.core.interfaces.IDestroyable;
import omni.components.core.interfaces.IStyle;
import nme.system.System;

import omni.components.style.base.OBaseStyle;

/**
 * OTheme
 */
class OTheme implements IDestroyable
{
	#if haxe3 
	var _stylesHash:Map<String,OBaseStyle>;
	#else
	var _stylesHash:Hash<OBaseStyle>;
	#end

	public function new( )
	{
		#if haxe3 
		_stylesHash = new Map();
		#else
		_stylesHash = new Hash();
		#end
	}

	public var themeName(get_themeName, null):String;

	public function get_themeName( ):String
	{
		return Type.getClassName( Type.getClass( this ) );
	}

	public function addStyle( style:Class<OBaseStyle> ):Void
	{
		var styleInstance:OBaseStyle = Type.createInstance( style, [] );
		_stylesHash.set( styleInstance.styleID, styleInstance );
	}

	public function getStyle( styleID:String ):OBaseStyle
	{
		var styleInstance:OBaseStyle = cast ( _stylesHash.get( styleID ), OBaseStyle);
		return styleInstance;
	}

	public function initTheme(  ):Void
	{
	}

	public function destroy( ):Void
	{
		for( style in _stylesHash )
		{
			style.destroy( );
		}
		_stylesHash = null;
	}

}


