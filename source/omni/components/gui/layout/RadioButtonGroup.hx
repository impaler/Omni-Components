package omni.components.gui.layout;

import omni.components.core.interfaces.IStyle;
import omni.components.gui.layout.Layout.LayoutStyle;
import omni.components.gui.controls.RadioButton;
import omni.components.core.signals.OSignalType;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OToggleButton;
import omni.components.core.OComponent;
import omni.components.style.OBackgroundStyle;

class RadioButtonGroup extends OComponent
{
	private var _target:OToggleButton;
	public var layout:Layout;

	public var direction:Int;

	public var onChange:OSignalType<RadioButtonGroup -> Void>;
	public var onButtonChange:OSignalType<RadioButton -> Void>;

//***********************************************************
//                  Component Core
//***********************************************************

	override public function createMembers( ):Void
	{
		layout = new Layout();
//todo style layer
//		_direction = Layout.VERTICALLY;
		layout.direction = direction;

		this.sprite.addChild( layout.sprite );

		onChange = new OSignalType<RadioButtonGroup -> Void>();
		onButtonChange = new OSignalType<RadioButton -> Void>();
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
		onButtonChange.dispatch( cast(button, RadioButton) );
	}

//***********************************************************
//                  Event Handlers
//***********************************************************

	public function addButton( style:IStyle = null ):RadioButton
	{
		var button = new RadioButton(style);
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

	override public function getHeight( ):Float
	{
		return layout.getHeight( );
	}

	override public function getWidth( ):Float
	{
		return layout.getWidth( );
	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function getStyleId( ):String
	{
		return RadioButtonGroupStyle.styleString;
	}
}

class RadioButtonGroupStyle extends OBackgroundStyle
{
	public static var styleString:String = "RadioButtonGroupStyle";

	public var defaultDirection:Int;

	public function new( )
	{
		super( );
		defaultDirection = Layout.VERTICALLY;
		styleID = styleString;
	}

	override public function initStyle( value:IOComponent ):Void
	{
		var styleAs = cast (value, RadioButtonGroup);

		styleAs.direction = defaultDirection;

		super.initStyle( value );
	}
}