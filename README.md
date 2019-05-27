# PageController

Pages is the easiest way of setting up a UIPageViewController. It comes with some convenience methods like, disabling swipe, going to a specific page and navigating backwards and forwards. And best of all, you don't have to make your own custom UIViewController to keep an index, Pages handles that for you. It just works.

Usage
  private(set) lazy var orderedViewControllers: [UIViewController?] = {
        return [    self.newViewController(controllerName: "InitialViewController"),
                    self.newViewController(controllerName: "FirstViewController"),
                    self.newViewController(controllerName: "SecondViewController")]
    }()
