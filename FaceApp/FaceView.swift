//
//  FaceView.swift
//  FaceApp
//
//  Created by Alumne on 5/4/18.
//  Copyright © 2018 Alumne. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    @IBInspectable
    var faceScale: CGFloat = 0.90
    
    @IBInspectable
    var mouthCurvature: Double = 1.0
    
    @IBInspectable
    var faceCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    @IBInspectable
    var faceRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * faceScale
    }
    
    @IBInspectable
    var faceLineWidth: CGFloat = 5.0
    
    @IBInspectable
    var faceColor: UIColor = UIColor.cyan
    
    enum Eye {
        case left
        case right
    }
    
    struct Ratios {
        static let faceRadiusToEyeOffset: CGFloat = 3
        static let faceRadiusToEyeRadius: CGFloat = 5
        static let faceRadiusToMouthWidth: CGFloat = 1
        static let faceRadiusToMouthHeight: CGFloat = 3
        static let faceRadiusToMouthOffset: CGFloat = 3
    }
    
    func pathForEye(_ eye: Eye) -> UIBezierPath {
        func centerOfEye(_ eye: Eye) -> CGPoint {
            let eyeOffset = faceRadius / Ratios.faceRadiusToEyeOffset
            var eyeCenter = faceCenter
            
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == Eye.left ) ? -1 : 1) * eyeOffset
            
            return eyeCenter
        }
        
        let eyeRadius = faceRadius / Ratios.faceRadiusToEyeRadius
        let eyeCenter = centerOfEye(eye)
        let path: UIBezierPath = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        
        path.lineWidth = faceLineWidth
        return path
    }
    
    func pathForMouth() -> UIBezierPath {
        return UIBezierPath()
    }
    
    func pathForFace() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        path.lineWidth = faceLineWidth
        return path
    }
    
    override func draw(_ rect: CGRect) {
        faceColor.set()
        pathForFace().stroke()
        pathForEye(Eye.left).stroke()
        pathForEye(Eye.right).stroke()
        pathForMouth().stroke()
    }
}
