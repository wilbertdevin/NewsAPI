//
//  SourceTableViewCell.swift
//  NewsAPI
//
//  Created by Wilbert Devin Wijaya on 25/02/23.
//

import UIKit

class SourceTableViewCell: UITableViewCell {

    var sourceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI(){
        
        let stack = UIStackView()
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10

        stack.addArrangedSubview(sourceLabel)
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.numberOfLines = 0
        
        
        
    }

}

