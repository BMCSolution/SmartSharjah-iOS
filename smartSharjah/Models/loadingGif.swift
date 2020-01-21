//
//  loadingGif.swift
//  smartSharjah
//
//  Created by OzzY on 8/18/19.
//  Copyright © 2019 DEG. All rights reserved.
//

import UIKit

class loadingGif: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGif()
    }
    func loadGif()
    {
        /************************ Load GIF image Using Name ********************/
        
        /*let jeremyGif = UIImage.gifImageWithName("anim")
        
        let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: 0, y: 5, width: self.view.frame.size.width, height: self.view.frame.size.height)
        view.addSubview(imageView)*/
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
            // your code here
            //segue.destination as? ViewController
            //performSegue(withIdentifier: "languageSelStory", sender: Any?.self)
            //console.log("Hello")
            self.performSegue(withIdentifier: "languageSel", sender: self)
            //let vc = ViewController() //your view controller
            //self.present(vc, animated: true, completion: nil)
            //self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
