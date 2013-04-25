Omni Components
=============

The code here is a WIP


A multi-platform ui haxe nme framework with a focus on creating easy themes and styles.
Omni Components uses simple haxe classes to for creating themes and guis programatically.

Themes can make use of inheritance and be created dynamically more easily. See the BaseTheme.hx Class for the theme custom ones can extend or replace.

------------

- Code is loosely based where we left [Bloom] (https://github.com/impaler/As3-Bloom)
- Cross platform Scale 9 Slices done with help from code in https://github.com/RealyUniqueName/StablexUI

Web
Desktop
Mobile

[NME] (http://www.nme.io/)





------------

Known limitations

Html5 target's scrollRect bounds check implementation is currently limited NME. Its also limited to browser 
inconsistencies in each canvas api implementation. Mousewheel is not yet working in firefox.

Bitmap repeat fill is limited with gpu rendering cacheasbitmap.
