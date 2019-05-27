//
//  PageControlls.swift
//  PageController
//
//  Created by Balvant Singh Chauhan on 20/05/19.
//  Copyright © 2019 Balvant Singh Chauhan. All rights reserved.

import UIKit
enum WizardState {
    case start,mid,end
}
protocol WizardControlsDelegate:class{
    func nextWizard()
    func perviousWizard()
    func skipWizard()
    func compliteWizard()
}
extension UIButton{
    func makeCircle() {
        self.layer.cornerRadius =   15.5
    }
}
class PageControlls: UIView {

    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressPerviousButtion: UIButton!
    @IBOutlet weak var progressNextButton: UIButton!
    @IBOutlet weak var progressControlls: GradientProgressBar!
    
    weak var wizardDelegate:WizardControlsDelegate?
    var contentView: UIView!
    func xibSetup() {
        contentView = loadViewFromNib()
        // use bounds not frame or it'll be offset
        contentView.frame = bounds
        // Make the view stretch with containing view
        self.setupUI()
        addSubview(contentView)
    }
    func setupUI(){
        setInitialControlls()
    }
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PageControlls", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    //*******************************************************
    // MARK: -  PrivateMethods
    // MARK: -
    //*******************************************************
    func setInitialControlls() {
        initialSetup()
    }
    func initialSetup() {
        progressNextButton.makeCircle()
        progressPerviousButtion.makeCircle()
        progressPerviousButtion.isHidden =   true
    }
    //*******************************************************
    // MARK: -  PublicMethods
    // MARK: -
    //*******************************************************
    func wizardState(index:Int,totalPage:Int) {
        let progress = Float(index) / Float(totalPage - 1)
        progressControlls.progress  =   progress
        progressNextButton.isHidden =   false
        progressPerviousButtion.isHidden =   false
        if index    ==  0{
            progressPerviousButtion.isHidden    =   true
        }else if index ==   totalPage - 1{
            progressNextButton.isHidden =   true
        }
    }
    //*******************************************************
    // MARK: -  ActionMethods
    // MARK: -
    //*******************************************************
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if let delegate = self.wizardDelegate {
            delegate.nextWizard()
        }
    }
    @IBAction func perviousButtonTapped(_ sender: UIButton) {
        if let delegate = self.wizardDelegate {
            delegate.perviousWizard()
        }
    }
}
