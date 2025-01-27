//
//  HomeViewModel.swift
//  HotpepperAPI
//
//  Created by x22021xx on 2025/01/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var searchResults: [ViewModel] = []  //検索結果のリスト
    @Published var errorMessage: String = ""        //エラーメッセージ
    @Published var isLoading: Bool = false          //ロード
    
    //APIリクエスト
    private var gourmetSearch = GourmetSearch()
    
    func searchGourmet(with encodedKeyword: String, lat: Double, lng: Double, range: Int) {
        //検索開始
        isLoading = true
        //リクエストを送信
        gourmetSearch.searchGourmet(keyword: encodedKeyword, lat: lat, lng: lng, range: range) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                //成功
                case .success(let results):
                    self?.searchResults = results.shop.map {
                        ViewModel(with: $0) }
                //失敗
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
