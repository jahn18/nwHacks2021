//
//  ViewController.swift
//  nwHacks2021
//
//  Created by joeahn@cisco.com on 2021-01-09.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        myView.backgroundColor = .red
        myView.center = view.center
        view.addSubview(myView)
        
        let gestureRecongizerSwipe = UISwipeGestureRecognizer(target: self, action: #selector(gestureSwipe(_:)))
        gestureRecongizerSwipe.direction = .right
        gestureRecongizerSwipe.numberOfTouchesRequired = 1
        
        let gestureRecongizerTap = UITapGestureRecognizer(target: self, action: #selector(gestureTap(_:)))
        gestureRecongizerTap.numberOfTapsRequired = 1
        gestureRecongizerTap.numberOfTouchesRequired = 1
        
        myView.addGestureRecognizer(gestureRecongizerSwipe)
        myView.addGestureRecognizer(gestureRecongizerTap)
        myView.isUserInteractionEnabled = true
    }

    @objc func gestureTap(_ gesture: UITapGestureRecognizer) {
        if let fireView = gesture.view {
            fireView.backgroundColor = .blue
        } else {
            print("gesture fired")
        }
    }
    
    @objc func gestureSwipe(_ gesture: UISwipeGestureRecognizer) {
        if let fireView = gesture.view {
            fireView.backgroundColor = .yellow
        }
    }
    

}

