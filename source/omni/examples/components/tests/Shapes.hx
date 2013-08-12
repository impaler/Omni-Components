package omni.examples.components.tests;

import flash.display.Sprite;
import omni.utils.UtilShapes;
import flash.display.Shape;

class Shapes extends Sprite
{
    public function new()
    {
        super();

        var s:Shape = new Shape( ); // Or Sprite of MovieClip or any other Class that makes use of the Graphics class

        // Draw an ARC
        s.graphics.lineStyle(4, 0xE16606);
        UtilShapes.drawArc(s.graphics, 50, 50, 10, 150, 60);

        // Draw an BURST
        s.graphics.lineStyle(3, 0x000000);
        UtilShapes.drawBurst(s.graphics, 80, 60, 3, 15, 6, 27);

        // Draw an DASHED-LINE like so - - - -
        s.graphics.lineStyle(1, 0x3C3C39);
        UtilShapes.drawDash(s.graphics, 120, 60, 150, 80, 2, 2);

        // Draw an GEAR
        s.graphics.lineStyle(3, 0xE16606);
        UtilShapes.drawGear(s.graphics, 200, 60, 13, 31, 26, 0, 7, 13);

        // Draw a POLYGON
        s.graphics.lineStyle(3, 0x0074B9);
        UtilShapes.drawPolygon(s.graphics, 270, 60, 7, 30, 45);

        // Draw a STAR
        s.graphics.lineStyle(2, 0x000000);
        UtilShapes.drawStar(s.graphics, 340, 60, 18, 24, 19, 27);

        // Draw an WEDGE - good for pie charts or pacmans
        s.graphics.lineStyle(2, 0xFFCC00);
        UtilShapes.drawWedge(s.graphics, 400, 60, 30, 309, 209);

        // Draw a LINE
        s.graphics.lineStyle(2, 0x0074B9);
        UtilShapes.drawLine(s.graphics, 440, 85, 30, UtilShapes.VERTICAL_LINE);

        addChild(s);
    }
}
