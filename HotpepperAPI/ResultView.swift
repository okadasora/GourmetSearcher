//
//  ResultView.swift
//  HotpepperAPI
//
//  Created by x22021xx on 2025/01/24.
//

import SwiftUI

struct ResultView: View {
    //店舗情報
    let viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            //詳細画面への遷移
            NavigationLink {
                DetailView(viewModel: viewModel)
            } label: {
                VStack(alignment: .leading, spacing: 15) {
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
                            .font(.system(size: 23))
                    }
                    //ジャンルを表示
                    HStack {
                        Text("ジャンル")
                            .bold()
                            .padding(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.orange, lineWidth: 2)
                            )
                        Text(viewModel.genreLabel)
                    }
                    //アクセスを表示
                    HStack {
                        Text("アクセス")
                            .bold()
                            .padding(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.orange, lineWidth: 2)
                            )
                        Text(viewModel.accessLabel)
                    }
                    //写真を表示
                    if let imageData = viewModel.imageData, let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 180)
                    }
                }
                .font(.system(size: 18))
            }
        }
    }
}

#Preview {
    let sample = Shop(name: "店名", logo_image: "ロゴ", address: "住所", middle_area: Area(name: "エリア"), genre: Genre(name: "ジャンル"), budget: Budget(average: "値段"), mobile_access: "アクセス", open: "営業時間", urls: URLs(pc: "URL"), photo: Photo(mobile: PhotoSizes(l: "写真")), lat: 0.0, lng: 0.0)
    
    let sampleViewModel = ViewModel(with: sample)
    
    ResultView(viewModel: sampleViewModel)
}
