//
//  ViewController.swift
//  nwHacks2021
//
//  Created by joeahn@cisco.com on 2021-01-09.
//

import Foundation
import UIKit
import ImageIO
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate {
    var counter = 0
    var runCount = 0
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var happinessLabel: UILabel!
    @IBOutlet var dogNeutralImage : UIImageView!
            
    @IBOutlet weak var detectedTextLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var startButton: UIButton!
 
    /* Used for the audio */
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    func recordAndRecognitionSpeech() {
        //guard
        let node = audioEngine.inputNode //else { return }
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print(error)
        }
        
        guard let myRecognizer = SFSpeechRecognizer() else {
            return
        }
        if !myRecognizer.isAvailable {
            return
        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result {
                let voiceRecognitionString = result.bestTranscription.formattedString
                print("\(voiceRecognitionString)")
            } else if let error = error {
                print(error)
            }
        })
        
    }
    
    
    @IBAction public func startButtonTapped(_ sender: UIButton) {
        self.recordAndRecognitionSpeech()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButtonTapped(startButton)
        /* Used for gestures */
        dogNeutralImage.loadGif(name: "Shiba-inu-taiki-2")
        
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
        dogNeutralImage.loadGif(name: "Shiba-inu-taiki")
        print("Device was shaken!")
    }

}

