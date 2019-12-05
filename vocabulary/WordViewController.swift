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
    
    lazy var wordImage: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return view
    }()
    
    
    private func markup() {
        view.backgroundColor = .white
        [wordLabelField, definitionLabelField, wordImage].forEach { view.addSubview($0) }
    
        wordLabelField.snp.makeConstraints() {
            $0.top.equalTo(view.snp.bottom).offset(-700)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
    
        definitionLabelField.snp.makeConstraints() {
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.bottom.equalTo(view.snp.bottomMargin).offset(-550)
        }
        
        wordImage.snp.makeConstraints() {
            $0.top.equalTo(view.snp.bottom).offset(-530)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        wordLabelField.text = wordObject?.word
        definitionLabelField.text = wordObject?.definition
        let urlString = wordObject?.image
        showImage(urlString: urlString!)
        wordImage.loadImage(urlString: urlString!)
        markup()
    }
    
    func showImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
    
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Couldn't download image: ", error)
                return
            }
        
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            self.wordImage.image = image
        
        }.resume()
        
    }

}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) { contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIImageView {
    func loadImage(urlString: String) {
        if let cacheImage = ImageCacher.shared.imageCache.object(forKey: (urlString as AnyObject) as! NSString) {
            self.image = cacheImage
            return
        }
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Couldn't download image: ", error)
                return
            }
            guard let data = data else { return }
            let image = UIImage(data: data)
            ImageCacher.shared.imageCache.setObject(image!, forKey: (urlString as AnyObject) as! NSString)
            DispatchQueue.main.async {
                self.image = image
            }
            if let cacheImage = ImageCacher.shared.imageCache.object(forKey: urlString as AnyObject) as? UIImage {
                
                UIImageWriteToSavedPhotosAlbum(cacheImage, nil, nil, nil)
            }
        }.resume()
    }
}
