//
//  GourmetResponse.swift
//  HotpepperAPI
//
//  Created by x22021xx on 2025/01/24.
//

import Foundation
//データの定義
struct GourmetResponse: Codable {
    let results: Results
}

struct Results: Codable {
    let shop: [Shop]
}

//必要な情報
struct Shop: Codable {
    let name: String?           //店舗名
    let logo_image: String?     //ロゴ画像
    let address: String?        //住所
    let middle_area: Area?      //中エリア
    let genre: Genre?           //ジャンル
    let budget: Budget?         //予算
    let mobile_access: String?  //携帯用交通アクセス
    let open: String?           //営業時間
    let urls: URLs?             //店舗URL
    let photo: Photo?           //写真
    let lat: Double?            //緯度
    let lng: Double?            //経度
}

//中エリア名
struct Area: Codable {
    let name: String?
}

//ジャンル名
struct Genre: Codable {
    let name: String?
}

//予算の平均
struct Budget: Codable {
    let average: String?
}

//PC向けURL
struct URLs: Codable {
    let pc: String?
}

//携帯向け写真
struct Photo: Codable {
    let mobile: PhotoSizes
}

//トップ写真(大)
struct PhotoSizes: Codable {
    let l: String?
}
