//
//  ButtonBottomView.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/8/24.
//

import UIKit

final class ButtonBottomView: UIButton {
    init(
        frame: CGRect,
        title: String,
        image: String,
        imagePadding: CGFloat,
        contentInsets: NSDirectionalEdgeInsets
    ) {
        super.init(frame: frame)
        
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.buttonSize = .small
        buttonConfiguration.title = title
        buttonConfiguration.image = UIImage(named: image)?.withTintColor(.accent)
        buttonConfiguration.imagePadding = imagePadding
        buttonConfiguration.contentInsets = contentInsets
        
        self.configuration = buttonConfiguration
        self.tintColor = .white
        self.titleLabel?.minimumScaleFactor = 0.5
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        // this action is necessary to reduce the size of the custom image
        self.imageView?.layer.transform = CATransform3DMakeScale(0.3, 0.3, 0.3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
