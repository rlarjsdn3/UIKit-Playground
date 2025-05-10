//
//  CurvedShape.swift
//  UIKitTemplate
//
//  Created by 김건우 on 5/10/25.
//

import UIKit
//
//  CurvedShape.swift
//  UIKitTemplate
//
//  Created by 김건우 on 5/10/25.
//

import UIKit


// 코드 리팩토링
final class CurvedShape: UIView {
    
    private var midX: CGFloat
    
    init(midX: CGFloat = 0) {
        self.midX = midX
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ✅ 곡선 모양을 Mask로 사용할 수 있는 ShapeLayer 생성 메서드
    func createShapeLayer(for rect: CGRect, midX: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        path.move(to: CGPoint(x: midX - 40.0, y: rect.maxY))
        path.addCurve(
            to: CGPoint(x: midX, y: rect.maxY - 20.0),
            controlPoint1: CGPoint(x: midX - 15.0, y: rect.maxY),
            controlPoint2: CGPoint(x: midX - 15.0, y: rect.maxY - 20.0)
        )
        path.addCurve(
            to: CGPoint(x: midX + 40, y: rect.maxY),
            controlPoint1: CGPoint(x: midX + 15, y: rect.maxY - 20),
            controlPoint2: CGPoint(x: midX + 15, y: rect.maxY)
        )
        path.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.black.cgColor
        
        return shapeLayer
    }
    
    // ✅ 필요할 경우 중간 X 위치를 동적으로 변경
    func updateMidX(_ midX: CGFloat) {
        self.midX = midX
        self.setNeedsDisplay()
    }
}
