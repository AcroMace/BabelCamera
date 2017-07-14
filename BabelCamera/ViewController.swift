//
//  ViewController.swift
//  BabelCamera
//
//  Created by Andy Cho on 2017-07-13.
//  Copyright © 2017 AcroMace. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private static let animationTime = 1.0 // seconds
    private static let wordsDisplayTime = 3.0 // seconds

    private let cameraService = CameraService()
    private let visionService = VisionService()
    private let speechService = SpeechService()
    private let translationService = TranslationService()
    private let blurEffectView = UIVisualEffectView()

    @IBOutlet weak var translatedTextLabel: UILabel!
    @IBOutlet weak var originalTextLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        cameraService.delegate = self
        cameraService.startCamera()
        setPreview()
        cameraService.startSession()

        translatedTextLabel.text = ""
        originalTextLabel.text = ""

        blurEffectView.autoresizingMask = UIViewAutoresizing(rawValue:
            UIViewAutoresizing.flexibleWidth.rawValue |
            UIViewAutoresizing.flexibleHeight.rawValue)
    }

    @IBAction func cameraButtonPressed(_ sender: Any) {
        translatedTextLabel.text = "Processing..."
        originalTextLabel.text = ""
        cameraService.takePicture()
    }

    // MARK: - Private methods

    // Add the preview view to the back of the current view
    private func setPreview() {
        let previewView = cameraService.createPreviewView(bounds: view.bounds)
        view.addSubview(previewView)
        view.sendSubview(toBack: previewView) // Important to add UI elements on top later
        previewView.fillSuperview()
    }

}

extension ViewController: CameraServiceDelegate {

    func didCapture(image: CIImage) {
        visionService.detectObject(image: image) { [weak self] guess in
            guard let `self` = self else { return }
            print("Identified: \(guess)")
            self.translationService.translateFromGoogle(text: guess) { translation in
                DispatchQueue.main.async {
                    self.presentTranslations(translatedGuess: translation, guess: guess)
                }
            }
        }
    }

    private func presentTranslations(translatedGuess: String, guess: String) {
        blurEffectView.frame = view.bounds

        UIView.animate(
            withDuration: ViewController.animationTime,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                // Blur out the camera
                guard UIAccessibilityIsReduceTransparencyEnabled() else {
                    print("Not blurring since reduce transparency is enabled")
                    return
                }
                self.blurEffectView.effect = UIBlurEffect(style: .dark)
            }, completion: { _ in
                // Show the translations
                self.translatedTextLabel.text = translatedGuess
                self.originalTextLabel.text = guess

                // Say the translations
                self.speechService.say(translatedGuess, in: "fr-FR")
                self.speechService.say(guess)

                // After 3 seconds, remove the blur and the words
                self.removeTranslations()
            })
    }

    private func removeTranslations() {
        self.translatedTextLabel.text = ""
        self.originalTextLabel.text = ""

        UIView.animate(
            withDuration: ViewController.animationTime,
            delay: ViewController.wordsDisplayTime,
            options: UIViewAnimationOptions.curveEaseInOut,
            animations: {
                self.blurEffectView.effect = nil
            },
            completion: nil)
    }

}
