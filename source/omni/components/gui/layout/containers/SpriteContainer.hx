package omni.components.gui.layout.containers;

import flash.display.Sprite;
import omni.utils.signals.OSignalEvent;
import flash.display.Sprite;
import omni.components.style.base.OBaseStyle;
import omni.components.core.OComponent;
import flash.events.Event;

class SpriteContainer extends OComponent
{

    //***********************************************************
    //                  Style Variables
    //***********************************************************

    public var contentSprite:Sprite;

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createMembers():Void
    {
        super.createMembers();

        if (styleAsSprite.sprite != null)
            setSprite(styleAsSprite.sprite);
    }

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    public function setSprite(newSprite:Sprite):Void
    {
        destroyExistingSprite();

        contentSprite = null;
        contentSprite = newSprite;
        contentSprite.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        addContentSprite();
    }

    public function addContentSprite():Void
    {
        sprite.addChild(contentSprite);
        _size(contentSprite.width, contentSprite.height);
        invalidate();
    }

    public function destroyExistingSprite():Void
    {
        if (contentSprite != null)
        {
            var saveParent = contentSprite.parent;
            if (saveParent != null)
            {
                saveParent.removeChild(contentSprite);
            }
            contentSprite = null;
        }
    }

    //***********************************************************
    //                  Properties
    //***********************************************************

    override public function get_height():Float
    {
        if (contentSprite != null)
        {
            return contentSprite.height;
        }
        else
        {
            return 0;
        }
    }

    override public function get_width():Float
    {
        if (contentSprite != null)
        {
            return contentSprite.width;
        }
        else
        {
            return 0;
        }
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    public var styleAsSprite(get_styleAsSprite, null):SpriteContainerStyle;

    public function get_styleAsSprite():SpriteContainerStyle
    {
        return cast(_style, SpriteContainerStyle);
    }

    override public function get_styleId():String
    {
        return SpriteContainerStyle.styleString;
    }
}

class SpriteContainerStyle extends OBaseStyle
{
    public static var styleString:String = "SpriteContainerStyle";

    public var sprite:Sprite;

    public function new()
    {
        super();
        styleID = styleString;
    }
}