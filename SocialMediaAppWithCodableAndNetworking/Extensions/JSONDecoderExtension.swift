//
//  JSONDecoderExtension.swift
//  SocialMediaAppWithCodableAndNetworking
//
//  Created by Nikolas Aggelidis on 29/11/20.
//  Copyright © 2020 NAPPS. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, from urlString: String, completion: @escaping(T) -> Void) {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL passed.")
        }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                let downloadedData = try jsonDecoder.decode(type, from: data)
                
                DispatchQueue.main.async {
                    completion(downloadedData)
                }
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
