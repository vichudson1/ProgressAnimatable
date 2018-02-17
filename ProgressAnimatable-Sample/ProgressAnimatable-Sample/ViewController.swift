//
//  ViewController.swift
//  ProgressAnimatable-Sample
//
//  Created by Victor Hudson on 4/15/16.
//  Copyright © 2016 Victor Hudson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBOutlet var animatedSwitch: UISwitch!
	@IBOutlet var progressLabel: UILabel!
	@IBOutlet var progressView: SampleProgressView!

	@IBAction func stepperChanged(_ sender: UIStepper) {
		self.progressView.set(progress: sender.value * 0.01,
							  animated: animatedSwitch.isOn)
		
		self.progressLabel.text = "\(Int(sender.value))%"
	}
}

