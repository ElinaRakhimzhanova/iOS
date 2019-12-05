//
//  ViewController.swift
//  vocabulary
//
//  Created by Elina on 12/2/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController {

    var words: [Word] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WordManager.shared.delegate = self
        markup()
        
    }
        
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.tableFooterView = UIView()
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 300
        //table.snp_bottomMargin
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    private func markup() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints() {
            $0.bottom.equalTo(-20)
            $0.top.equalTo(view.snp.topMargin)
            $0.left.right.equalToSuperview()
        }
    }
    
    //private func saveData(){}
    
    //private func fetchData(){}
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 1
        cell.textLabel?.text = words[indexPath.row].word
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WordViewController()
        vc.wordObject = words[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: WordDelegate {
    func downloadWords(words: [Word]){
        self.words = words
        //self.tableView.reloadData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
