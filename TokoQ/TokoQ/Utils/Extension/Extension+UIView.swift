//
//  Extension+UIView.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 26/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    
    public func constrainEdges(to parent: UIView) {
        if superview == nil { parent.addSubview(self) }
        self.snp.makeConstraints { (make) in
            make.top.equalTo(parent)
            make.left.equalTo(parent)
            make.bottom.equalTo(parent)
            make.right.equalTo(parent)
        }
    }
}
