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
    
    func tapHandler(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            switch expression.eyes {
            case .open: expression.eyes = .closed
            case .closed: expression.eyes = .open
            default: break
            }
        default: break
        }
    }
    
    func doubleTapHandler(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            faceView.scale = 0.9
        default:
            break
        }
    }
    
    private func updateUI() {
        switch expression.eyes {
        case .open: faceView?.eyesOpen = true    // faceView might be nil upon initialization or segue prepare
        case .closed: faceView?.eyesOpen = false    // faceView might be nil upon initialization or segue prepare
        case .squiting: faceView?.eyesOpen = false    // faceView might be nil upon initialization or segue prepare
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
        
        let doublTapRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(ViewController.doubleTapHandler(recognizer:))
        )
        doublTapRecognizer.numberOfTapsRequired = 2
        faceView.addGestureRecognizer(doublTapRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(ViewController.tapHandler(recognizer:))
        )
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.require(toFail: doublTapRecognizer)
        faceView.addGestureRecognizer(tapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

