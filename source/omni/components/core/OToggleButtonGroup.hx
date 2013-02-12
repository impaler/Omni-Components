package omni.components.core;

import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.gui.layout.Layout;
import omni.components.core.signals.OSignalType;
import omni.components.core.OToggleButton;
import omni.components.core.OComponent;
import omni.components.style.OBackgroundStyle;

class OToggleButtonGroup extends OComponent
{
	private var _target:OToggleButton;
	public var layout:Layout;

	public var direction:Int;

	public var onChange:OSignalType<OToggleButtonGroup -> Void>;
	public var onButtonChange:OSignalType<OToggleButton -> Void>;

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

	public function addButton( style:IStyle = null ):OToggleButton
	{
		var button = new OToggleButton(style);
		button.onChange.add( handleButtonChange );
		this.components.push( button );
		layout.add( button );

		return button;
	}

	public function removeButton( button:OToggleButton ):Void
	{
		if( getButton( button ) != null )
		{
			this.components.remove( button );
			layout.remove( button );
			button.destroy( );
		}
	}

	public function getButton( button:OToggleButton ):OToggleButton
	{
		for( o in components )
		{
			var comp = cast(o, OToggleButton);

			if( comp == button )
				return comp;
		}
		return null;
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

//	public function setActiveButton( button:OToggleButton ):Void
//	{
//		_target = button;
//		button.set_On();
//	}

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
		defaultDirection = Layout.VERTICALLY;
		styleID = styleString;
	}

	override public function initStyle( value:IOComponent ):Void
	{
		var styleAs = cast (value, OToggleButtonGroup);

		styleAs.direction = defaultDirection;

		super.initStyle( value );
	}
}