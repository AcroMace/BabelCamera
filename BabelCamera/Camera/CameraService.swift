//
//  CameraService.swift
//  BabelCamera
//
//  Created by Andy Cho on 2017-07-13.
//  Copyright © 2017 AcroMace. All rights reserved.
//

import Foundation
import AVKit

// Protocol that receives events when an image is successfully captured
protocol CameraServiceDelegate: class {
    func didCapture(image: CIImage)
}

class CameraService: NSObject {

    private let photoWidth = 512

    private let session = AVCaptureSession()
    private let stillCameraOutput = AVCapturePhotoOutput()
    private let cameraQueue = DispatchQueue(label: "cameraQueue")
    private var previewLayer: AVCaptureVideoPreviewLayer?

    weak var delegate: CameraServiceDelegate?

    // Start getting data from teh camera
    func startSession() {
        session.startRunning()
    }

    // Initializes the camera
    func startCamera() {
        // Add the input for getting video from the camera
        guard let backCameraInput = getBackCameraInput() else {
            print("Could not instantiate the back camera device input")
            return
        }
        guard session.canAddInput(backCameraInput) else {
            print("Could not add the back camera input to the session")
            return
        }
        session.addInput(backCameraInput)

        // Add the output for taking pictures
        guard session.canAddOutput(stillCameraOutput) else {
            print("Could not add camera output for taking pictures to the session")
            return
        }
        session.addOutput(stillCameraOutput)
    }

    // This is how a view can get a video feed from the camera
    func createPreviewView(bounds: CGRect) -> UIView {
        if self.previewLayer == nil {
            self.previewLayer = AVCaptureVideoPreviewLayer(session: session)
        }
        self.previewLayer?.videoGravity = .resizeAspectFill
        updateOrientation()

        return CameraPreviewView(frame: bounds, previewLayer: previewLayer!)
    }

    // This should be called whenever the device orientation is updated
    func updateOrientation() {
        let applicationOrientation = UIApplication.shared.statusBarOrientation
        previewLayer?.connection?.videoOrientation = convert(orientation: applicationOrientation)
    }

    func takePicture() {
        cameraQueue.async {
            let connection = self.stillCameraOutput.connection(with: .video)
            if let orientation = AVCaptureVideoOrientation(rawValue: UIDevice.current.orientation.rawValue) {
                connection?.videoOrientation = orientation
            }

            let captureSettings = AVCapturePhotoSettings()
            // Underscores added in Xcode 9 beta 4
            guard let previewPixelType = captureSettings.__availablePreviewPhotoPixelFormatTypes.first else {
                print("Could not find any available preview photo pixel format types")
                return
            }
            let previewFormat = [
                kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
                kCVPixelBufferWidthKey as String: 512,
                kCVPixelBufferHeightKey as String: 512
            ]
            captureSettings.previewPhotoFormat = previewFormat
            self.stillCameraOutput.capturePhoto(with: captureSettings, delegate: self)
        }
    }

    // MARK: - Private methods

    // We cannot cast since .unknown is not an AVCaptureVideoOrientation
    private func convert(orientation: UIInterfaceOrientation) -> AVCaptureVideoOrientation {
        switch orientation {
        case .landscapeLeft:
            return .landscapeLeft
        case .landscapeRight:
            return .landscapeRight
        case .portrait:
            return .portrait
        case .portraitUpsideDown:
            return .portraitUpsideDown
        case .unknown:
            return .portrait
        }
    }

    private func getBackCameraInput() -> AVCaptureDeviceInput? {
        // It seems that specifying the back camera is no longer available in Xcode 9 beta 4?
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Could not get the back camera")
            return nil
        }
        return try? AVCaptureDeviceInput(device: backCamera)
    }

}

extension CameraService: AVCapturePhotoCaptureDelegate {

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }

        guard let photoData = photo.fileDataRepresentation(),
            let uiImage = UIImage(data: photoData),
            let ciImage = CIImage(image: uiImage) else {
                print("Could not get the captured photo")
                return
        }

        delegate?.didCapture(image: ciImage)
    }

}
