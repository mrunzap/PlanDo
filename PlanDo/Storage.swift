//
//  Storage.swift
//  storeJSON
//
//  Created by joonwon lee on 2020/03/17.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public class Storage {
    let repository: String = "planDo.json"
    private init() { }
    
    // TODO: directory 설명
    // TODO: FileManager 설명 
    enum Directory {
        case documents
        case caches
        
        var url: URL {
            let path: FileManager.SearchPathDirectory
            switch self {
            case .documents:
                path = .documentDirectory
            case .caches:
                path = .cachesDirectory
            }
            return FileManager.default.urls(for: path, in: .userDomainMask).first!
        }
    }
    
    // TODO: Codable 설명, JSON 타입 설명
    // TODO: Codable encode 설명
    // TODO: Data 타입은 파일 형태로 저장 가능
    
    static func store<T: Encodable>(_ obj: T, to directory: Directory, as fileName: String) {
        let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
        print("---> save to here: \(url)")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(obj)
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        } catch let error {
            print("---> Failed to store msg: \(error.localizedDescription)")
        }
    }
    
    // TODO: 파일은 Data 타입형태로 읽을수 있음
    // TODO: Data 타입은 Codable decode 가능
    
    static func retrive<T: Decodable>(_ fileName: String, from directory: Directory,as type: T.Type) -> Single<Result<T, FetchNetworkError>>  {
            return   Observable.from(["planDo.json"])
                        .map{result in
                            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                            let urlFile = url.appendingPathComponent(fileName, isDirectory: false)
                            print(urlFile)
                            guard FileManager.default.fileExists(atPath: urlFile.path) else { return .failure(.invalidJSON) }
                            
                            guard let planDo = FileManager.default.contents(atPath: urlFile.path) else {return .failure(.invalidURL)}
                            
                            print("planDo:::::::::::\(planDo)")
                            do {
                                let planDoData = try JSONDecoder().decode(type, from: planDo )
                                
                                return .success(planDoData)
                            } catch {
                                return .failure(.invalidJSON)
                            }
                        }
                        .asSingle()

    }
    
    static func remove(_ fileName: String, from directory: Directory) {
        let url = directory.url.appendingPathComponent(fileName, isDirectory: false)
        guard FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            try FileManager.default.removeItem(at: url)
        } catch let error {
            print("---> Failed to remove msg: \(error.localizedDescription)")
        }
    }
    
    static func clear(_ directory: Directory) {
        let url = directory.url
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
            for content in contents {
                try FileManager.default.removeItem(at: content)
            }
        } catch {
            print("---> Failed to clear directory ms: \(error.localizedDescription)")
        }
    }
}
