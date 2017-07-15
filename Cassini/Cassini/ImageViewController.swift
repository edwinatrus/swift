//
//  ImageViewController.swift
//  Cassini
//
//  Created by Chen Xiaojun on 11/7/17.
//  Copyright © 2017 Lindenbaum Pty Ltd. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03
            scrollView.maximumZoomScale = 2.0
            scrollView.contentSize = imageView.frame.size
            scrollView.addSubview(imageView)
        }
    }
    
    var ImageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    fileprivate var imageView = UIImageView()
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image == nil {
            fetchImage()
        }
    }
    
    private func fetchImage() {
        if let url = ImageURL {
            spinner.startAnimating()
            
            DispatchQueue.global(qos: .userInitiated).async {[weak self] in
                let urlContents = try? Data(contentsOf: url)
                if let imageData = urlContents, url == self?.ImageURL {
                    DispatchQueue.main.async {[weak self] in
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
