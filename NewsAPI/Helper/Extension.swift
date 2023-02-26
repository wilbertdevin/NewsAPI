//
//  Extension.swift
//  NewsAPI
//
//  Created by Wilbert Devin Wijaya on 25/02/23.
//

import UIKit

extension UIButton {
    func displayText(withText text: String, action selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 20
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        return button
    }
}
