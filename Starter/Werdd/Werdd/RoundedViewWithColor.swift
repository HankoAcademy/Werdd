//
//  RoundedViewWithColor.swift
//  Werdd
//
//  Created by Han Kim on 2/21/22.
//

import UIKit

class RoundedViewWithColor: UIView {
    
    let color: UIColor?
    
    init(color: UIColor?, frame: CGRect = .zero) {
        self.color = color
        
        super.init(frame: frame)
        
        backgroundColor = color
        layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
