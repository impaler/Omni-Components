package omni.components.core;

import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import OLayout.OLayoutStyle;
import omni.components.core.OToggleButton;
import omni.components.core.signals.OSignalType;
import omni.components.core.OToggleButton;
import omni.components.core.OComponent;
import omni.components.style.OBackgroundStyle;

class OToggleButtonGroup extends OComponent
{
	private var _target:OToggleButton;
	public var layout:OLayout;

	public var direction:Int;

	public var onChange:OSignalType<OToggleButtonGroup -> Void>;
	public var onButtonChange:OSignalType<OToggleButton -> Void>;

//***********************************************************
//                  Component Core
//***********************************************************

	override public function createMembers( ):Void
	{
		layout = new OLayout();
		var thisStyle = cast(_style, OToggleButtonGroupStyle);
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

	public function setActive( button:OToggleButton ):Void
	{
		button.set_Value( true );
		_target = button;
		update( );
	}

	public function addButton( style:IStyle = null ):OToggleButton
	{
		var button = new OToggleButton(style);
		button.onChange.add( handleButtonChange );
		this.components.push( button );
		layout.add( button );

		return button;
	}

	private function update( ):Void
	{
		for( o in components )
		{
			var comp = cast(o, OToggleButton);

			if( comp != _target )
				comp.setValue( false );
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

class OToggleButtonGroupStyle extends OBackgroundStyle
{
	public static var styleString:String = "OToggleButtonGroupStyle";

	public var defaultDirection:Int;

	public function new( )
	{
		super( );
		defaultDirection = OLayout.VERTICALLY;
		styleID = styleString;
	}

	override public function initStyle( value:IOComponent ):Void
	{
		var styleAs = cast (value, OToggleButtonGroup);

		styleAs.direction = defaultDirection;

		super.initStyle( value );
	}
}