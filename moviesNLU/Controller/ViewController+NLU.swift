//
//  ViewController+NLU.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 12/03/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import Foundation
import NaturalLanguageUnderstanding
import RestKit

extension ViewController {
    
    func analyze(text: String, completionHandler: @escaping (_ emotion: EmotionResult?) -> ()) {
        let nlu = NaturalLanguageUnderstanding(version: "2018-11-16", apiKey: NLUApiKey)
        
        let emotionOptions = EmotionOptions(document: true, targets: nil)
        
        let features = Features(concepts: nil, emotion: emotionOptions, entities: nil, keywords: nil, metadata: nil, relations: nil, semanticRoles: nil, sentiment: nil, categories: nil)
        
        nlu.serviceURL = "https://gateway-wdc.watsonplatform.net/natural-language-understanding/api"
        nlu.analyze(features: features, text: text, html: nil, url: nil, clean: false, xpath: nil, fallbackToRaw: nil, returnAnalyzedText: nil, language: "en", limitTextCharacters: nil, headers: nil) { (response, error) in

            if let response = response, let result = response.result {
                print(response)
                completionHandler(result.emotion)
            } else {
                print("\n\n\n\(error)")
                completionHandler(nil)
            }
        }
        
    }
    
    func emotionScores(of result: EmotionResult?) -> EmotionScores? {
        if let result = result, let document = result.document {
            return document.emotion
        }
        
        return nil
    }
    
    func emotionAverage(_ scores: [EmotionScores]) -> EmotionScores? {
        do {
            let decoder = JSONDecoder()
            var average = try decoder.decode(EmotionScores.self, from: Data("""
            {
                "anger": 0.0,
                "disgust": 0.0,
                "fear": 0.0,
                "joy": 0.0,
                "sadness": 0.0
            }
            """.utf8))
            
            for score in scores {
                average.anger! += score.anger!
                average.disgust! += score.disgust!
                average.fear! += score.fear!
                average.joy! += score.joy!
                average.sadness! += score.sadness!
            }
            
            average.anger = average.anger!/Double(exactly: scores.count)!
            average.disgust = average.disgust!/Double(exactly: scores.count)!
            average.fear = average.fear!/Double(exactly: scores.count)!
            average.joy = average.joy!/Double(exactly: scores.count)!
            average.sadness = average.sadness!/Double(exactly: scores.count)!
            
            return average
            
        } catch {
            print("Error")
        }
        
        return nil
        
    }
}
