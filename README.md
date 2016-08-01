# DockMenu AS
This is an ActionScript SWC component that creates a fully customizable `DockMenu` bar
similar to the one used by Apple in the Mac OS X operating system.

The repository contains a FlashDevelop project that can be compiled to generate the SWC component.
This component can then be used in any Flash and AIR projects on any supported devices.

### Dependencies
The project depends on FlashDevelop v5.1.1, Apache Ant, and the Flex and AIR SDKs.

### Compiling the SWC
To compile the SWC component open the `DockMenu.as3proj` in FlashDevelop and build it.

The build process will create an SWC file with documentation included inside the package, 
and will also create a `doc` folder with an HTML version of the component API reference.

### Sample project
Inside the `sample` folder you'll find a `DockMenuSample` FlashDevelop project. This project
uses an already packed `DockMenu` SWC component to create a bar with some pre-made icons
inside. You can play with the `DockMenu` API here to get used to it.

Here you'll learn how you can add static icons coming from `fla` files (and exported as SWC), 
create your own icons programmatically or even have dynamic icons like the clock that updates
its time at regular intervals.

You can even load another SWF file with exported symbols and add them as icons too.