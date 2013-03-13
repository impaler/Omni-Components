package omni.components.core;

import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.style.base.OBaseStyle;
import omni.components.core.OLayout.OLayoutStyle;
import omni.components.core.OToggleButton;
import omni.utils.signals.OSignalType;
import omni.components.core.OToggleButton;
import omni.components.core.OComponent;
import omni.components.style.base.OBaseBackgroundStyle;
import omni.utils.OStates;

class OToggleButtonGroup extends OComponent
{

//***********************************************************
//                  Public Variables
//***********************************************************

	public var layout:OLayout;

	public var onChange:OSignalType<OToggleButtonGroup -> Void>;
	public var onButtonChange:OSignalType<OToggleButton -> Void>;
	
	private var _target:OToggleButton;

//***********************************************************
//                  Style Variables
//***********************************************************

	public var direction:String;

//***********************************************************
//                  Component Overrides
//***********************************************************

	override public function createMembers( ):Void
	{
		var thisStyle = cast(_style, OToggleButtonGroupStyle);
		
		layout = new OLayout(thisStyle.layoutStyle);
		layout.direction = thisStyle.defaultDirection;

		this.sprite.addChild( layout.sprite );

		onChange = new OSignalType<OToggleButtonGroup -> Void>();
		onButtonChange = new OSignalType<OToggleButton -> Void>();
	}

	override public function destroy( ):Void
	{
		onChange.destroy( );
		onButtonChange.destroy( );
		layout.destroy( );
		_target = null;

		super.destroy( );
	}

//***********************************************************
//                  Event Handlers
//***********************************************************

	public function handleButtonChange( button:OToggleButton ):Void
	{
		if( button._value )
		{
			_target = button;
			update( );
		}

		onChange.dispatch( this );
		onButtonChange.dispatch( button );
	}

//***********************************************************
//                  Component Methods
//***********************************************************

	public function setActiveButton( button:Dynamic ):Void
	{
		button.value = true;
		_target = button;
		update( );
	}

	public function addButton( style:IStyle = null ):OToggleButton
	{
		var button = new OToggleButton(style);
		button.onChange.add( handleButtonChange );
		this.members.push( button );
		layout.add( button );

		return button;
	}

	private function update( ):Void
	{
		for( o in members )
		{
			var comp = cast(o, OToggleButton);

			if( comp != _target )
				comp.value = false;
		}
	}

//***********************************************************
//                  Properties
//***********************************************************

	override public function get_height( ):Float
	{
		return layout.get_height( );
	}

	override public function get_width( ):Float
	{
		return layout.get_width( );
	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return OToggleButtonGroupStyle.styleString;
	}
}

class OToggleButtonGroupStyle extends OBaseStyle
{
	public static var styleString:String = "OToggleButtonGroupStyle";

	public var defaultDirection:String;
	public var layoutStyle:OLayoutStyle;

	public function new( )
	{
		super( );
        styleID = styleString;
	}

	override public function initStyle( value:IOComponent ):Void
	{
		var styleAs = cast (value, OToggleButtonGroup);

		styleAs.direction = defaultDirection;

		super.initStyle( value );
	}
}