package omni.components.core;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IDestroyable;
import omni.components.core.interfaces.IStyle;
import omni.components.gui.layout.HBox;
import omni.components.gui.layout.VBox;
import omni.components.gui.text.Label;
import omni.components.core.OLayout;
import omni.components.core.signals.OSignalMouse;
import omni.components.gui.controls.NumericStepper;
import omni.components.gui.controls.Slider;
import omni.components.core.OButtonBase;
import omni.components.core.OCore;

/**
* OScreen
* 
* Helper utility to easily create components to layouts
* 
**/
class OScreen implements IDestroyable
{
	public var components:Array<IOComponent>;

	public var activeLayout:OLayout;

//***********************************************************
//                  Core
//***********************************************************

	public function addCompClass( comp:Class<IOComponent>, ?style:IStyle ):IOComponent
	{
		var component = Type.createInstance( comp, [style] );
		components.push( component );
		return component;
	}

	public function destroy( )
	{
		for( o in components )
		{
			o.destroy( );
		}
	}

	public function new( )
	{
		components = [];
	}

//***********************************************************
//                  Layouts
//***********************************************************

	public function addHBox( ):HBox
	{
		var component = addCompClass( HBox );
		var hBox = cast (component, HBox);
		activeLayout = hBox;
		OCore.addChild( hBox );
		return hBox;
	}

	public function addVBox( ):VBox
	{
		var component = addCompClass( VBox );
		var vBox = cast (component, VBox);
		activeLayout = vBox;
		OCore.addChild( vBox );
		return vBox;
	}

	public function addToLayout( comp:IOComponent ):Void
	{
		if( activeLayout == null )
		{
			OCore.addChild( comp );
		}
		else
		{
			activeLayout.add( comp );
		}
	}

//***********************************************************
//                  Components
//***********************************************************

	public function addLabel( text:String, ?style:IStyle ):Label
	{
		var component = addCompClass( Label, style );
		addToLayout( component );
		component.drawNow( );

		var label = cast (component, Label);
		label.text = text;

		return label;
	}

	public function addOButtonBase( ?clickHandler:Dynamic, ?args:Array<Dynamic>, ?style:IStyle ):OButtonBase
	{
		var component = addCompClass( OButtonBase, style );
		addToLayout( component );
		component.drawNow( );
		var button = cast (component, OButtonBase);

		if( clickHandler != null )
		{
			if( args == null ) args = [];

			button.onClick.add(
				function( e:OButtonBase )
				{
					Reflect.callMethod( e, clickHandler, args );
				}
			);
		}

		return button;
	}

	public function addSlider( ?style:IStyle ):Slider
	{
		var component = addCompClass( Slider, style );
		addToLayout( component );
		return cast (component, Slider);
	}

	public function addNumericStepper( ?style:IStyle ):NumericStepper
	{
		var component = addCompClass( NumericStepper, style );
		addToLayout( component );
		return cast (component, NumericStepper);
	}

}
