//
//  BookCell.swift
//  ReadingManager
//
//  Created by 恵紙拓玖 on 2023/10/11.
//

import UIKit

class BookCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var review: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
