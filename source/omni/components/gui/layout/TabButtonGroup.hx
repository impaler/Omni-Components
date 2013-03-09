package omni.components.gui.layout;

import omni.utils.OStates;
import omni.components.core.OLayout;
import omni.components.core.OToggleButtonGroup;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IStyle;
import omni.components.gui.layout.ContainerPage;
import omni.components.gui.controls.TabButton;
import omni.components.core.OToggleButtonGroup.OToggleButtonGroupStyle;
import omni.components.core.OLayout.OLayoutStyle;
import omni.components.core.signals.OSignalType;
import omni.components.core.OToggleButton;
import omni.components.core.OComponent;
import omni.components.style.base.OBaseBackgroundStyle;

class TabButtonGroup extends OToggleButtonGroup
{

//***********************************************************
//                  Public Variables
//***********************************************************

	public var onTabButtonChange:OSignalType<TabButton -> Void>;

//***********************************************************
//                  Component Overrides
//***********************************************************

	override public function createMembers( ):Void
	{
		//super.createMembers( );

		var thisStyle = cast(_style, TabButtonGroupStyle);
		
		layout = new OLayout(thisStyle.layoutStyle);
		layout.direction = thisStyle.defaultDirection;

		this.sprite.addChild( layout.sprite );

		onChange = new OSignalType<OToggleButtonGroup -> Void>();
		onButtonChange = new OSignalType<OToggleButton -> Void>();
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

	//todo mouse wheel change

	public function addTabButton( page:ContainerPage, style:IStyle = null ):TabButton
	{
		var button = new TabButton(style);
		button.containerPage = page;
		button.onChange.add( handleButtonChange );
		this.members.push( button );
		layout.add( button );

		return button;
	}

	public function setActiveTabButton( button:TabButton ):Void
	{
		_target = button;
		button.value = true;
		//button.set_Value( true );
		update( );
	}

//***********************************************************
//                  Properties
//***********************************************************

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
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
		defaultDirection = OStates.HORIZONTAL;
		styleID = styleString;
	}

	override public function initStyle( value:IOComponent ):Void
	{
		var styleAs = cast (value, OToggleButtonGroup);

		styleAs.direction = defaultDirection;

		super.initStyle( value );
	}

	override public function update(value:IOComponent):Void
	{
		super.update(value);
		var comp = cast (value, TabButtonGroup);
		comp.layout.invalidate();
		
	}

}