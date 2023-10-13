//
//  JSONDecodable.swift
//  GithubFollower
//
//  Created by Minseong Kang on 2023/10/08.
//
import Foundation

protocol JSONDecodable {
    func decodeJSON<Value>(type: Value.Type, data: Data) throws -> Value where Value : Decodable
}
