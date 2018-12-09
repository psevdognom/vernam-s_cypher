//
//  CatsViewController.swift
//  Vernam's_cypher
//
//  Created by Константин on 09/12/2018.
//  Copyright © 2018 Konstantin Samsonov. All rights reserved.
//

import UIKit

class CatsViewController: UINavigationController {

    @IBOutlet weak var MailScrollView: UIScrollView!
    
    var imageArray = [UIImage?]()
    override func viewDidLoad() {
        super.viewDidLoad()
    //    MailScrollView.frame = view.frame
        imageArray = [#imageLiteral(resourceName: "коты в снегу.jpg")]
        for i in 0..<imageArray.count {
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            imageView.contentMode =  .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.MailScrollView.frame.width, height: self.MailScrollView.frame.height)
            MailScrollView.contentSize.width = MailScrollView.frame.width * CGFloat(i + 1)
            MailScrollView.addSubview(imageView)
        }

    }
    

}
