//
//  ViewController.swift
//  UICircleSegmentSample
//
//  Created by Murawaki on 7/21/16.
//  Copyright © 2016 Murawaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segmentView = UICircleSegmentView(frame: CGRectMake(50, 200, self.view.frame.width-100, 200),
                                              CircleNum: 3,
                                              CircleSize: 100, sCircleSize: 40);
        segmentView.value = ["ツイート", "フォロー", "フォロワー"];
        segmentView.sValue = ["120", "92", "91"];
        segmentView.addTarget(self, action: #selector(self.didChanged));
        
        self.view.addSubview(segmentView);
    }
    
    func didChanged(){
        print("changedValue");
    }
}

