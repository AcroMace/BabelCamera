//
//  CameraService.swift
//  BabelCamera
//
//  Created by Andy Cho on 2017-07-13.
//  Copyright © 2017 AcroMace. All rights reserved.
//

import Foundation
import AVKit

class CameraService {

    private let session = AVCaptureSession()

    // Start getting data from teh camera
    func startSession() {
        session.startRunning()
    }

    // Initializes the camera as an input
    func startCamera() {
        guard let backCameraInput = getBackCameraInput() else {
            print("Could not instantiate the back camera device input")
            return
        }
        guard session.canAddInput(backCameraInput) else {
            print("Could not add the back camera input to the session")
            return
        }
        session.addInput(backCameraInput)
    }

    // This is how a view can get a video feed from the camera
    func createPreviewView(bounds: CGRect) -> UIView {
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        let cameraPreviewView = CameraPreviewView(frame: bounds, previewLayer: previewLayer)
        return cameraPreviewView
    }

    private func getBackCameraInput() -> AVCaptureDeviceInput? {
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Could not get the back camera")
            return nil
        }
        return try? AVCaptureDeviceInput(device: backCamera)
    }

}
