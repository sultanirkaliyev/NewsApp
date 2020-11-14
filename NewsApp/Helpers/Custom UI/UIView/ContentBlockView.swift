//
//  ContentBlockView.swift
//  NewsApp
//
//  Created by Sultan on 11/13/20.
//  Copyright © 2020 Sultan Irkaliyev. All rights reserved.
//

import UIKit

class ContentBlockView: UIView {
    
    var headingLabel: UILabelDeviceClass = {
       let label = UILabelDeviceClass()
        label.font = .boldSystemFont(ofSize: 17)
        label.overrideFontSize(fontSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    var contentLabel: UILabelDeviceClass = {
       let label = UILabelDeviceClass()
        label.font = .italicSystemFont(ofSize: 15)
        label.overrideFontSize(fontSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(heading: String, content: String) {
        super.init(frame: .zero)
        self.headingLabel.text = heading
        self.contentLabel.text = content
        setupView()
    }
}

extension ContentBlockView {
    
    private func setupView() {
        
        let headingContainerView = UIView()
        let contentContainerView = UIView()
        
        headingContainerView.addSubview(headingLabel)
        headingLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(15)
        }
    
        contentContainerView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        addSubview(headingContainerView)
        addSubview(contentContainerView)
        
        headingContainerView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        contentContainerView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(headingContainerView.snp.bottom)
        }
        
        self.backgroundColor = #colorLiteral(red: 0.9742808938, green: 0.9744436145, blue: 0.9742594361, alpha: 1)
    }
}
