//
//  CircleView.swift
//  UIKitTemplate
//
//  Created by 김건우 on 5/10/25.
//

import UIKit

final class Circle: UIView {

    override var tintColor: UIColor? {
        didSet { updateColor() }
    }
    
    var shapeLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath(ovalIn: rect)

        self.shapeLayer = CAShapeLayer()
        shapeLayer?.path = path.cgPath
        self.layer.addSublayer(shapeLayer!)
    }
    
    private func updateColor() {
        shapeLayer?.fillColor = tintColor?.cgColor
    }

}

#Preview {
    Circle()
}
