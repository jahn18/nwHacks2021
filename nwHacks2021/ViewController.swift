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
import MediaPlayer


class ViewController: UIViewController, SFSpeechRecognizerDelegate {
    var counter = 0
    var runCount = 0
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var happinessLabel: UILabel!
    
    @IBAction func confusedButton(_ sender: Any) {
        dogNeutralImage.loadGif(name: "Shiba-inu-taiki-3")
        runCount = 0
    }
    
    @IBOutlet var dogNeutralImage : UIImageView!
 
    /* Used for the audio */
    let audioEngine = AVAudioEngine()
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()
    var recognitionTask: SFSpeechRecognitionTask?
    
    var wasNameCalled : Bool!
    var wrongNameCalled : Bool!
    
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
                var text = voiceRecognitionString.split(separator: " ")
                //print("\(text.popLast() ?? "")")
                if((text.popLast()?.lowercased() ?? "") == (self.customPetName?.lowercased() ?? "")) {
                    self.wasNameCalled = true
                } else {
                    if((text.popLast() ?? "") != "") {
                        self.wrongNameCalled = true
                    }
                }
            } else if let error = error {
                print(error)
            }
        })
        
    }
    
    
    @IBAction public func startButtonTapped(_ sender: UIButton) {
        self.recordAndRecognitionSpeech()
    }
    
    /* Name input */
    var customPetName : String!
    
    @IBAction func actionButtonPressed(_ touch : UIButton) {
        showInputAlert()
        touch.removeFromSuperview()
    }
    
    private func showInputAlert() {
        let alertController = UIAlertController(title: "Pet Name", message: "What do you want to name your pet?", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            var _petName = String()
            if let nameTextField = alertController.textFields?.first,
               let petName = nameTextField.text {
                _petName = petName
            }
            self.customPetName = _petName
            //print("\(_petName)")
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        /* Audio recoginition */
        recordAndRecognitionSpeech()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if(self.wasNameCalled == true) {
                self.nameWasCalled()
            } //else if (self.wrongNameCalled == true) {
                //self.wrongNameWasCalled()
            //}
        }
        
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
    
    func nameWasCalled() {
        dogNeutralImage.loadGif(name: "Shiba-inu-taiki")
        counter += 25
        counterLabel.text = "\(counter)"
        self.wasNameCalled = false
        runCount = -1
    }
    
    func wrongNameWasCalled() {
        dogNeutralImage.loadGif(name: "Confused-Shiba")
        self.wrongNameCalled = false
        runCount = 0
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        dogNeutralImage.loadGif(name: "Dizzy-Shiba")
        counter -= 3
        counterLabel.text = "\(counter)"
        runCount = -2
    }

    
    
}

