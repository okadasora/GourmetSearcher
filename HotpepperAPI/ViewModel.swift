//
//  ViewModel.swift
//  HotpepperAPI
//
//  Created by x22021xx on 2025/01/26.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var nameLabel: String                //店舗名
    @Published var addressLabel: String             //住所
    @Published var areaLabel: String                //エリア
    @Published var genreLabel: String               //ジャンル
    @Published var budgetLabel: String              //予算
    @Published var accessLabel: String              //アクセス
    @Published var openLabel: String                //営業時間
    @Published var latLabel: Double                 //緯度
    @Published var lngLabel: Double                 //経度
    @Published var displayText: NSAttributedString  //店舗URL
    @Published var logoData: Data?                  //ロゴ
    @Published var imageData: Data?                 //写真
    
    init(with data: Shop) {
        //取得したデータを格納
        self.nameLabel = data.name ?? "店舗名不明"
        self.addressLabel = data.address ?? "住所不明"
        self.areaLabel = data.middle_area?.name ?? "エリア不明"
        self.genreLabel = data.genre?.name ?? "ジャンル不明"
        self.budgetLabel = data.budget?.average ?? "予算不明"
        self.accessLabel = data.mobile_access ?? "アクセス不明"
        self.openLabel = data.open ?? "営業時間不明"
        self.latLabel = data.lat ?? 0.0
        self.lngLabel = data.lng ?? 0.0
        
        if let urlString = data.urls?.pc {
            let displayText = urlString
            //リンク付きテキスト作成
            let attributedString = NSMutableAttributedString(string: displayText)
            if let linkRange = displayText.range(of: urlString) {
                let nsRange = NSRange(linkRange, in: displayText)
                attributedString.addAttribute(.link, value: urlString, range: nsRange)
            }
            self.displayText = attributedString
        } else {
            self.displayText = NSAttributedString(string: "URLなし")
        }
        //ロゴ画像のダウンロード
        if let logoUrl = data.logo_image, let logo = URL(string: logoUrl) {
            loadLogoData(from: logo)
        } else {
            self.logoData = nil
        }
        //写真のダウンロード
        if let imageUrl = data.photo?.mobile.l, let image = URL(string: imageUrl) {
            loadImageData(from: image)
        } else {
            self.imageData = nil
        }
    }
    
    private func loadLogoData(from url: URL) {
        DispatchQueue.global().async {
            if let logodata = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.logoData = logodata
                }
            }
        }
    }
    
    private func loadImageData(from url: URL) {
        DispatchQueue.global().async {
            if let imagedata = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.imageData = imagedata
                }
            }
        }
    }
}
