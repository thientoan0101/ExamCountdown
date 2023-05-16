//
//  Gradient+Extension.swift
//  ExamCountdown
//
//  Created by Toan Thien on 16/05/2023.
//

import UIKit

extension CAGradientLayer {
    func createGradientImage() -> UIImage? {
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}

extension UIView {
    func asImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
}

class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()

    init(frame: CGRect, fromColor: CGColor, toColor: CGColor) {
        super.init(frame: frame)
        setupGradientLayer(fromColor: fromColor, toColor: toColor)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradientLayer(fromColor: UIColor.red.cgColor, toColor: UIColor.blue.cgColor)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private func setupGradientLayer(fromColor: CGColor, toColor: CGColor) {
        gradientLayer.colors = [fromColor, toColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
