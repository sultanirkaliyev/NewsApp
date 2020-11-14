//
//  ArticleTableViewCell.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabelDeviceClass!
    @IBOutlet weak var articlePublishedAtLabel: UILabelDeviceClass!
    
    //MARK: - Properties
    static let reuseID = "ArticleTableViewCell"
    
    //MARK: - IndexPath
    private var indexPath: IndexPath!
    
    //MARK: - ViewModel
    weak var viewModel: ArticleTableViewCellViewModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            indexPath = viewModel.indexPath
            
            if let articleImage = viewModel.articleImage, let url = URL(string: articleImage) {
                articleImageView.setIndicatorStyle(.gray)
                articleImageView.setShowActivityIndicator(true)
                articleImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "image_not_found_placeholder"))
            } else {
                articleImageView.image = UIImage(named: "image_not_found_placeholder")
            }
            
            articleTitleLabel.text = viewModel.articleTitle
            articlePublishedAtLabel.text = viewModel.articlePublishedAt
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }    
}

extension ArticleTableViewCell {
    
    func setupUI() {
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.layer.cornerRadius = 5
    }
}
