//
//  Extension + UIImage.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/9/24.
//

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
