//
//  ViewController.swift
//  BabelCamera
//
//  Created by Andy Cho on 2017-07-13.
//  Copyright © 2017 AcroMace. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let cameraService = CameraService()
    let visionService = VisionService()

    override func viewDidLoad() {
        super.viewDidLoad()

        cameraService.delegate = self
        cameraService.startCamera()
        setPreview()
        cameraService.startSession()
    }

    @IBAction func cameraButtonPressed(_ sender: Any) {
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
        visionService.detectObject(image: image) { [weak self] label in
            print(label)
        }
    }

}
