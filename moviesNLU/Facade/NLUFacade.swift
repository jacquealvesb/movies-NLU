//
//  NLUFacade.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 26/08/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import Foundation
import NaturalLanguageUnderstanding

class NLUFacade {
    // MARK: - Variables
    public static let shared = NLUFacade()
    let apiKey = NLUApiKey
    
    // MARK: - Functions
    
    
    /// Analyzes a text returning the emotion result
    ///
    /// - Parameters:
    ///   - text: Text to be analized
    ///   - completionHandler: Handler of the emotion result from the analyzed text
    func analyze(text: String, completionHandler: @escaping (_ emotion: EmotionResult?) -> ()) {
        let nlu = NaturalLanguageUnderstanding(version: "2018-11-16", apiKey: apiKey)
        let emotionOptions = EmotionOptions(document: true, targets: nil)
        let features = Features(concepts: nil, emotion: emotionOptions, entities: nil, keywords: nil, metadata: nil, relations: nil, semanticRoles: nil, sentiment: nil, categories: nil)
        
        nlu.serviceURL = "https://gateway-wdc.watsonplatform.net/natural-language-understanding/api"
        nlu.analyze(features: features, text: text, html: nil, url: nil, clean: false, xpath: nil, fallbackToRaw: nil, returnAnalyzedText: nil, language: "en", limitTextCharacters: nil, headers: nil) { (response, error) in
            
            if let response = response, let result = response.result {
                print(response)
                completionHandler(result.emotion)
            } else {
                print(error ?? "")
                completionHandler(nil)
            }
        }
    }
    
    /// Returns the emotion scores from the emotion result
    ///
    /// - Parameter result: Emotion result from analyzed text
    /// - Returns: Scores from emotion result
    func emotionScores(of result: EmotionResult?) -> EmotionScores? {
        if let result = result, let document = result.document {
            return document.emotion
        }
        
        return nil
    }
    
    
    /// Makes the average score from a list of emotion scores
    ///
    /// - Parameter scores: List of emotion scores
    /// - Returns: An object with the average score for each emotion
    func emotionAverage(_ scores: [EmotionScores]) -> EmotionScores? {
        do {
            let scoreCount = Double(scores.count)
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
            
            // Sums all scores
            for score in scores {
                average.anger! += score.anger!
                average.disgust! += score.disgust!
                average.fear! += score.fear!
                average.joy! += score.joy!
                average.sadness! += score.sadness!
            }
            
            // Divides  by the number of scores
            average.anger = average.anger!/scoreCount
            average.disgust = average.disgust!/scoreCount
            average.fear = average.fear!/scoreCount
            average.joy = average.joy!/scoreCount
            average.sadness = average.sadness!/scoreCount
            
            return average
            
        } catch {
            print("Error")
        }
        
        return nil
        
    }
}
