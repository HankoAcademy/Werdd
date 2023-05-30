//
//  RefreshButton.swift
//  Werdd
//
//  Created by Han Kim on 2/21/22.
//

import UIKit

class RefreshButton: UIButton {
    
    var completion: (() -> Void)?
    
    init(completion: (() -> Void)?, frame: CGRect = .zero) {
        super.init(frame: frame)
        
        self.completion = completion
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI() {
        tintColor = .white
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .medium)
        let image = UIImage(systemName: "arrow.triangle.2.circlepath.circle", withConfiguration: symbolConfiguration)
        setImage(image, for: .normal)
        
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        completion?()
    }
}
