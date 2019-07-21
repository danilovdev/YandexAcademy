//
//  GalleryViewController.swift
//  HelloDemo
//
//  Created by Alexey Danilov on 7/20/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    private let images = [
        UIImage(named: "screen_1"),
        UIImage(named: "screen_2"),
        UIImage(named: "screen_3"),
        UIImage(named: "screen_4"),
        UIImage(named: "screen_5")
    ]
    
    var imageViews = [UIImageView]()
    
    @IBOutlet var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.isPagingEnabled = true
        }
    }
    
    @IBOutlet var pageControl: UIPageControl! {
        didSet {
            pageControl.currentPage = 0
            pageControl.numberOfPages = images.count
            pageControl.addTarget(self,
                                  action: #selector(pageControlValueChanged),
                                  for: UIControl.Event.valueChanged)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for image in images {
            let imageView = UIImageView()
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
        }
    }
    
    @objc func pageControlValueChanged(_ sender: UIPageControl) {
        let offset = scrollView.frame.width * CGFloat(sender.currentPage)
        scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for (index, imageView) in imageViews.enumerated() {
            imageView.frame.size = scrollView.frame.size
            imageView.frame.origin.x = scrollView.frame.width * CGFloat(index)
            imageView.frame.origin.y = 0
        }
        
        let contentWidth = scrollView.frame.width * CGFloat(imageViews.count)
        scrollView.contentSize = CGSize(width: contentWidth,
                                        height: scrollView.frame.height)
    }

}

extension GalleryViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = scrollView.contentOffset.x / scrollView.frame.width
        let roundedPageIndex = Int(pageIndex)
        pageControl.currentPage = roundedPageIndex
    }
    
}
