//
//  JSONDecodeProtocol.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/08.
//

import Foundation

struct JSONDecodeProtocol: JSONDecodable {
    func decodeJSON<Value>(type: Value.Type, data: Data) throws -> Value where Value : Decodable {
        
        let decoder = JSONDecoder()
        
        guard let decodedData: Value = try? decoder.decode(type, from: data) else {
            throw DecodeError.failedDecode
        }
        
        return decodedData
    }
}
