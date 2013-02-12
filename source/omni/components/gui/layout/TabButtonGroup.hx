package omni.components.gui.layout;

import omni.components.core.OToggleButtonGroup;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IStyle;
import omni.components.gui.layout.ContainerPage;
import omni.components.gui.controls.TabButton;
import omni.components.core.OToggleButtonGroup.OToggleButtonGroupStyle;
import omni.components.gui.layout.Layout.LayoutStyle;
import omni.components.core.signals.OSignalType;
import omni.components.core.OToggleButton;
import omni.components.core.OComponent;
import omni.components.style.OBackgroundStyle;

class TabButtonGroup extends OToggleButtonGroup
{
	public var onTabButtonChange:OSignalType<TabButton -> Void>;

//***********************************************************
//                  Component Core
//***********************************************************

	override public function createMembers( ):Void
	{
		super.createMembers( );

//todo style layer
		layout.direction = Layout.HORIZONTALLY;
		onTabButtonChange = new OSignalType<TabButton -> Void>();
	}

	override public function destroy( ):Void
	{
		onTabButtonChange.destroy( );

		super.destroy( );
	}

//***********************************************************
//                  Event Handlers
//***********************************************************

	override public function handleButtonChange( button:OToggleButton ):Void
	{
		super.handleButtonChange( button );
		onTabButtonChange.dispatch( cast(button, TabButton) );
	}

//***********************************************************
//                  Component Methods
//***********************************************************

	public function addTabButton( page:ContainerPage, style:IStyle = null ):TabButton
	{
		var button = new TabButton(style);
		button.containerPage = page;
		button.onChange.add( handleButtonChange );
		this.components.push( button );
		layout.add( button );

		return button;
	}

	public function setActiveButton( button:TabButton ):Void
	{
		button.handleSetTrue( );
		update( );
	}

//***********************************************************
//                  Properties
//***********************************************************

//***********************************************************
//                  Component Style
//***********************************************************

	override public function getStyleId( ):String
	{
		return TabButtonGroupStyle.styleString;
	}
}

class TabButtonGroupStyle extends OToggleButtonGroupStyle
{
	public static var styleString:String = "TabButtonGroupStyle";

	public function new( )
	{
		super( );
		defaultDirection = Layout.HORIZONTALLY;
		styleID = styleString;
	}

	override public function initStyle( value:IOComponent ):Void
	{
		var styleAs = cast (value, OToggleButtonGroup);

		styleAs.direction = defaultDirection;

		super.initStyle( value );
	}
}