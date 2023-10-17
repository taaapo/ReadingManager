//
//  ContentViewController.swift
//  ReadingManager
//
//  Created by 恵紙拓玖 on 2023/10/15.
//

import UIKit
import RealmSwift

class ContentViewController: UIViewController {
    
    @IBOutlet var bookTitle: UITextView!
    @IBOutlet var bookCategory: UITextView!
    @IBOutlet var bookReview: UITextView!
    @IBOutlet var bookDate: UIDatePicker!
    @IBOutlet var bookDateView: UITextView!
    @IBOutlet var bookOverview: UITextView!
    @IBOutlet var bookImpression: UITextView!
    
    @IBOutlet var editButton: UIButton!
    
    let realm = try! Realm()
    var selectedBook: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadContent(book: selectedBook)
        viewMode()
    }
    
    //MARK: - edit and save
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        
        if sender.currentTitle == "編集" {
            
            editMode()
            
        } else if sender.currentTitle == "保存" {
            
            if let book = selectedBook {
                do {
                    try realm.write({
                        book.title = self.bookTitle.text
                        book.category = self.bookCategory.text
                        book.review = self.bookReview.text
                        book.date = self.bookDate.date
                        book.dateView = self.bookDateView.text
                        book.overview = self.bookOverview.text
                        book.impression = self.bookImpression.text
                    })
                } catch {
                    print("Error saving content, \(error)")
                }
            }
            
            viewMode()
            
        } else {
            print("error because editButtonPressed's text is not valid.")
        }
    }
    
    func editMode() {
        
        self.bookTitle.isEditable = true
        self.bookCategory.isEditable = true
        self.bookReview.isEditable = true
        self.bookDate.isHidden = false
        self.bookDateView.isHidden = true
        self.bookOverview.isEditable = true
        self.bookImpression.isEditable = true
        editButton.setTitle("保存", for: .normal)
        
    }
    
    func viewMode() {
        
        self.bookTitle.isEditable = false
        self.bookCategory.isEditable = false
        self.bookReview.isEditable = false
        self.bookDate.isHidden = true
        self.bookDateView.isHidden = false
        self.bookDateView.isEditable = false
        
        //bookDateViewに日付を入力
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY年 M月 d日"
        self.bookDateView.text = dateformatter.string(from: (self.selectedBook?.date)!)
        
        self.bookOverview.isEditable = false
        self.bookImpression.isEditable = false
        editButton.setTitle("編集", for: .normal)
        
    }
    
    //MARK: - Data Manipulation Methods
    
    func loadContent(book: Book?){
        
        self.bookTitle.text = book?.title
        self.bookCategory.text = book?.category
        self.bookReview.text = book?.review
        self.bookDate.date = (book?.date)!
        self.bookDateView.text = book?.dateView
        self.bookOverview.text = book?.overview
        self.bookImpression.text = book?.impression

    }


}
