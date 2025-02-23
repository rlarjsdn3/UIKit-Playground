//
//  RangeSlider.swift
//  RangeSlider
//
//  Created by 김건우 on 2/22/25.
//

import UIKit

class RangeSlider: UIControl {
    
    // MARK: - Properties
    
    /// 프레임이 변경될 때 레이어 프레임을 업데이트
    override var frame: CGRect {
        didSet {
            updateLayerFrame()
        }
    }
    
    /// 최소값 설정
    var minimumValue: CGFloat = 0 {
        didSet {
            updateLayerFrame()
        }
    }
    
    /// 최대값 설정
    var maximumValue: CGFloat = 1 {
        didSet {
            updateLayerFrame()
        }
    }
    
    /// 하한 값 설정
    var lowerValue: CGFloat = 0.2 {
        didSet {
            updateLayerFrame()
        }
    }
    
    /// 상한 값 설정
    var upperValue: CGFloat = 0.8 {
        didSet {
            updateLayerFrame()
        }
    }
    
    /// 기본 썸 이미지 설정
    var thumbImage = #imageLiteral(resourceName: "Oval") {
        didSet {
            upperThumbImageView.image = thumbImage
            lowerThumbImageView.image = thumbImage
            updateLayerFrame()
        }
    }
    
    /// 강조된 썸 이미지 설정
    var highlightedThumbImage = #imageLiteral(resourceName: "HighlightedOval") {
        didSet {
            upperThumbImageView.highlightedImage = highlightedThumbImage
            lowerThumbImageView.highlightedImage = highlightedThumbImage
            updateLayerFrame()
        }
    }
    
    /// 트랙 레이어
    private let trackLayer = RangeSliderTrackLayer()
    
    /// 하한 썸 이미지 뷰
    private let lowerThumbImageView = UIImageView()
    
    /// 상한 썸 이미지 뷰
    private let upperThumbImageView = UIImageView()
    
    /// 트랙 기본 색상 설정
    var trackTintColor = UIColor(white: 0.9, alpha: 1) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    /// 트랙 강조 색상 설정
    var trackHighlightTintColor = UIColor(red: 0, green: 0.45, blue: 0.94, alpha: 1) {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    /// 이전 터치 위치 저장
    private var previousLocation = CGPoint()
    
    
    // MARK: - Intializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        
        lowerThumbImageView.image = thumbImage
        addSubview(lowerThumbImageView)
        
        upperThumbImageView.image = thumbImage
        addSubview(upperThumbImageView)
        
        updateLayerFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func positionForValue(_ value: CGFloat) -> CGFloat {
        return bounds.width * value
    }
    
    // MARK: - Private
    
    private func updateLayerFrame() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        lowerThumbImageView.frame = CGRect(origin: thumbOriginForValue(lowerValue),
                                           size: thumbImage.size)
        upperThumbImageView.frame = CGRect(origin: thumbOriginForValue(upperValue),
                                           size: thumbImage.size)
        
        CATransaction.commit()
    }
    
    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
        let x = positionForValue(value) - thumbImage.size.width / 2.0
        return CGPoint(x: x, y: (bounds.height - thumbImage.size.height) / 2.0)
    }
    
}

// MARK: - Tracking

extension RangeSlider {
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        if lowerThumbImageView.frame.contains(previousLocation) {
            lowerThumbImageView.isHighlighted = true
        } else if upperThumbImageView.frame.contains(previousLocation) {
            upperThumbImageView.isHighlighted = true
        }
        
        return lowerThumbImageView.isHighlighted || upperThumbImageView.isHighlighted
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        let deltaLocation = location.x - previousLocation.x //
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width //
        
        previousLocation = location //
        
        if lowerThumbImageView.isHighlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue,
                                    upperValue: upperValue)
        } else if upperThumbImageView.isHighlighted {
            upperValue += deltaValue
            upperValue = boundValue(upperValue, toLowerValue: lowerValue,
                                    upperValue: maximumValue)
        }

        sendActions(for: .valueChanged)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbImageView.isHighlighted = false
        upperThumbImageView.isHighlighted = false
    }
    
    private func boundValue(
        _ value: CGFloat,
        toLowerValue lowerValue: CGFloat,
        upperValue: CGFloat
    ) -> CGFloat {
        return min(max(value, lowerValue), upperValue)
    }
}
