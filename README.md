# OSKStatusBarViewController
Custom your statusBar color without private method.(joke OSS)

![](https://raw.githubusercontent.com/noppefoxwolf/OSKStatusBarViewController/master/capture.png)

##INSTALLATION

First you have to import in header file of your view controller:

```#import "OSKStatusBarViewController.h"```

Then your view controller replace superclass to OSKStatusBarViewController:

```@interface ViewController : OSKStatusBarViewController```

##Usage🐰

change color.
`self.statusBarColor = [UIColor redColor];`

refresh statusbar.
`[self refreshStatusBar];`

##Why should you call refreshStatuBar?

Actually,OSKStatusBarViewController does not change statusBar Color.
That capture statusbar image and tint This.
so,need refresh.

##Bad point
Statusbar become strange display for a while In refresh.

##Good point
Dose not use private method.

##LICENSE
The MIT License (MIT). Copyright (c) 2015 noppefoxwolf.
