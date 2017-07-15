//
//  ViewController.swift
//  BabelCamera
//
//  Created by Andy Cho on 2017-07-13.
//  Copyright © 2017 AcroMace. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private static let animationTime = 0.2 // seconds
    private static let wordsDisplayTime = 3.0 // seconds

    private let cameraService = CameraService()
    private let visionService = VisionService()
    private let speechService = SpeechService()
    private let translationService = TranslationService()
    private let blurEffectView = UIVisualEffectView()

    @IBOutlet weak var translatedTextLabel: UILabel!
    @IBOutlet weak var originalTextLabel: UILabel!
    @IBOutlet weak var translateLanguageButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        cameraService.delegate = self
        cameraService.startCamera()
        let previewView = setPreview()
        cameraService.startSession()
        cameraService.updateOrientation()

        translatedTextLabel.text = ""
        originalTextLabel.text = ""

        blurEffectView.alpha = 0.9
        blurEffectView.autoresizingMask = UIViewAutoresizing(rawValue:
            UIViewAutoresizing.flexibleWidth.rawValue |
            UIViewAutoresizing.flexibleHeight.rawValue)
        previewView.addSubview(blurEffectView)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(
            alongsideTransition: { [weak self] _ in
                self?.cameraService.updateOrientation()
            },
            completion: nil)
    }

    @IBAction func cameraButtonPressed(_ sender: Any) {
        translatedTextLabel.text = "Processing..."
        originalTextLabel.text = ""
        cameraService.takePicture()
    }

    @IBAction func translationLanguageButtonPressed(_ sender: Any) {

    }

    // MARK: - Private methods

    // Add the preview view to the back of the current view
    private func setPreview() -> UIView {
        let previewView = cameraService.createPreviewView(bounds: view.bounds)
        view.addSubview(previewView)
        view.sendSubview(toBack: previewView) // Important to add UI elements on top later
        previewView.fillSuperview()
        return previewView
    }

}

extension ViewController: CameraServiceDelegate {

    func didCapture(image: CIImage) {
        visionService.detectObject(image: image) { [weak self] guess in
            guard let `self` = self else { return }
            print("Identified: \(guess)")
            self.translationService.translate(text: guess, to: .french) { translation in
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
            animations: {
                // Blur out the camera
                self.blurEffectView.effect = UIBlurEffect(style: .dark)
            }, completion: { _ in
                // Show the translations
                self.translatedTextLabel.text = translatedGuess
                self.originalTextLabel.text = guess

                // Say the translations
                self.speechService.say(translatedGuess, in: .french)
                self.speechService.say(guess)

                // After 3 seconds, remove the blur and the words
                self.perform(
                    #selector(self.removeTranslations),
                    with: nil,
                    afterDelay: ViewController.wordsDisplayTime)
            })
    }

    @objc private func removeTranslations() {
        self.translatedTextLabel.text = ""
        self.originalTextLabel.text = ""

        UIView.animate(withDuration: ViewController.animationTime) {
            self.blurEffectView.effect = nil
        }
    }

}
