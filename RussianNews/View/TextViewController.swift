//
//  TextViewController.swift
//  RussianNews
//
//  Created by Яблочко on 21.11.2020.
//  Copyright © 2020 Roman Avdonin. All rights reserved.
//

import UIKit

class TextViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var text = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = text
    }
}
