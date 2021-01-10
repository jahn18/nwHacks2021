//
//  ViewController.swift
//  nwHacks2021
//
//  Created by joeahn@cisco.com on 2021-01-09.
//

import Foundation
import UIKit
import ImageIO
import MediaPlayer

class ViewController: UIViewController {
    var counter = 0
    var runCount = 0
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var happinessLabel: UILabel!
    //@IBAction func buttonTapped(_ sender: Any) {
    //    counter += 1
    //    counterLabel.text = "\(counter)"
    //}
    
    @IBAction func confusedButton(_ sender: Any) {
        dogNeutralImage.loadGif(name: "Shiba-inu-taiki-3")
        runCount = 0
    }
    
    @IBOutlet var dogNeutralImage : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dogNeutralImage.loadGif(name: "Shiba-inu-taiki-2")
        //dogNeutralImage.isHidden = true
        
        //let myView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        //myView.backgroundColor = .red
        //myView.center = view.center
        //view.addSubview(myView)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    self.runCount += 1
                    print("Number: \(self.runCount)")

                    if self.runCount >= 2 {
                        self.dogNeutralImage.loadGif(name: "Shiba-inu-taiki-2")
                    }
                }
        
        let gestureRecongizerSwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(gestureSwipe(_:)))
        gestureRecongizerSwipeLeft.direction = .left
        
        let gestureRecongizerSwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(gestureSwipe(_:)))
        gestureRecongizerSwipeRight.direction = .right
        
        let gestureRecongizerSwipeTop = UISwipeGestureRecognizer(target: self, action: #selector(gestureSwipe(_:)))
        gestureRecongizerSwipeTop.direction = .up
        
        let gestureRecongizerSwipeBottom = UISwipeGestureRecognizer(target: self, action: #selector(gestureSwipe(_:)))
        gestureRecongizerSwipeBottom.direction = .down
        
        let gestureRecongizerTap = UITapGestureRecognizer(target: self, action: #selector(gestureTap(_:)))
        gestureRecongizerTap.numberOfTapsRequired = 1
        
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
        runCount = 0
    }
    
    @objc func gestureSwipe(_ gesture: UISwipeGestureRecognizer) {
        counter += 5
        counterLabel.text = "\(counter)"
        dogNeutralImage.loadGif(name: "Shiba-inu-taiki")
        runCount = 0
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("Device was shaken!")
    }

    
    
}

