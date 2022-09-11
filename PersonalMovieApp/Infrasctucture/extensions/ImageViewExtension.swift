//
//  ImageViewExtension.swift
//  PersonalMovieApp
//
//  Created by APPLE on 01.09.22.
//

import Foundation
import UIKit

extension UIImageView {
    
    public func imageFromWeb(urlString : String, placeHolderImage : UIImage = UIImage(named: "placeholder.png")!) {

            self.image = placeHolderImage
        var url = NSURL(string: urlString)
        if url == nil {
        return
        }
        URLSession.shared.dataTask(with: url as! URL, completionHandler: { (data,_,error ) -> Void in
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: {() -> Void in
                let image = UIImage(data : data!)
                self.image = image
            })
            
        }).resume()
    }
}

