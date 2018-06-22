//
//  ViewController.swift
//  ScollViewInfinitePlay
//
//  Created by EthanLin on 2018/6/21.
//  Copyright © 2018 EthanLin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scrollView:UIScrollView!
    
    var imageCount:Int = 8
    //記錄現在的圖片是多少
    var currentPage:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPage = 0
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        
        
        //固定3張圖片在輪播
        for i in 0...2{
            let imageView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width * CGFloat(i), y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            imageView.image = UIImage(named: "\(((i)+7) % 8)")
            print("imageName","\(((i)+7) % 8)")
            scrollView.addSubview(imageView)
        }
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 3, height: UIScreen.main.bounds.height)
        scrollView.contentOffset = CGPoint(x: UIScreen.main.bounds.width, y: 0)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        //        pageView = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 30, width: UIScreen.main.bounds.width, height: 30))
        //        view.addSubview(pageView)
        //        pageView.numberOfPages = imageCount
        //        pageView.currentPage = 0
        //        pageView.pageIndicatorTintColor = UIColor.white
        //        pageView.currentPageIndicatorTintColor = UIColor.blue
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 下一張圖片
    func nextImage() {
        if currentPage == imageCount - 1 {
            currentPage = 0
        } else {
            currentPage! += 1
        }
        let contentOffset = CGPoint(x: UIScreen.main.bounds.width * 2, y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    /// 上一張圖片
    func preImage() {
        if currentPage == 0 {
            currentPage = imageCount - 1
        } else {
            currentPage! -= 1
        }
        
        let contentOffset = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(contentOffset, animated: true)
    }
    
    func reloadImage(){
        let currentIndex = currentPage!
        let nextIndex = (currentIndex + 1) % 8
        let preIndex = (currentIndex + 7) % 8
        
        (scrollView.subviews[0] as! UIImageView).image = UIImage(named: "\(preIndex)")
        (scrollView.subviews[1] as! UIImageView).image = UIImage(named: "\(currentIndex)")
        (scrollView.subviews[2] as! UIImageView).image = UIImage(named: "\(nextIndex)")
    }
    
}

extension ViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        reloadImage()
        scrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width, y: 0), animated: false)

    }
    //
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.x < UIScreen.main.bounds.width{
            preImage()
        }else{
            nextImage()
        }
    }
}

