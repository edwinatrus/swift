//
//  EmotionViewController.swift
//  FaceIt
//
//  Created by Chen Xiaojun on 8/7/17.
//  Copyright © 2017 Lindenbaum Pty Ltd. All rights reserved.
//

import UIKit

class EmotionViewController: UIViewController, UISplitViewControllerDelegate {
    
    private let emotionFaces: Dictionary<String, FacialExpression> = [
        "angry": FacialExpression(eyes: .closed, mouth: .frown),
        "happy": FacialExpression(eyes: .open, mouth: .smile),
        "worried": FacialExpression(eyes: .open, mouth: .smirk),
        "mischievous": FacialExpression(eyes: .closed, mouth: .grin)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func awakeFromNib() {
        self.splitViewController?.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationvc = segue.destination
        if let navcon = destinationvc as? UINavigationController {
            destinationvc = navcon.visibleViewController ?? destinationvc
        }
        if let facevc = destinationvc as? ViewController {
            if let identifier = segue.identifier {
                if let epression = emotionFaces[identifier] {
                    facevc.expression = epression
                    if let sendingButton = sender as? UIButton {
                        facevc.navigationItem.title = sendingButton.currentTitle
                    }
                }
            }
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }

}
