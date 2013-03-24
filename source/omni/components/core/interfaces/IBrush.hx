package omni.components.core.interfaces;

import nme.display.Sprite;

/**
*   IBrush
*   
*   @description the interface to draw a component visually
*
**/

interface IBrush #if haxe3 extends #else implements #end IDestroyable
{
	function update(target:IOComponent):Void;
}

