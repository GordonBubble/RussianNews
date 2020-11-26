//
//  NewsViewController.swift
//  RussianNews
//
//  Created by Яблочко on 18.11.2020.
//  Copyright © 2020 Roman Avdonin. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var articles: [Article] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchData()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        
    }
    
    func fetchData() {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=ru&apiKey=634fdd817c474e29933845a53e712d45") else { return }
        
        let urlRequest = URLRequest(url: url)
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data else { return }
            
           // self.articles = [Article]()
            
            do {
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : AnyObject]
                let articlesFromJson = json!["articles"] as! [[String : AnyObject]]
                
                for dictionary in articlesFromJson {
                    let newArticle = Article(dictionary: dictionary)
                    self.articles.append(newArticle!)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        task.resume()
    }
   private func configureCell(cell: CollectionViewCell, for indexPath: IndexPath) {
        
        let news = articles[indexPath.row]
        cell.titleLabel.text = news.headLine
        cell.dateLabel.text = news.publishedAt
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: news.imageUrl ?? "Error") else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                cell.newsImage.image = UIImage(data: imageData)
            }
        }
    }
    
}

extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        configureCell(cell: cell, for: indexPath)
    
        
        return cell
    }
    
    //size cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 390, height: 390)
    }
    
    //distance between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let news = self.articles[indexPath.row]
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TextViewController") as! TextViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        vc.text = news.desc ?? ""
    }
}

