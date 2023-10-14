//
//  ContentViewController.swift
//  ReadingManager
//
//  Created by 恵紙拓玖 on 2023/10/15.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet var bookTitle: UITextView!
    @IBOutlet var bookCategory: UITextView!
    @IBOutlet var bookReview: UITextView!
    @IBOutlet var bookOverview: UITextView!
    @IBOutlet var bookImpression: UITextView!
    @IBOutlet var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewMode()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        
        if sender.currentTitle == "編集" {
            
            editMode()
            
        } else if sender.currentTitle == "保存" {
            
            viewMode()
            
        } else {
            print("error because editButtonPressed's text is not valid.")
        }
    }
    
    func editMode() {
        
        self.bookTitle.isEditable = true
        self.bookCategory.isEditable = true
        self.bookReview.isEditable = true
        self.bookOverview.isEditable = true
        self.bookImpression.isEditable = true
        editButton.setTitle("保存", for: .normal)
        
    }
    
    func viewMode() {
        
        self.bookTitle.isEditable = false
        self.bookCategory.isEditable = false
        self.bookReview.isEditable = false
        self.bookOverview.isEditable = false
        self.bookImpression.isEditable = false
        editButton.setTitle("編集", for: .normal)
        
    }

}
