//
//  ExtensionUIImage.swift
//  TicketBooking
//
//  Created by Kirill on 08.01.2024.
//

import UIKit

public extension UIImageView {
    
    // MARK: updateHeight
    // Устанавилвает высоту объекта UIImageView равной высоте его внутреннего UIImage
    func updateHeight() -> Void {
        
        for constraint in self.constraints {
            if constraint.firstAttribute == .height {
                constraint.isActive = false
            }
        }
        
        guard let image else {
            return
        }
        
        let imageHeight = image.size.height
        let imageWidth = image.size.width
        
        guard (imageHeight > 0) && (imageWidth > 0) else {
            return
        }
        
        let imageAspectRatio = imageHeight / imageWidth
        
        self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: imageAspectRatio).isActive = true
        
    }
    
}
