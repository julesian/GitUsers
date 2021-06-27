//
//  JSONModelHelper.swift
//  GitUsers
//
//  Created by Jules Gilos on 6/27/21.
//

import Foundation

class JSONModelHelper {
    class func parse<T: Decodable>(json: Any, decodable: T.Type) -> Any? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            let jsonString = String(data: jsonData, encoding: .utf8)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            let jsonConvertedData = jsonString?.data(using: .utf8)
            let object = try jsonDecoder.decode(decodable, from: jsonConvertedData!)
            return object
        } catch let DecodingError.keyNotFound(_, context){
            print(context)
        } catch let DecodingError.dataCorrupted(context){
            print(context)
        } catch let DecodingError.valueNotFound(_, context){
            print(context)
        } catch let DecodingError.typeMismatch(_, context){
            print(context)
        } catch {
            print("JSON Decoder Error")
        }
        
        return nil;
    }
}
