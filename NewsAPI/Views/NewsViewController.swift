//
//  NewsViewController.swift
//  NewsAPI
//
//  Created by Wilbert Devin Wijaya on 25/02/23.
//

import UIKit

class NewsViewController: UITableViewController {

    let session = URLSession.shared
    let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=c8f93ef8504e4c42b5bacee31dc21aca")!

    private var data : ArticlesData?
    private var articles : [Article] = []
    private var sources: [Source] = []
    var newsSet = Set<String>()

    var receivedString: [String] = []
    var storeAPI = ""

    init(datasource: [Source]) {

        super.init(style: .plain)
        self.sources = datasource

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "News"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleFetch))

        print(UserDefaults.standard.value(forKey: "source"))
        //fetchData()
        //userdefault()
    }

    func fetchData() {
        let task = session.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            guard let self = self else { return }
            //print(error)
            //print(response)
            if error != nil {
                //print(error)
                return
            }
            do {
                let model = try JSONDecoder().decode(ArticlesData.self, from: data! )

                self.data = model

                DispatchQueue.main.async { [weak self] in
                    for article in (self?.data?.articles!)!{
                        for source in self!.sources{
//                            if(article.source?.name == source.name){
//                                self!.articles.append(article)
//                            }
//                            print(source.id)
                            let sourceID = source.id
//                            print(sourceID)
                            //if sourceID != nil {
                            self?.receivedString.append(sourceID!)
                            //  }
                             UserDefaults.standard.set(sourceID, forKey: "source")
                        }
                    }
                    self?.tableView.reloadData()
                }
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        })

        task.resume()

    }

    @objc func handleFetch() {
        print("Received: \(receivedString)")


    }



    func userdefault() {
        //print(UserDefaults.standard.value(forKey: "source"))
        print(receivedString)
    }
}






