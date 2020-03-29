//
//  ViewController.swift
//  1090324
//
//  Created by Nick on 2020/3/24.
//  Copyright © 2020 NewIdea. All rights reserved.

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView?
    var pageControl: UIPageControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 建立一個大小與螢幕相同的 ScrollView
        scrollView = UIScrollView()
        scrollView!.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        // 在 ScrollView 內由左至右加入三個大小同等於螢幕大小的 ImageView
        for i in 0..<3 {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: CGFloat(i)*self.view.frame.width, y: 0, width:self.view.frame.width, height: self.view.frame.height)
            imageView.image =  UIImage(named: "Pic\(i)")
            scrollView!.addSubview(imageView)
        }
        
        // 設定 ScrollView 的可滑動內容大小(contentSize)為螢幕的3倍寬
        scrollView?.contentSize.width = CGFloat(3)*self.view.frame.width
        scrollView?.contentSize.height = 0
        
        // 關閉滑動反彈效果
        scrollView?.bounces = false
        
        scrollView?.isPagingEnabled = true
        
        // 設定ScrollView 的 Delegate 為自己(ViewController)**********
        scrollView?.delegate = self
        // 把 ScrollView 加到 View 的 SubView
        self.view.addSubview(scrollView!)
        
        
        // 建立一個(寬=螢幕寬, 高=30)的 PageControl
        pageControl = UIPageControl()
        pageControl?.frame = CGRect(x: 0, y: self.view.frame.height - 50, width: self.view.frame.width, height: 30)
        
        // 預設 PageControl 有3頁, 初始位置在第1頁
        pageControl?.numberOfPages = 3
        pageControl?.currentPage = 0
        
        // 當 PageControl 的值改變(即換頁)時會呼叫 pageChanged() 方法
        pageControl?.addTarget(self, action: #selector(ViewController.pageChanged), for: .valueChanged)
        
        self.view.addSubview(pageControl!)
    }

    // 當換頁時，ScrollView 必須捲動到適當位置，透過 setContentOffset 調整 ScrollView 的捲軸位置
    @objc func pageChanged() {
        let offset = CGPoint(x: (scrollView?.frame.width)! * CGFloat(pageControl!.currentPage), y: 0)
        scrollView?.setContentOffset(offset, animated: true)
    }
    
    /* 當 ScrollView 減速靜止時會被呼叫
       利用 ScrollView 的 offset 算出應該顯示哪一頁，讓 PageControl 顯示正確的頁數
       最後再調整 ScrollView 讓圖片置中
    */
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x/scrollView.frame.width))
        pageControl?.currentPage = page
        let offset = CGPoint(x: CGFloat(page)*scrollView.frame.width, y: 0)
        scrollView.setContentOffset(offset, animated: true)
    }
}

