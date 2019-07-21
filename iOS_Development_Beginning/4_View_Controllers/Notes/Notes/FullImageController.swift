//
//  FullImageController.swift
//  Notes
//
//  Created by Alexey Danilov on 7/21/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class FullImageController: UIViewController {
    
    var images: [UIImage?] = []
    
    var selectedIndex: Int?
    
    private var imageViews: [UIImageView] = []
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.isPagingEnabled = true
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.currentPage = 0
            pageControl.numberOfPages = images.count
            pageControl.addTarget(self,
                                  action: #selector(pageControlChanged),
                                  for: UIControl.Event.valueChanged)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageViews.enumerated().forEach { [weak self] (index, imageView) in
            guard let strongSelf = self else { return }
            imageView.frame.size = strongSelf.scrollView.frame.size
            imageView.frame.origin.x = strongSelf.scrollView.frame.width * CGFloat(index)
            imageView.frame.origin.y = 0
        }
        
        let contentWidth = scrollView.frame.width * CGFloat(imageViews.count)
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.height)
        
        if let selectedIndex = selectedIndex {
            if selectedIndex != 0 {
                let x = CGFloat(selectedIndex) * scrollView.frame.width
                let contentOffsetPoint = CGPoint(x: x, y: 0)
                scrollView.setContentOffset(contentOffsetPoint, animated: true)
                self.selectedIndex = nil
            }
        }
    }
    
    @objc func pageControlChanged(_ sender: UIPageControl) {
        let x = CGFloat(sender.currentPage) * scrollView.frame.width
        let contentOffsetPoint = CGPoint(x: x, y: 0)
        scrollView.setContentOffset(contentOffsetPoint, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        images.forEach { [weak self] in
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.image = $0
            self?.scrollView.addSubview(imageView)
            self?.imageViews.append(imageView)
        }
    }
    
}

// MARK: - UIScrollViewDelegate
extension FullImageController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = currentPageIndex
    }
}
