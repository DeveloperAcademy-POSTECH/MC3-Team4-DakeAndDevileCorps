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
        let fileURL = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: fileURL) else {
            assert(false, "Path is set incorrectly.")
            return nil
        }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            assert(false, "Json serialization is not possible.")
            return nil
        }
        guard let decodable = try? JSONSerialization.data(withJSONObject: jsonObject) else { return nil }
        return try? JSONDecoder().decode(T.self, from: decodable)
    }
}
