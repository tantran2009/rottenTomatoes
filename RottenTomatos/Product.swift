//
//  File.swift
//  RottenTomatos
//
//  Created by Taku Tran on 5/18/17.
//  Copyright © 2017 Taku Tran. All rights reserved.
//

import Foundation
import UIKit

class Movie {
    var name:String
    var description: String
    var imageURL: String
    var maapRating: String
    var score: Int
    var runtime: Int
    
    init(name: String, description: String, imageName: String, maapRating: String, score: Int, runtime: Int ){
        self.name = name
        self.description = description
        self.maapRating = maapRating
        self.score = score
        self.runtime = runtime
        self.imageURL = imageName
        /*if let img = UIImage(named: imageName) {
            image = img
        } else {
            image = UIImage(named: "default")!
        }*/
    }
}
