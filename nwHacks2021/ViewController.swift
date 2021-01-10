//
//  ViewController.swift
//  nwHacks2021
//
//  Created by joeahn@cisco.com on 2021-01-09.
//

import Foundation
import UIKit
import ImageIO

class ViewController: UIViewController {
    var counter = 0
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var happinessLabel: UILabel!
    //@IBAction func buttonTapped(_ sender: Any) {
    //    counter += 1
    //    counterLabel.text = "\(counter)"
    //}
    
    @IBOutlet var dogNeutralImage : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dogNeutralImage.loadGif(name: "Shiba-inu-taiki-2")
        //dogNeutralImage.isHidden = true
        
        //let myView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        //myView.backgroundColor = .red
        //myView.center = view.center
        //view.addSubview(myView)
        
        let gestureRecongizerSwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(gestureSwipe(_:)))
        gestureRecongizerSwipeLeft.direction = .left
        gestureRecongizerSwipeLeft.numberOfTouchesRequired = 1
        
        let gestureRecongizerSwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(gestureSwipe(_:)))
        gestureRecongizerSwipeRight.direction = .right
        gestureRecongizerSwipeRight.numberOfTouchesRequired = 1
        
        let gestureRecongizerSwipeTop = UISwipeGestureRecognizer(target: self, action: #selector(gestureSwipe(_:)))
        gestureRecongizerSwipeTop.direction = .up
        gestureRecongizerSwipeTop.numberOfTouchesRequired = 1
        
        let gestureRecongizerSwipeBottom = UISwipeGestureRecognizer(target: self, action: #selector(gestureSwipe(_:)))
        gestureRecongizerSwipeBottom.direction = .down
        gestureRecongizerSwipeBottom.numberOfTouchesRequired = 1
        
        let gestureRecongizerTap = UITapGestureRecognizer(target: self, action: #selector(gestureTap(_:)))
        gestureRecongizerTap.numberOfTapsRequired = 1
        gestureRecongizerTap.numberOfTouchesRequired = 1
        
        dogNeutralImage.addGestureRecognizer(gestureRecongizerSwipeTop)
        dogNeutralImage.addGestureRecognizer(gestureRecongizerSwipeBottom)
        dogNeutralImage.addGestureRecognizer(gestureRecongizerSwipeRight)
        dogNeutralImage.addGestureRecognizer(gestureRecongizerSwipeLeft)
        dogNeutralImage.addGestureRecognizer(gestureRecongizerTap)
        dogNeutralImage.isUserInteractionEnabled = true
    }

    @objc func gestureTap(_ gesture: UITapGestureRecognizer) {
        counter += 1
        counterLabel.text = "\(counter)"
        dogNeutralImage.loadGif(name: "Shiba-inu-taiki")
    }
    
    @objc func gestureSwipe(_ gesture: UISwipeGestureRecognizer) {
        counter += 1
        counterLabel.text = "\(counter)"
        dogNeutralImage.loadGif(name: "Shiba-inu-taiki")
    }
    

}

