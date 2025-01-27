//
//  GourmetSearch.swift
//  HotpepperAPI
//
//  Created by x22021xx on 2025/01/24.
//

import Foundation

//APIのリクエスト
final class GourmetSearch {
    //APIキー
    private let key = "379b38a55a1b7b42"
    
    //グルメを検索
    func searchGourmet(keyword: String, lat: Double, lng: Double, range: Int, completion: @escaping (Result<Results, Error>) -> Void) {
        //キーワードをURLエンコード
        guard let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(NSError(domain: "Invalid keyword", code: -1, userInfo: nil)))
            return
        }
        //検索URL
        let path = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=\(key)&keyword=\(encodedKeyword)&lat=\(lat)&lng=\(lng)&range=\(range)&format=json"
        
        guard let url = URL(string: path) else {
            completion(.failure(NSError(domain: "Invaild URL", code: -1, userInfo: nil))) //無効
            return
        }
        
        //GETリクエスト
        APIClient.api.getRequest(urlString: url.absoluteString) { result in
            switch result {
            case .success(let data):
                //デコード処理
                do {
                    //デコード成功
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(GourmetResponse.self, from: data)
                    completion(.success(response.results))
                } catch {
                    //デコード失敗
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
