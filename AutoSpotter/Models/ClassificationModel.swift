//
//  ClassificationModel.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-01.
//

import Foundation
import CoreML
import Vision

class ClassificationModel {
    let model: CarRecognition = {
    do {
        let config = MLModelConfiguration()
        return try CarRecognition(configuration: config)
    } catch {
        print(error)
        fatalError("Couldn't create CarRecognition")
    }
    }()
    
    
}

