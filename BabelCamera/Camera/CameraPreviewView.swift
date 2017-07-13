//
//  CameraPreviewView.swift
//  BabelCamera
//
//  Created by Andy Cho on 2017-07-13.
//  Copyright © 2017 AcroMace. All rights reserved.
//

import UIKit
import AVKit

// Automatically resizes the preview layer to fit the bounds of the view
class CameraPreviewView: UIView {

    var previewLayer: AVCaptureVideoPreviewLayer?

    init(frame: CGRect, previewLayer: AVCaptureVideoPreviewLayer) {
        super.init(frame: frame)
        self.previewLayer = previewLayer
        previewLayer.frame = bounds
        self.layer.addSublayer(previewLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = bounds
    }

}
