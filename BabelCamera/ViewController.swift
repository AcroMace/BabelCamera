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
    var previewView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        cameraService.startCamera()
        setPreview()
        cameraService.startSession()
    }

    // Add the preview view to the back of the current view
    private func setPreview() {
        let previewView = cameraService.createPreviewView(bounds: view.bounds)
        view.addSubview(previewView)
        view.sendSubview(toBack: previewView) // Important to add UI elements on top later
        previewView.fillSuperview()
        self.previewView = previewView
    }

}
