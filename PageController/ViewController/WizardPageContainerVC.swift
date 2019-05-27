//
//  WizardPageContainerVC.swift
//  PageController
//
//  Created by Balvant Singh Chauhan on 20/05/19.
//  Copyright © 2019 Balvant Singh Chauhan. All rights reserved.

import UIKit

class WizardPageContainerVC: UIViewController {
    @IBOutlet weak var wizardControllsView: WizardNavControls!
    var pageCount:Int = 0
    var pageViewController:PageViewController?
    
    
    //*******************************************************
    // MARK: -  Life cycle method
    // MARK: -
    //*******************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        wizardControllsView.wizardDelegate  =   self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageVC = segue.destination as? PageViewController {
            pageViewController  =   pageVC
            pageVC.pageDelegate = self
        }
    }
}
//*******************************************************
// MARK: -  ClassExtension
// MARK: -
//*******************************************************
extension WizardPageContainerVC: PageViewControllerDelegate {
    func pageViewController(pageViewController: PageViewController, didUpdatePageCount count: Int) {
        if count > 1{
            wizardControllsView.progressNextButton.isHidden =   false
        }else{
            wizardControllsView.progressNextButton.isHidden =   true
        }
        pageCount   =   count        
    }
    func pageViewController(pageViewController: PageViewController, didUpdatePageIndex index: Int) {
        wizardControllsView.wizardState(index: index, totalPage: pageCount)
    }
}

extension WizardPageContainerVC : WizardControlsDelegate{
    func nextWizard() {
        if let pageController = pageViewController{
            pageController.movePageForword()
        }
    }
    func perviousWizard() {
        if let pageController = pageViewController{
            pageController.movePageBackword()
        }
    }
    func skipWizard() {
        
    }
    
    func compliteWizard() {
        
    }
}
