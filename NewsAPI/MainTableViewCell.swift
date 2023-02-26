//
//  MainTableViewCell.swift
//  NewsAPI
//
//  Created by Wilbert Devin Wijaya on 24/02/23.
//

import UIKit

class MainTableViewCellViewModel {
    let title: String
    let description: String
    let imageURL: URL?
    var imageData: Data?
    
    init(title: String, description: String, imageURL: URL?, imageData: Data? = nil) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
        self.imageData = imageData
    }
}

class MainTableViewCell: UITableViewCell {

    static let identifier = "MainTableViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(newsImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRect(x: 10,
                                  y: 0,
                                  width: contentView.frame.size.width - 170,
                                  height: 70)
        
        descriptionLabel.frame = CGRect(x: 10,
                                        y: 60,
                                        width: contentView.frame.size.width - 170,
                                        height: contentView.frame.size.height/2)
        
        newsImageView.frame = CGRect(x: contentView.frame.size.width - 150,
                                     y: 5,
                                     width: 160,
                                     height: contentView.frame.size.height - 10)
        

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        descriptionLabel.text = nil
        newsImageView.image = nil
    }
    
    func configure(with viewModel: MainTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        // Image
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        }
        else if let url = viewModel.imageURL {
            // Fetch
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }

}
