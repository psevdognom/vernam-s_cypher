//
//  CypherViewController.swift
//  Vernam's_cypher
//
//  Created by Константин on 02/12/2018.
//  Copyright © 2018 Konstantin Samsonov. All rights reserved.
//

import UIKit

class CypherViewController: UIViewController {

    
    @IBOutlet weak var textView: UITextView!
    var text: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = text
    }
}
