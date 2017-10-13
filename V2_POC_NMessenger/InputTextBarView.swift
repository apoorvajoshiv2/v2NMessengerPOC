//
//  InputTextBarView.swift
//  V2_POC_NMessenger
//
//  Created by apoorva on 13/10/17.
//  Copyright © 2017 apoorva. All rights reserved.
//

import UIKit

class InputTextBarView: UIView {

    @IBOutlet var view: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("InputTextBarView", owner: self, options: nil)
        self.addSubview(view)
    }
    
}
