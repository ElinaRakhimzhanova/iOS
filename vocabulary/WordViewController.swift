//
//  WordViewController.swift
//  vocabulary
//
//  Created by Elina on 12/4/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import UIKit
import Firebase

class WordViewController: UIViewController {
    
    var wordObject: Word? = nil

    lazy var wordLabelField: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = NSLineBreakMode.byWordWrapping
        view.sizeToFit()
        return view
    }()

    lazy var definitionLabelField: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        view.lineBreakMode = NSLineBreakMode.byWordWrapping
        view.sizeToFit()
        return view
    }()
    
    
    
    
    private func markup() {
        view.backgroundColor = .white
        [wordLabelField, definitionLabelField].forEach { view.addSubview($0) }
    
        wordLabelField.snp.makeConstraints() {
            $0.top.equalTo(view.snp.bottom).offset(-700)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
    
        definitionLabelField.snp.makeConstraints() {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalTo(view.snp.bottomMargin).offset(-500)
        }
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        wordLabelField.text = wordObject?.word
        definitionLabelField.text = wordObject?.definition
        markup()
    }

}

