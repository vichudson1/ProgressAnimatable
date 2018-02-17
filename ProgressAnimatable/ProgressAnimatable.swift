//
//  ProgressAnimatable.swift
//
//  Created by Victor Hudson on 4/10/16.
//  Copyright © 2016 Victor Hudson. All rights reserved.
//

import UIKit

/// Protocol with default implemtation methods for animating changes to view representing progress of something.
public protocol ProgressAnimatable: class {
	/// The Conforming views progress variable. Expected values are `0...1.0`, should be initialized at `0.0` or a sensible default for your use.
	var progress: Double { get set }
	
	/// The variable the default implementation methods use to update progress to. Initialize at `0.0`.
	var targetValue: Double { get set }
	
	/// The variable the default implentation methods use to determine if progress will be going up or down. Initialize to `false` the default methods will update it when needed.
	var reverse: Bool { get set }
	
	/// The Timer instance used by the default methods to drive the animation. You can just declare it as an optional with no initial value. The protocol methods control its creation when needed.
	var timer: Timer? { get set }
	
	/// Optional variable can be defined to set the animation duration. You can override as needed, a default of 3 seconds is used if you omit this.
	var animationDuration: Double { get }
	
	/**
	Use this method to update your views progress. A default implementation is provided, so you only need to implement this if you want to override the default.
	- parameter progress: The new progress value for your view.
	- parameter animated: Determines whether the progress change should be animated. Defaults to true.
	*/
	func set(progress: Double, animated: Bool)
}


/// Extension contains the default method implementation for `set(progress progress: Double, animated: Bool)`.
public extension ProgressAnimatable where Self: UIView  {
	
	func set(progress: Double, animated: Bool = true) {
		guard animated else {
			self.progress = progress
			setNeedsDisplay()
			return
		}
		
		targetValue = progress
		checkReverse()
		if timer == nil {
			timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { [weak self] (timer) in
				self?.updateProgress()
			}
			timer?.fire()
		}
	}
}

/// The supporting methods and variables for protocols default implementation.
private extension ProgressAnimatable where Self: UIView {
	
	var timerInterval: Double { return 0.02 }
	var animationDuration: Double { return 3.0 }
	
	func updateProgress() {
		if ((!reverse && progress < targetValue)
			|| (reverse && progress > targetValue && progress + progressInterval > 0)) {
			progress += progressInterval
		} else {
			timer?.invalidate()
			timer = nil
			progress = targetValue
		}
		setNeedsDisplay()
	}
	
	var progressInterval: Double {
		let interval = (timerInterval / animationDuration)
		var multiplier = 1.0
		if reverse { multiplier = -1 }
		return interval * multiplier
	}
	
	func checkReverse() {
		if targetValue < progress {
			reverse = true
		} else {
			reverse = false
		}
	}
}
