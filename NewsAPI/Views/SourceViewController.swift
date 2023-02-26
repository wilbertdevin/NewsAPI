//
//  SourceViewController.swift
//  NewsAPI
//
//  Created by Wilbert Devin Wijaya on 25/02/23.
//

import UIKit

class SourceViewController: UITableViewController {
    
    let session = URLSession.shared
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=c8f93ef8504e4c42b5bacee31dc21aca")!
    
    private var data: [Source] = []
    
    init(datasource: [Source]) {
        super.init(style: .plain)
        self.data = removeDuplicateElements(posts: datasource)
        data.sort { (data1, data2) -> Bool in
            data1.name! < data2.name!
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        title = "Source"
        
        tableView.register(SourceTableViewCell.self, forCellReuseIdentifier: String(describing: SourceTableViewCell.self))
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SourceTableViewCell.self)) as! SourceTableViewCell
        
        let temp = data[indexPath.row]
        cell.accessoryType = temp.isSelected ? .checkmark : .none
        cell.sourceLabel.text = temp.name
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        data[indexPath.row].isSelected = !data[indexPath.row].isSelected
        tableView.reloadData()
      
    }
    
    @objc func doneButtonTapped() {
        
        let checkedSources = data.filter({ $0.isSelected })
        let sourceID = checkedSources.map({$0.id})

        let sourceString = checkedSources.flatMap({$0.id})
        let strin = sourceString.joined(separator: ",")
        let vc = MainViewController()//(datasource: checkedSources)
        UserDefaults.standard.set(strin, forKey: "source")
        print("News: \(strin)")
        
        NotificationCenter.default.post(name: NSNotification.Name("com.reload.data.success"),
                     object: nil)
        
        navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    private func removeDuplicateElements(posts: [Source]) -> [Source] {
        var uniquePosts = [Source]()
        for post in posts {
            if !uniquePosts.contains(where: {$0.name == post.name }) {
                uniquePosts.append(post)
            }
        }
        return uniquePosts
    }
}
