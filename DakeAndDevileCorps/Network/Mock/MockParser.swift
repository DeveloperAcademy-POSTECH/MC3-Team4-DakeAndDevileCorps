//
//  MockParser.swift
//  DakeAndDevileCorps
//
//  Created by SHIN YOON AH on 2022/07/29.
//

import Foundation

final class MockParser {
    static func load<T: Decodable>(type: T.Type, fileName: String) -> T? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            assert(false, "Cannot convert to json file")
            return nil
        }
        
        guard let jsonString = try? String(contentsOfFile: path) else {
            assert(false, "Path is set incorrectly.")
            return nil
        }

        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        if let data = data {
            return try? decoder.decode(T.self, from: data)
        }
        
        return nil
    }
}
