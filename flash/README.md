# DockMenu Flash version
This folder contains the source files required to generate the Flash extension
`JKDockMenu.mxp`, as well as the generated `mxp` file. This Flash extension is for those
of you which still develop completely in the Flash Professional software and prefer
writing as few lines of code as possible.

### Dependencies
The Extension Manager to generate and install `mxp` files, and Adobe Animate (previously Flash).

### Introduction
The `DockMenu` component is a menu bar based on the Mac OS X dock. This versions of the `DockMenu` was
created mainly for people with minimum or null ActionScript knowledge. Thus you can configure most of
the main aspects of the component by just setting the component parameters.

### Installing
This component was packed using the Extension Manager that comes bundled with Adobe products.
This component supports all Flash versions up until Animate CC.

1. To install simply double click the JKDockMenu.mxp file.
1. Once installation is complete, open Flash.
1. Create a new ActionScript 3.0 FLA file.
1. Open the Components panel using Window > Components.
1. You should find a JK Components folder and the DockMenu component inside.
1. If the folder doesn't appear try clicking in the Component's panel Options button and select 
   Reload Components.
1. For older versions of Flash (CS4 and older) the component installs an older code completion 
   system automatically so you don't need to do anything else.
1. Optionally, to get the benefits of code completion in Flash CS5, do one of the following:
  * Copy everything from the src folder into the folder where you saved your FLA file. This will not only 
    activate code completion but also allows you to customize the code to fit your needs.
  * If you want code completion but don't want to see the code just copy the DockMenu.swc file from 
    the bin folder into the folder where you saved your FLA file.
  * If you don't want to copy neither the code nor the SWC file to keep it clean you can add it to 
    your source path or library path.
    1. Select File > Publish Settings... to open the publish settings dialog.
    1. Go to the Flash tab and press the Settings... button near the Script combo box.
    1. Here you can add the path to the code (Source path) or to the SWC file (Library path).

### Creating icons
To create a `DockMenu` you must first create your icons.

1. Create a movie clip (`DisplayObjectContainer`) or choose one from the library. 
   You don't need to worry about neither the register point position nor the size/aspect ratio of the icon;
   they are automatically managed by the `DockMenu` component.
1. Right click the symbol in the Library panel and select Properties.
1. In the Properties Dialog select the Advanced button if not already selected.
1. Select the Export for ActionScript option.
1. Enter a name in the Class textbox, finally press OK.
1. Repeat the same process for each icon.
1. If you know a little bit of code you can create a class for your icon to make it dynamic and even create the 
   icon entirely using code.

### Creating the DockMenu
To create the `DockMenu` simply drag it to the Stage from the Components panel. 
The `DockMenu` can be placed in the main timeline or inside a movie clip (`DisplayObjectContainer`):

* When placed in the main timeline the menu bar is automatically docked and centered to the desired side of the screen. 
  In "fluid" applications that will resize with the player/browser window, set `stage.align` to `StageAlign.TOP_LEFT` for 
  the `DockMenu` to work correctly.
* When placed inside a movie clip (`DisplayObjectContainer`) the menu is automatically docked and centered to the
  bounding box of the container. This way you can create a movie clip with a transparent square shape and drag the 
  `DockMenu` inside. To move the `DockMenu` anywhere, just move the container clip.

Once `DockMenu` is created the bar will automatically be docked to the side of the container specified 
by the position parameter on the Properties panel Parameters tab (Component Inspector for Flash CS3 only)
or the `DockMenu.position` property, so don't worry about positioning it.

#### Setting the `DockMenu` parameters
Once you dragged the component to the Stage:

1. Make sure the component is selected.
1. Open the Properties panel Parameters tab (Component Inspector for Flash CS3 only).
1. Set the following properties:
  1. **position:** is the position of the screen or container where you want the `DockMenu` to be docked.
  1. **minIconSize:** This is the size the icons will have when the `DockMenu` is created.
  1. **maxIconSize:** This is the size the icons will have when you roll over the `DockMenu` component.
  1. **autoHide:** Set this property to `true` if you which the `DockMenu` to hide if it is not in use. If 
     `false` it will always be visible.
  1. **showReflection:** Set this property to true if you want to show a reflection for the icons. If this 
     parameter is `true` then you can also set the reflectionAlpha and reflectionSize properties to control 
	 how the reflection looks.
  1. **cacheIcons:** If you want to target slower machines you can set this property to true
	   to improve performance.
1. Double click the `dataProvider` property. A dialog opens to allow you adding icons for the `DockMenu`.
1. Press the + button to add an icon or - to remove it.
1. Enter the following data for each bar item:
  1. **caption:** (optional) is the label that will appear near the icon. You can omit this value if you don't want any label.
  1. **icon:** (mandatory) is the Class name of a movie clip (DisplayObject) in the library that will be used
     as the icon image (for information on creating you icons see [Creating icons](#creating-icons)). 
     The icon can be also set to a `DisplayObject` instance using ActionScript code.
  1. **link:** (optional) specifies the action to be performed when a button is clicked. 
     What the menu will do depends on this value and the target property also. If no link is specified no 
     action will be executed but you can still listen to the `click` event programmatically.
  1. **target:** (optional) is the object that will perform the action specified by link:
    * If the link property contains a file name with the .swf, .gif, .jpg or .png extension then the target
      must be set to the path of the movie clip (relative to the `DockMenu`'s parent timeline or absolute), to be used 
      as the loader clip. If the target is a `Loader` object then it will be set to load the link immediately (you can listen to
      the `Loader` events yourself). If the target is a `DisplayObjectContainer` (`MovieClip`, `Sprite`, etc) then `DockMenu` 
	  creates a Loader object inside and begins the loading process. `DockMenu` creates only one `Loader` object per container.
    * If the link property contains a file name using any other extension (like .html, .pdf, etc...) or if it is a web
      site URL then the target must be set to the HTML target window (_self, _blank, _parent, _top 
      or any other HTML frame name).
    * If the link property doesn't contain the (.) or (/) characters then it is considered a frame label or number. 
      The target must be set to the path of the movie clip (relative to the `DockMenu`'s parent timeline or absolute), to go to
      and stop to the specified frame. Write a plus sign (+) at the end of the frame number or label in the link property to go to 
      and play to that frame instead of stopping.
  1. **linkType:** (optional) is the link type that allows changing how the link and target data are interpreted 
     by `DockMenu`. Normally you would not change this property but sometimes this property allows `DockMenu` to 
     choose the right behavior when in doubt.
    * If linkType is set to "auto" then the link and target are interpreted automatically as described before in the `target` property.
    * If linkType is "swf" then it will force the link and target to be interpreted as loading an SWF, JPEG, GIF or PNG 
      file into a target movie. Use this option when you need to load an SWF, JPEG, GIF or PNG files but the component 
      is misunderstanding this. This can happen when the link is a .php, .apsx, .jsp, .cfm, etc... page that returns a 
      SWF, JPEG, GIF or PNG as its response instead of a web page.
    * If linkType is "webpage" it will force the link and target to be interpreted as navigating to an HTML page. 
      Use this option when you mean to navigate to an URL but the component is misunderstanding this. This can happen if the 
      link you use doesn't contain any / or . characters (relative paths mostly). You can also use this option to open the 
      image file in a popup window instead of inside a container in the SWF file.
    * If linkType is "movieclip" it will force the link and target to be interpreted as moving a movie clip timeline. 
      Use this option when you need to control the timeline of a movie clip but the component is misunderstanding this. 
      This can happen if the frame label contains a point in its name.
