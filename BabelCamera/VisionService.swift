//
//  VisionService.swift
//  BabelCamera
//
//  Created by Andy Cho on 2017-07-13.
//  Copyright © 2017 AcroMace. All rights reserved.
//

import Foundation
import Vision

class VisionService {

    func detectObject(image: CIImage, callback: @escaping (String) -> Void) {
        guard let model = try? VNCoreMLModel(for: SqueezeNet().model) else {
            print("Could not load the SqueezeNet model")
            return
        }
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first else {
                    fatalError("Unexpected result type from VNCoreMLRequest")
            }
            if error != nil {
                print(error.debugDescription)
            }
            DispatchQueue.main.async {
                callback(topResult.identifier)
            }
        }
        let handler = VNImageRequestHandler(ciImage: image)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
    }

}
