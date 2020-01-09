//
//  CustomSplashVC.swift
//  smartSharjah
//
//  Created by Aqib Bangash on 29/08/2019.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class CustomSplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let jeremyGif = UIImage.gifImageWithName("anim.gif")
        let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: 0.0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.addSubview(imageView)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
