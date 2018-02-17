//
//  SampleProgressView.swift
//  ProgressAnimatable-Sample
//
//  Created by Victor Hudson on 4/16/16.
//  Copyright © 2016 Victor Hudson. All rights reserved.
//

import UIKit
@IBDesignable
class SampleProgressView: UIView {
	
	override func draw(_ rect: CGRect) {		
		let progressWidth = progress > 0.01 ? (CGFloat(progress) * (self.bounds.width - 12)) : 8
		let barRect = CGRect(x: 4, y: 4, width: progressWidth, height: self.bounds.height - 8)
		let barPath = UIBezierPath(roundedRect: barRect, cornerRadius: 4)
		UIColor.green.setFill()
		barPath.fill()
		UIColor.darkGray.setStroke()
		barPath.lineWidth = 1
		barPath.stroke()
    }
	
	// MARK: - ProgressAnimatable Variables -
	var progress: Double = 0.0
	var targetValue: Double = 0.0
	var reverse: Bool =  false
	var timer: Timer?
	
	// Optional Override, this normally defaults to 3 seconds.
	var animationDuration = 1.5
}

// MARK: - ProgressAnimatable Conformance Extension -
extension SampleProgressView: ProgressAnimatable {}
