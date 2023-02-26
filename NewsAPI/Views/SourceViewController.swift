//
//  SourceViewController.swift
//  NewsAPI
//
//  Created by Wilbert Devin Wijaya on 25/02/23.
//

import UIKit

class SourceViewController: UITableViewController, UISearchBarDelegate {
    
    let session = URLSession.shared
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=c8f93ef8504e4c42b5bacee31dc21aca")!
    
    private let searchVC = UISearchController(searchResultsController: nil)

    
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

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false

        title = "Source"
        
        tableView.register(SourceTableViewCell.self, forCellReuseIdentifier: String(describing: SourceTableViewCell.self))
        
        tableView.reloadData()
        
        createSearchBar()
        
    }
    
    
    private func createSearchBar() {
        
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SourceTableViewCell.self)) as! SourceTableViewCell
        
        let temp = data[indexPath.row]
        cell.sourceLabel.text = temp.name

        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.reloadData()
        print("DATA IS: \(data[indexPath.row])")
        let dataIndex = data[indexPath.row]

        let sourceData = dataIndex.id
        print("SourceData: \(sourceData)")
        let vc = MainViewController()
        UserDefaults.standard.set(sourceData, forKey: "source")
        
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
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        print(text)
        UserDefaults.standard.set(text, forKey: "sourceSearch")
        if text != nil {
            navigationController?.pushViewController(SourceSearchViewController(), animated: false)

            
        }
        
    }
    
}
