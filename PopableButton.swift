//
//  PopableButton.swift
//  https://github.com/brendanmanning/PopableButton/
//
//  Created by Brendan Manning.
//  Copyright © 2017 BrendanManning. All rights reserved.
//  Released under the MIT License
//

import UIKit

class PopableButton: UIButton {
    
    private let popBoost:CGFloat = 0.2;
    private var initialHeight:CGFloat = -1;
    private var initialWidth:CGFloat = -1;
    private var initialPosition:CGPoint = CGPoint();
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview();
        
        // Backup the initial size
        self.initialHeight = self.frame.size.height;
        self.initialWidth = self.frame.size.width;
        
        // Backup the initial position
        self.initialPosition = self.frame.origin;
        
        // Setup our custom listeners
        self.addTarget(self, action: #selector(pop), for: .touchDown)
        self.addTarget(self, action: #selector(depop), for: .touchUpInside)
        self.addTarget(self, action: #selector(depop), for: .touchUpOutside)
        self.addTarget(self, action: #selector(depop), for: .touchDragOutside)
    }
    
    @objc private func pop(sender: UIButton) {
        // Make the button a little bigger
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.size.height += self.initialHeight * self.popBoost;
            self.frame.size.width += self.initialWidth * self.popBoost;
            
            // Tweak the center position so the change in height & width doesn't mess us up
            // .. Also, allow it to move slightly up. This makes it easier for those of us
            // ... With fat sausage fingers to read the button
            self.frame.origin.y -= 0.75 * (self.frame.size.height - self.initialHeight).abs();
            self.frame.origin.x -= 0.5 * (self.frame.size.width - self.initialWidth).abs();
        });
    }
    
    @objc private func depop(sender: UIButton) {
        // Restore to it's initial size
        UIView.animate(withDuration: 0.15, animations: {
            self.frame.size.height = self.initialHeight;
            self.frame.size.width = self.initialWidth;
            self.frame.origin = self.initialPosition;
        });
    }
}

extension CGFloat {
    internal func abs() -> CGFloat {
        return ((self >= 0) ? self : (-1 * self))
    }
}
