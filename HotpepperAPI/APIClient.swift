//
//  APIClient.swift
//  HotpepperAPI
//
//  Created by x22021xx on 2025/01/24.
//

import Foundation

//リクエスト
final class APIClient {
    //シングルトンインスタンス
    static let api = APIClient()
    
    private init() {}
    //GETリクエスト
    func getRequest(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invaild URL", code: 0, userInfo: nil))) //無効
            return
        }
        
        //リクエスト送信タスク
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            //データの有無
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            //成功
            completion(.success(data))
        }
        //タスクの実行
        task.resume()
    }
}
