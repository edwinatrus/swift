//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Chen Xiaojun on 15/7/17.
//  Copyright © 2017 Lindenbaum Pty Ltd. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.splitViewController?.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let url = DemoURL.NASA[segue.identifier ?? ""] {
            if let imageVC = (segue.destination.contents as? ImageViewController) {
                imageVC.ImageURL = url
                imageVC.title = (sender as? UIButton)?.currentTitle
            }
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contents == self {
            if let ivc = secondaryViewController.contents as? ImageViewController {
                if ivc.ImageURL == nil {
                    return true
                } else {
                    return false
                }
            }
        }
        return false
    }
}

extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        } else {
            return self
        }
    }
}
