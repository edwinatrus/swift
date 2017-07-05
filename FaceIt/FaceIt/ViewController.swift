//
//  ViewController.swift
//  FaceIt
//
//  Created by Chen Xiaojun on 3/7/17.
//  Copyright © 2017 Lindenbaum Pty Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            let pinchRecognizer = UIPinchGestureRecognizer(
                target: faceView, action: #selector(FaceView.changeScale(recognizer:))
            )
            
            let happierRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(ViewController.mouthHapper)
            )
            happierRecognizer.direction = .up
            
            let sadderRecognizer = UISwipeGestureRecognizer(
                target: self, action: #selector(ViewController.mouthSadder)
            )
            sadderRecognizer.direction = .down
            
            faceView.addGestureRecognizer(pinchRecognizer)
            faceView.addGestureRecognizer(happierRecognizer)
            faceView.addGestureRecognizer(sadderRecognizer)
            
            updateUI()    // faceView might points to the view (upon setting) later than initialization
            
        }
    }
    
    @IBAction func toggleEyes(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended && sender.numberOfTapsRequired == 1 {
            switch expression.eyes {
            case .open: expression.eyes = .closed
            case .closed: expression.eyes = .open
            default: break
            }
        }
    }
    
    var expression = FacialExpression(eyes: .open, mouth: .grin) {
        didSet {
            updateUI()    // didSet does not trigger upon initialization
        }
    }
    
    func mouthHapper() {
        expression.mouth = expression.mouth.happier
    }
    
    func mouthSadder() {
        expression.mouth = expression.mouth.sadder
    }
    
    private func updateUI() {
        switch expression.eyes {
        case .open: faceView?.eyesOpen = true    // faceView might be nil upon initialization
        case .closed: faceView?.eyesOpen = false    // faceView might be nil upon initialization
        case .squiting: faceView?.eyesOpen = false    // faceView might be nil upon initialization
        }
        
        faceView?.mouthCurvature = mouthCurvature[expression.mouth] ?? 0.0    // faceView might be nil upon initialization
    }
    
    private let mouthCurvature = [
        FacialExpression.Mouth.grin: 0.5,
        FacialExpression.Mouth.frown: -1.0,
        FacialExpression.Mouth.smile: 1.0,
        FacialExpression.Mouth.neutral: 0.0,
        FacialExpression.Mouth.smirk: -0.5
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

