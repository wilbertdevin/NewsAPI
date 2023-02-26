//
//  MainViewController.swift
//  NewsAPI
//
//  Created by Wilbert Devin Wijaya on 24/02/23.
//

import UIKit
import SnapKit
import SafariServices

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        
        return table
    }()

    private let searchVC = UISearchController(searchResultsController: nil)
    
    private var articles = [Articles]()
    private var viewModel = [MainTableViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "News"
       // print("Source is:\(UserDefaults.standard.value(forKey: "source"))")
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchNews()
        createSearchBar()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // Reload Data
    
    private func createSearchBar() {
        
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self

        
    }
    
    func fetchNews() {
        
        APICaller.shared.getTopStories { result in
            switch result {
            case .success(let articles):

                self.articles = articles
                self.viewModel = articles.compactMap({
                    MainTableViewCellViewModel(title: $0.title,
                                               description: $0.description ?? "No Description",
                                               imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                //print(articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    @objc func reloadData(_ notification: Notification) {

        APICaller.shared.getTopStories { result in
            switch result {
            case .success(let articles):
                self.articles = articles
                self.viewModel = articles.compactMap({
                    MainTableViewCellViewModel(title: $0.title,
                                               description: $0.description ?? "No Description",
                                               imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                print(articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //Observer of  NotificationCenter for data reload trigger
        print("VIEW REAPPEAR")
        NotificationCenter.default
                          .addObserver(self,
                                       selector:#selector(reloadData(_:)),
                                       name: NSNotification.Name ("com.reload.data.success"),
                                       object: nil)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }


    // TABLE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell
        else {
            fatalError()
        }
        
        cell.configure(with: viewModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:  true)
        
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ?? "") else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.count - 1 {
            print("MOre")
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        print(text)
        
        APICaller.shared.search(with: text) { result in
            switch result {
            case .success(let articles):
                self.articles = articles
                self.viewModel = articles.compactMap({
                    MainTableViewCellViewModel(title: $0.title,
                                               description: $0.description ?? "No Description",
                                               imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                print(articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.searchVC.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
