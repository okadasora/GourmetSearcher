//
//  DetailView.swift
//  HotpepperAPI
//
//  Created by x22021xx on 2025/01/26.
//

import SwiftUI

struct DetailView: View {
    //店舗情報
    let viewModel: ViewModel
    
    var body: some View {
        HStack {
            //ロゴ画像を表示
            if let logoData = viewModel.logoData, let logo = UIImage(data: logoData) {
                Image(uiImage: logo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
            }
            //店舗名を表示
            Text(viewModel.nameLabel)
                .font(.system(size: 27))
        }
        //リスト表示
        List {
            //写真を表示
            if let imageData = viewModel.imageData, let image = UIImage(data: imageData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            //住所を表示
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.orange) // 背景色を設定
                    Text("住所")
                        .padding(5)
                        .foregroundStyle(.white)
                }
                .frame(width: 100) // サイズを設定
                Text(viewModel.addressLabel)
            }
            //営業時間を表示
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.orange) // 背景色を設定
                    Text("営業時間")
                        .padding(5)
                        .foregroundStyle(.white)
                }
                .frame(width: 100) // サイズを設定
                Text(viewModel.openLabel)
            }
            //予算を表示
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.orange) // 背景色を設定
                    Text("予算")
                        .padding(5)
                        .foregroundStyle(.white)
                }
                .frame(width: 100) // サイズを設定
                Text(viewModel.budgetLabel)
            }
            //ジャンルを表示
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.orange) // 背景色を設定
                    Text("ジャンル")
                        .padding(5)
                        .foregroundStyle(.white)
                }
                .frame(width: 100) // サイズを設定
                Text(viewModel.genreLabel)
            }
            //エリアを表示
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.orange) // 背景色を設定
                    Text("エリア")
                        .padding(5)
                        .foregroundStyle(.white)
                }
                .frame(width: 100) // サイズを設定
                Text(viewModel.areaLabel)
            }
            //アクセスを表示
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.orange) // 背景色を設定
                    Text("アクセス")
                        .padding(5)
                        .foregroundStyle(.white)
                }
                .frame(width: 100) // サイズを設定
                Text(viewModel.accessLabel)
            }
        }
        .font(.system(size: 20))
        
        //予約ページに移動
        Button(action: {
            if let url = URL(string: viewModel.displayText.string) {
                UIApplication.shared.open(url, options: [.universalLinksOnly: false], completionHandler: { completed in
                    print(completed)
                })
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.blue) // 背景色を設定
                Text("予約する")
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
            }
            .frame(width: 120, height: 60) // サイズを設定
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

#Preview {
    let sample = Shop(name: "店名", logo_image: "ロゴ", address: "住所", middle_area: Area(name: "エリア"), genre: Genre(name: "ジャンル"), budget: Budget(average: "値段"), mobile_access: "アクセス", open: "営業時間", urls: URLs(pc: "URL"), photo: Photo(mobile: PhotoSizes(l: "写真")), lat: 0.0, lng: 0.0)
    
    let sampleViewModel = ViewModel(with: sample)
    
    DetailView(viewModel: sampleViewModel)
}
