//
//  AddArticleViewController.swift
//  articleApp
//
//  Created by mp001 on 9/8/18.
//  Copyright © 2018 mp001. All rights reserved.
//

import UIKit

class AddArticleViewController: UIViewController {
    
    var articlePresenter: ArticlePresenter?
    var imagePicker: UIImagePickerController?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.articlePresenter = ArticlePresenter()
         self.articlePresenter?.delegate = self
        
//        imagePicker = UIImagePickerController()
//        imagePicker?.delegate = self
//        imagePicker?.allowsEditing = false
    }
    
    @IBAction func save(_ sender: Any) {
        let article = Article()
        article.title = titleTextField.text
        article.description = descriptionTextView.text
        article.image = "https://res.cloudinary.com/demo/image/upload/v14858684/sample.jpg"
//        self.articlePresenter?.insertArticle(article: article)
        
//        let imageData = UIImagePNGRepresentation(imageView.image!,1)
//        self.articlePresenter?.uploadImage(data: imageData, article: article)
        
//        let imageData = UIImagePNGRepresentation()
    }
    
}

extension AddArticleViewController: ArticlePresenterDelegate{
    func responseArticle(articles: [Article]) {}
    func responseMessage(message: String) {
      
        let alert = UIAlertController(title: message, message: nil, preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension AddArticleViewController: UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
}
