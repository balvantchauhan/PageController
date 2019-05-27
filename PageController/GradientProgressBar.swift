//
//  WizardPageViewController.swift
//  PageController
//
//  Created by Balvant Singh Chauhan on 20/05/19.
//  Copyright © 2019 Balvant Singh Chauhan. All rights reserved.

import UIKit

public class GradientProgressBar : UIProgressView {
    
    // MARK: - Properties
    
    /// An array of CGColorRef objects defining the color of each gradient stop. Animatable.
    public var gradientColors: [CGColor] = [UIColor.blue.cgColor,UIColor.blue.cgColor] {
        didSet {
            gradientLayer.colors = gradientColors
        }
    }

    
    /** The radius to use when drawing rounded corners for the gradient layer and progress view backgrounds. Animatable.
    *   The default value of this property is 0.0.
    */
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }
    
    public override var trackTintColor: UIColor? {
        didSet {
            if trackTintColor != UIColor.clear {
                backgroundColor = trackTintColor
                trackTintColor = UIColor.clear
            }
        }
    }
    
    public override var progressTintColor: UIColor? {
        didSet {
            if progressTintColor != UIColor.clear {
                progressTintColor = UIColor.clear
            }
        }
    }
    
    lazy private var gradientLayer: CAGradientLayer = self.initGradientLayer()

    // MARK: - init methods
    
    override public init (frame : CGRect) {
        super.init(frame : frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Layout
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateGradientLayer()
    }
    override public func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)
        updateGradientLayer()
    }
    
    // MARK: - Private methods
    
    private func setup() {
        self.layer.cornerRadius = cornerRadius
        self.layer.addSublayer(gradientLayer)
        progressTintColor = UIColor.clear
        gradientLayer.colors = gradientColors
    }
    
    private func initGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = sizeByPercentage(originalRect: bounds, width: CGFloat(progress))
        gradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
        gradientLayer.position = CGPoint(x: 0, y: 0)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.masksToBounds = true
        return gradientLayer
    }
    private func updateGradientLayer() {
        gradientLayer.frame = sizeByPercentage(originalRect: bounds, width: CGFloat(progress))
        gradientLayer.cornerRadius = cornerRadius
    }
    private func sizeByPercentage(originalRect: CGRect, width: CGFloat) -> CGRect {
        let newSize = CGSize(width: originalRect.width * width, height: originalRect.height)
        return CGRect(origin: originalRect.origin, size: newSize)
    }
}
