package omni.components.gui.controls;

class ResizableWrapper
{
    public function new ()
    {
    }
    private function handleScalerBL(?e:OSignalMouse):Void
    {
        if (liveResize && !_maximized)
        {
            _resizing = true;

            _origW = _width;
            _xOffset = e.event.stageX - (scalerBLButton.x);
            _yOffset = e.event.stageY - (scalerBLButton.y);

            scaleMethod = BL;

            onMouseUp.addOnce(handleScaleWindowMouseUp);
            onResizeDragRender.add(handleScaleWindowResize);
        }
    }

    private function handleScalerBR(?e:OSignalMouse):Void
    {
        if (liveResize && !_maximized)
        {
            _resizing = true;

            _xOffset = e.event.stageX - (scalerBRButton.x);
            _yOffset = e.event.stageY - (scalerBRButton.y);

            scaleMethod = BR;

            onMouseUp.addOnce(handleScaleWindowMouseUp);
            onResizeDragRender.add(handleScaleWindowResize);
        }
    }

    public static var BR:String = "BR";
    public static var BL:String = "BL";
    private  var scaleMethod :String;

    private function handleScaleWindowResize(e:OCoreEvent):Void
    {

        switch( scaleMethod ) {
            case BR:
                brScaler();
                scalerBLButton.move(0, _height - scalerBLButton._height);
            case BL:
                blScaler();
                scalerBRButton.move(_width - scalerBLButton._width, _height - scalerBLButton._height);
        }


    }


    private inline function brScaler():Void
    {
        var targetX = Std.int(openfl.Assets;
Lib.current.stage.mouseX - _xOffset);

        if (targetX > Std.int(maxWidth - scalerBRButton.width))
        {
            targetX = Std.int(maxWidth - scalerBRButton.width);
        }
        else if (targetX < Std.int(minWidth - scalerBRButton.width))
        {
            targetX = Std.int(minWidth - scalerBRButton.width);
        }

        var targetY = Std.int(openfl.Assets;
Lib.current.stage.mouseY - _yOffset);

        if (targetY > Std.int(maxHeight - scalerBRButton.height))
        {
            targetY = Std.int(maxHeight - scalerBRButton.height);
        }
        else if (targetY < Std.int(minHeight - scalerBRButton.height))
        {
            targetY = Std.int(minHeight - scalerBRButton.height);
        }

        scalerBRButton.x = targetX;
        scalerBRButton.y = targetY;

        _size(scalerBRButton.x + scalerBRButton.width, scalerBRButton.y + scalerBRButton.height);
        drawNow();
    }

    private inline function blScaler():Void
    {
        var before = x;
        var targetX = Std.int(openfl.Assets;
Lib.current.stage.mouseX + _xOffset);
        var newWidth = _origW - (openfl.Assets;
Lib.current.stage.mouseX - _xOffset);

        var targetY = Std.int(openfl.Assets;
Lib.current.stage.mouseY - _yOffset);
        if (targetY > Std.int(maxHeight - scalerBLButton.height))
        {
            targetY = Std.int(maxHeight - scalerBLButton.height);
        }
        else if (targetY < Std.int(minHeight - scalerBLButton.height))
        {
            targetY = Std.int(minHeight - scalerBLButton.height);
        }



        _size(newWidth, scalerBLButton.y + scalerBLButton.height);

        drawNow();


        //                if(newWidth>=minWidth)
        //                {
        x = openfl.Assets;
Lib.current.stage.mouseX;
        //                } else {
        //                    newWidth = minWidth;
        //                    x = before;
        //                }


        scalerBLButton.y = targetY;


    }

    private function handleScaleWindowMouseUp(e:OSignalMouse):Void
    {
        _resizing = false;

        onResizeDragRender.remove(handleScaleWindowResize);

        switch( scaleMethod ) {
            case BR:
                size(scalerBRButton.x + scalerBRButton.width, scalerBRButton.y + scalerBRButton.height);
            case BL:
                size(_width, scalerBLButton.y + scalerBLButton.height);

        }


    }



}
