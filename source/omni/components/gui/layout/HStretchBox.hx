package omni.components.gui.layout;

import omni.utils.OStates;
import omni.components.core.OLayout;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OLayout.OLayoutStyle;

class HStretchBox extends OLayout
{
	override public function draw( ):Void
	{
		var last:Float = padding;

		for( i in 0...members.length )
		{
			var current = cast (members[i], IOComponent);

			if( _direction == OStates.HORIZONTAL )
			{
				var totalWidth = _width;
				
				//var PercentWidth = percentToValue(current.pWidth, )
				
				
				//current.y = padding + current.padding;
				//current.x = last;
				//if( i == 0 )current.x += current.padding;
				//last = current.x + current.width + padding + current.padding;
			}

		}

		super.draw( );
	}
	
	
	private function percentToValue($percent:Float, $min:Float, $max:Float):Float {
		var myValue:Float;
		var difference:Float = $max - $min;
		myValue = (difference * $percent) + $min;
		return myValue;
	}
	
	
	
	
	
	override public function get_styleId( ):String
	{
		return HBoxStyle.styleString;
	}

}

class HBoxStyle extends OLayoutStyle
{
	public static var styleString:String = "HBoxStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
		defaultDirection = OStates.HORIZONTAL;
	}
}