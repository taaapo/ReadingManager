//
//  ContentViewController.swift
//  ReadingManager
//
//  Created by 恵紙拓玖 on 2023/10/15.
//

import UIKit
import RealmSwift
import SwiftUI

class ContentViewController: UIViewController {
    
    @IBOutlet var bookTitle: UITextView!
    @IBOutlet var bookCategory: UITextView!
    @IBOutlet var bookReview: UITextView!
    @IBOutlet var bookRevienButton: UIButton!
    @IBOutlet var bookDate: UIDatePicker!
    @IBOutlet var bookDateView: UITextView!
    @IBOutlet var bookOverview: UITextView!
    @IBOutlet var bookImpression: UITextView!
    
    @IBOutlet var editButton: UIButton!
    
    @IBOutlet var background: UIView!
    
    
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
    
    //MARK: - Review Function
    
    @IBAction func reviewButtonPressed(_ sender: UIButton) {
        if editButton.titleLabel?.text == "保存" {
            switch sender.titleLabel?.text {
            case "1":
                self.bookReview.text = "★☆☆☆☆"
            case "2":
                self.bookReview.text = "★★☆☆☆"
            case "3":
                self.bookReview.text = "★★★☆☆"
            case "4":
                self.bookReview.text = "★★★★☆"
            case "5":
                self.bookReview.text = "★★★★★"
            default:
                self.bookReview.text = "★★★★★"
        }
        }
    }
    
    //MARK: - EditMode and ViewMode
    
    func editMode() {
        
        self.bookTitle.isEditable = true
        self.bookCategory.isEditable = true
        self.bookReview.isEditable = true
        self.bookDate.isHidden = false
        self.bookDateView.isHidden = true
        self.bookOverview.isEditable = true
        self.bookImpression.isEditable = true
        editButton.setTitle("保存", for: .normal)
        
        editColor()
        
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
        
        viewColor()
        
    }
    
    func viewColor() {
        
        self.background.backgroundColor = UIColor.white
        self.bookTitle.backgroundColor = UIColor.white
        self.bookCategory.backgroundColor = UIColor.white
        self.bookReview.backgroundColor = UIColor.white
        self.bookDateView.backgroundColor = UIColor.white
        self.bookOverview.backgroundColor = UIColor.white
        self.bookImpression.backgroundColor = UIColor.white
        
        self.bookTitle.layer.borderWidth = 0.0
        self.bookCategory.layer.borderWidth = 0.0
        self.bookOverview.layer.borderWidth = 0.0
        self.bookImpression.layer.borderWidth = 0.0
        
        self.bookTitle.textColor = UIColor.black
        self.bookCategory.textColor = UIColor.black
        self.bookReview.textColor = UIColor.black
        self.bookDateView.textColor = UIColor.black
        self.bookOverview.textColor = UIColor.black
        self.bookImpression.textColor = UIColor.black
        
    }
    
    func editColor() {
        
        self.background.backgroundColor = UIColor.white
        
        self.bookTitle.layer.borderColor = UIColor.systemBlue.cgColor
        self.bookCategory.layer.borderColor = UIColor.systemBlue.cgColor
        self.bookOverview.layer.borderColor = UIColor.systemBlue.cgColor
        self.bookImpression.layer.borderColor = UIColor.systemBlue.cgColor
        
        self.bookTitle.layer.borderWidth = 1.0
        self.bookCategory.layer.borderWidth = 1.0
        self.bookOverview.layer.borderWidth = 1.0
        self.bookImpression.layer.borderWidth = 1.0
        
        self.bookTitle.layer.cornerRadius = 5.0
        self.bookTitle.layer.masksToBounds = true
        self.bookCategory.layer.cornerRadius = 5.0
        self.bookCategory.layer.masksToBounds = true
        self.bookOverview.layer.cornerRadius = 5.0
        self.bookOverview.layer.masksToBounds = true
        self.bookImpression.layer.cornerRadius = 5.0
        self.bookImpression.layer.masksToBounds = true
        
        self.bookTitle.textColor = UIColor.systemBlue
        self.bookCategory.textColor = UIColor.systemBlue
        self.bookReview.textColor = UIColor.systemBlue
        self.bookOverview.textColor = UIColor.systemBlue
        self.bookImpression.textColor = UIColor.systemBlue
        
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
