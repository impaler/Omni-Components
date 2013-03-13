package omni.components.gui.controls;

import omni.components.core.OCore;
import omni.utils.signals.OSignalType;
import omni.components.core.OComponentButton;
import omni.components.gui.layout.list.List;
import omni.components.gui.layout.list.ListItem;

import nme.geom.Point;

class SelectList extends OComponentButton {

	public var list:List;

	public var selectedSoloItem:ListItem;
	public var selectedItems:Array<ListItem>;
	
	public var multipleSelections:Bool;
	
	public var onChange:OSignalType<SelectList>;

	public function openList( ):Void
	{
		list.visible = false;
		OCore.instance.popupsLayer.addChild(list.sprite);
		
		var pos = this.sprite.localToGlobal( new Point(this.sprite.x, this.sprite.y) );
		list.move(pos.x, pos.y);
		list.visible = true;
	}

	public function closeList( ):Void
	{
		OCore.instance.popupsLayer.removeChild(list.sprite);
	}


//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return SelectListStyle.styleString;
	}
}

class SelectListStyle extends OComponentButtonStyle
{
	public static var styleString:String = "SelectListStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}