//
//  ViewController.swift
//  RangeSlider
//
//  Created by 김건우 on 2/22/25.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    let rangeSlider = RangeSlider(frame: .zero)
    
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(rangeSlider)
        view.backgroundColor = .systemBackground
        
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged(_:)),
                              for: .valueChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let margin: CGFloat = 20
        let width = view.bounds.width - 2 * margin
        let height: CGFloat = 30
        
        rangeSlider.frame = CGRect(x: 0, y: 0,
                                   width: width, height: height)
        rangeSlider.center = view.center
    }
    
    
    // MARK: - Private
    
    @objc private func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        let values = "(\(rangeSlider.lowerValue) \(rangeSlider.upperValue))"
        print("Range slider value changed: \(values)")
    }


}

