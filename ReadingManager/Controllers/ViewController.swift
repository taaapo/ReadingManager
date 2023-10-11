//
//  ViewController.swift
//  ReadingManager
//
//  Created by 恵紙拓玖 on 2023/10/11.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    
    let books = [["Zero To One", "★★★★★"],
                 ["平成くん、さようなら", "☆☆★★★"],
                 ["コード・ブレーカー", "☆★★★★"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! BookCell
        
        cell.title.text = books[indexPath.row][0]
        cell.review.text = books[indexPath.row][1]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(books[indexPath.row])
    }

}

