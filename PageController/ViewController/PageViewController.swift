//
//  PageViewController.swift
//  PageController
//
//  Created by Balvant Singh Chauhan on 20/05/19.
//  Copyright © 2019 Balvant Singh Chauhan. All rights reserved.

import UIKit
protocol PageViewControllerDelegate: class {
    func pageViewController(pageViewController: PageViewController, didUpdatePageCount count: Int)
    func pageViewController(pageViewController: PageViewController, didUpdatePageIndex index: Int)
}
class PageViewController: UIPageViewController {
    weak var pageDelegate: PageViewControllerDelegate?
    //*******************************************************
    // MARK: -  Life cycle method
    // MARK: -
    //*******************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource  =   self
        delegate    =   self
//        for view in view.subviews {
//            if let subView = view as? UIScrollView {
//                subView.isScrollEnabled = false
//            }
//        }
        if let firstViewController = orderedViewControllers.first as? UIViewController{
            setViewControllers([firstViewController],direction: .forward,animated: true,completion: nil)
        }
        if let delegate =   pageDelegate{
            delegate.pageViewController(pageViewController: self, didUpdatePageCount: orderedViewControllers.count)
        }
    }
    //*******************************************************
    // MARK: -  PrivaleMethods
    // MARK: -
    //*******************************************************
    private(set) lazy var orderedViewControllers: [UIViewController?] = {
        return [    self.newViewController(controllerName: "GreenViewController"),
                    self.newViewController(controllerName: "RedViewController"),
                    self.newViewController(controllerName: "BlueViewController")]
    }()
    private func newViewController(controllerName: String) -> UIViewController? {
        let viewController  =   self.storyboard?.instantiateViewController(withIdentifier: controllerName)
        return viewController
    }
    private func notifyTutorialDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.firstIndex(of: firstViewController) {
            if let delegate =   pageDelegate{
                delegate.pageViewController(pageViewController: self, didUpdatePageIndex: index)
            }
        }
    }
    //*******************************************************
    // MARK: -  PublicMethods
    // MARK: -
    //*******************************************************
    func movePageForword() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.firstIndex(of: firstViewController) {
            if orderedViewControllers.count > index + 1{
                if let firstViewController = orderedViewControllers[index + 1]{
                    setViewControllers([firstViewController], direction: .forward, animated: true) { (status) in
                        self.notifyTutorialDelegateOfNewIndex()
                    }
                }
            }
        }
    }
    func movePageBackword() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.firstIndex(of: firstViewController) {
            if let firstViewController = orderedViewControllers[index - 1]{
                setViewControllers([firstViewController], direction: .reverse, animated: true) { (status) in
                    self.notifyTutorialDelegateOfNewIndex()
                }
            }
        }
    }
}

//*******************************************************
// MARK: -  Extention
// MARK: -
//*******************************************************
extension PageViewController : UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,didFinishAnimating finished: Bool,previousViewControllers: [UIViewController],transitionCompleted completed: Bool) {
        notifyTutorialDelegateOfNewIndex()
    }
}
