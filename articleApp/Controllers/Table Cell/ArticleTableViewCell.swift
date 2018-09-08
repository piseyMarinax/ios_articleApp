//
//  ArticleTableViewCell.swift
//  articleApp
//
//  Created by mp001 on 9/7/18.
//  Copyright © 2018 mp001. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var articleTitleLabel: UILabel!
  
    @IBOutlet weak var articleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configerCell(article: Article) {
        self.articleTitleLabel.text = article.title
        if let image = article.image{
            let url = URL(string: image)
            articleImageView.kf.setImage(with: url)
        }
       
    }

}
