#Warning: Obsolete!

With the new OS X Yosemite APIs launched at WWDC 2014 this class has become obsolete, you can still use It to support older versions of the OS but I recommend using Apple's standard APIs from now on.

#GRNavigationController

Simple navigation controller, provides navigation to a stack of view controllers.

![screenshot](https://raw.github.com/insidegui/GRNavigationController/master/navigation_demo.gif)

##Usage

Note: your view controllers must subclass GRViewController

###Setup

I recommend setting everything up in IB.

Here's what you must hook up:


1. **view**

	The view where the navigation controller will put it's contents

2. **rootViewController**

	The view controller added to the stack immediately after the navigation controller awakes, it's the first view controller

3. **backButton**

	An outlet to the button to use as the "back" button, this can be any subclass of NSControl (preferably NSButton or NSSegmentedControl).

###Pushing a view controller

	// inside a subclass of GRViewController
	[self.navigationController pushViewController:self.myOtherVC animated:YES]

###Popping the front view controller


	// inside a subclass of GRViewController
	[self.navigationController popViewControllerAnimated:YES]

##GRViewController

GRViewController is an abstract class, subclassed from NSViewController, which can be used inside GRNavigationControllers.

You use It just like a regular NSViewController but there are some additional methods you can override to control it's behavior on the navigation stack.

###Using a custom rewind transition

If you want your view controller to be popped using a specific transition, you can set It's rewindTransition property to a custom CATransition.

	// inside a subclass of GRViewController

	// create and set the custom transition
	CATransition *rewind = [CATransition animation];
	rewind.type = kCATransitionFade;
	self.rewindTransition = rewind;

	// pop
	[self.navigationController popViewControllerAnimated:YES];

###Subclassing

There are 5 methods you can override to work with the navigation:

1. **viewDidLoad**

	Sent right after awakeFromNib

2. **viewWillAppear**

	Sent when the view is about to appear

3. **viewDidAppear**

	Sent when the view has just appeared

4. **viewWillDisappear**

	Sent when the view is about to disappear

5. **viewDidDisappear**

	Sent when the view has just disappeared

**Note:**
_viewWillAppear_ and _viewWillDisappear_ occur inside a CATransaction, therefore any animations will be grouped with the navigation animation.

##Sample App: Countries

See the included sample app "Countries" for a complete example of how to use the navigation controller.

##Caveat

The superview of the navigation controller's view must be layer backed, which means anything inside the navigation must work in layer backed mode.

##Contributing

You can contribute with code, just send me a pull request, or open an issue for any bug/enhancement.

Disclaimer: sending a pull request does not mean I will accept It, if I don't accept your pull request It doesn't mean I don't love you ;)