### This codebase is no longer in development, there are some layout limitations and improvements that are required I dont have time for.

#### Good news however Ian's work with https://github.com/ianharrigan/haxeui has a very similar strucutre to OmniComponents and it has got many of the improvements working I had in mind for OmniComponents. Check it out!




OmniComponents
=============

WIP, the API and base classes are subject to change.

OmniComponents is all about rapid code driven interfaces that are highly customizable and easily themed.

This is all you need to get started with OmniComponents:

```
OCore.instance.init(YourTheme);
var button = new Button();
button.text = "Hello World";
OCore.addChild(button);
```

The Style system of OmniComponents is a strength where code only ui's are intuitive and flexible:
Using strictly typed classes for style lets you learn and use them more easily.
Full autocompletion and class inheritance for your custom styles are at your disposal.

------------

- Code is loosely based where we left [Bloom] (https://github.com/impaler/As3-Bloom)

------------

Known limitations

- Bitmap repeat fill is limited on C++ targets.
- Html5 Mouse Wheel and Bounds checking with OpenFL is limited.
