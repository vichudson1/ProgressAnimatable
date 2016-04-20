//
//  SwiftTimer.swift
//
//  Created by Victor Hudson on 4/14/16.
//  Copyright © 2016 Victor Hudson. All rights reserved.
//

import Foundation

/// A simple Swift wrapper for NSTimer. Use it just as you would NSTimer with the exectpion that your provide a closure to perform when the timer fires instead of a method selector. This copy of SwiftTimer bundled with the sample project for convienience, you should grab the most current copy for use in your projects from [SwiftTimer](https://github.com/vichudson1/SwiftTimer).
public class SwiftTimer: NSObject {
	/**
	Use this `init` to update your views progress.
	- parameter timeInterval: The delay interval between firing events of the timer.
	- parameter userInfo: A dictionary you can pass along with the timer for use during firing events.
	- parameter repeats: Determines whether the repeats or fires a single time.
	- parameter timerAction: A closure that will be executed each firing of the timer. The closure has a parameter which passes in the instance of the timer executing it.
	*/
	init(timeInterval: NSTimeInterval, userInfo: [String: AnyObject]?, repeats: Bool, timerAction: (_: SwiftTimer) -> Void){
		super.init()
		self.timerAction = timerAction
		self.timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval,
		                                                    target: self,
		                                                    selector: #selector(self.theSelector(_:)),
		                                                    userInfo: userInfo,
		                                                    repeats: repeats)
	}
	
	/// Use this method to start your timer after creating an instance.
	func fire() {
		self.timer?.fire()
		running = true
	}
	
	/// Use this method to cancel your timer when you are done with it.
	func invalidate() {
		self.timer?.invalidate()
		self.timer = nil
		running = false
	}
	
	/// User Info Dictionary For information you'd like assigned to this timer.
	var userInfo: [String: AnyObject]?
	
	/// Check to see if the timer is running or not.
	var running = false
	
	private var timer: NSTimer?
	private var timerAction: ((_: SwiftTimer) -> Void)?
}

private extension SwiftTimer {
	@objc func theSelector(timer: NSTimer) {
		guard let action = self.timerAction else { return }
		action(self)
	}
}
