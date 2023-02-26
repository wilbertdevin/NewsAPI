//
//  CategoryViewController.swift
//  NewsAPI
//
//  Created by Wilbert Devin Wijaya on 25/02/23.
//

import UIKit
import SnapKit

protocol FirstTableViewControllerDelegate: class{
    func done(data: RootClass) -> Void
}

class CategoryViewController: UIViewController {
    
    let session = URLSession.shared
    let url = URL(string: "https://newsapi.org/v2/sources?apiKey=c8f93ef8504e4c42b5bacee31dc21aca")!
    

    private var data: RootClass?
    var checkedSource: [Source] = []
    
    private var uniqueCategories : [Source] = []
    var categoriesSet: [String] = []
    var checkedData: RootClass?
    

    
    let businessButton: UIButton = {
        let button = UIButton(type: .system)

        return button.displayText(withText: "Business", action: #selector(handleBusiness))
    }()
    
    let entertainmentButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button.displayText(withText: "Entertainment", action: #selector(handleEntertainment))
    }()
    
    let generalButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button.displayText(withText: "General", action: #selector(handleGeneral))
    }()
    
    let healthButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button.displayText(withText: "Health", action: #selector(handleHealth))
    }()
    
    let scienceButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button.displayText(withText: "Science", action: #selector(handleScience))
    }()
    
    let sportsButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button.displayText(withText: "Sports", action: #selector(handleSports))
    }()
    
    let technologyButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button.displayText(withText: "Technology", action: #selector(handleTechnology))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Category"
        
        configureComponents()
        
        
        let task = session.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            guard let self = self else { return }
                //print(error)
                //print(response)
            if error != nil {
                //print(error)
                return
            }
            do {
                let model = try JSONDecoder().decode(RootClass.self, from: data! )
//                print("Model:\(model)")
                
                self.data = model

                
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        })
        
        task.resume()
    }
    

    @objc func handleBusiness() {
        print("Business Clicked")
        let sourceLabel = UILabel()
        sourceLabel.text = "business"
        checkedSource.removeAll()
        let sources = data?.sources
        for source in sources! {
            if(source.category == sourceLabel.text){
                checkedSource.append(source)
//                print(source.category)
            }
        }
//
        let vc = SourceViewController(datasource: checkedSource)

        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func handleEntertainment() {
        print("Entertainment Clicked")
        checkedSource.removeAll()
        let sourceLabel = UILabel()
        sourceLabel.text = "entertainment"
        
        let sources = data?.sources
        for source in sources! {
            if(source.category == sourceLabel.text){
                checkedSource.append(source)
                
            }
        }
//
        let vc = SourceViewController(datasource: checkedSource)

        navigationController?.pushViewController(vc, animated: true)
        

    }

    @objc func handleGeneral() {
        print("General Clicked")
        checkedSource.removeAll()
        let sourceLabel = UILabel()
        sourceLabel.text = "general"
        
        let sources = data?.sources
        for source in sources! {
            if(source.category == sourceLabel.text){
                checkedSource.append(source)
            }
        }
//
        let vc = SourceViewController(datasource: checkedSource)

        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func handleHealth() {
        print("Health Clicked")
        
        checkedSource.removeAll()
        let sourceLabel = UILabel()
        sourceLabel.text = "health"
        
        let sources = data?.sources
        for source in sources! {
            if(source.category == sourceLabel.text){
                checkedSource.append(source)
            }
        }
//
        let vc = SourceViewController(datasource: checkedSource)

        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleScience() {
        print("Science Clicked")
        
        checkedSource.removeAll()
        let sourceLabel = UILabel()
        sourceLabel.text = "science"
        
        let sources = data?.sources
        for source in sources! {
            if(source.category == sourceLabel.text){
                checkedSource.append(source)
            }
        }
//
        let vc = SourceViewController(datasource: checkedSource)

        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleSports() {
        print("Sports Clicked")
        
        checkedSource.removeAll()
        let sourceLabel = UILabel()
        sourceLabel.text = "sports"
        
        let sources = data?.sources
        for source in sources! {
            if(source.category == sourceLabel.text){
                checkedSource.append(source)
            }
        }
//
        let vc = SourceViewController(datasource: checkedSource)

        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleTechnology() {
        print("Technology Clicked")
        
        checkedSource.removeAll()
        let sourceLabel = UILabel()
        sourceLabel.text = "technology"
        
        let sources = data?.sources
        for source in sources! {
            if(source.category == sourceLabel.text){
                checkedSource.append(source)
            }
        }
//
        let vc = SourceViewController(datasource: checkedSource)

        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureComponents() {
        
        view.addSubview(businessButton)
        businessButton.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(40)
            make.top.equalTo(200)
            make.leftMargin.equalTo(14)
          //  make.rightMargin.equalTo(-34)

        }
        
        view.addSubview(entertainmentButton)
        entertainmentButton.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(40)
            make.top.equalTo(200)
         //   make.leftMargin.equalTo(34)
            make.rightMargin.equalTo(-14)

        }
        
        view.addSubview(generalButton)
        generalButton.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(40)
            make.top.equalTo(280)
            make.leftMargin.equalTo(14)
         //   make.rightMargin.equalTo(-14)

        }
        
        view.addSubview(healthButton)
        healthButton.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(40)
            make.top.equalTo(280)
         //   make.leftMargin.equalTo(34)
            make.rightMargin.equalTo(-14)

        }
        
        view.addSubview(scienceButton)
        scienceButton.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(40)
            make.top.equalTo(360)
            make.leftMargin.equalTo(14)
         //   make.rightMargin.equalTo(-14)

        }
        
        view.addSubview(sportsButton)
        sportsButton.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(40)
            make.top.equalTo(360)
         //   make.leftMargin.equalTo(34)
            make.rightMargin.equalTo(-14)

        }
        
        view.addSubview(technologyButton)
        technologyButton.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(40)
            make.top.equalTo(440)
            make.centerX.equalToSuperview()
         //   make.leftMargin.equalTo(34)
        //    make.rightMargin.equalTo(-14)

        }
        
        
    }
    
}
