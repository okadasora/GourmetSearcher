//
//  ContentView.swift
//  HotpepperAPI
//
//  Created by x22021xx on 2025/01/24.
//

import SwiftUI
import MapKit //マップ表示

struct ContentView: View {
    //現在地の取得
    @StateObject var manager = LocationManager()
    //ContentViewModel のインスタンス
    @StateObject private var viewModel = ContentViewModel()
    //Pickerタグの初期値
    @State private var selectionDistance: Int = 1
    //現在地からの範囲
    @State private var range: Int = 300
    //検索ワード
    @State private var searchText: String = ""
    //画面遷移の管理
    @State private var isNext = false
    
    var body: some View {
        NavigationStack {
            //現在地の緯度
            let latitude = $manager.location.wrappedValue.coordinate.latitude
            //現在地の経度
            let longitude = $manager.location.wrappedValue.coordinate.longitude
            
            Form {
                //キーワード検索
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.blue)
                    TextField("検索キーワードを入力", text: $searchText)
                        .padding(8)
                }
                
                //範囲を指定
                Picker("現在地からの距離", selection: $selectionDistance) {
                    Text("300m").tag(1).font(.system(size: 20))
                    Text("500m").tag(2)
                    Text("1000m").tag(3)
                    Text("2000m").tag(4)
                    Text("3000m").tag(5)
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectionDistance) {
                    //範囲の更新
                    updateRange(for: selectionDistance)
                }
                
                ZStack(alignment: .topLeading) {
                    //Map表示
                    Map(interactionModes: .all) {
                        UserAnnotation(anchor: .center) { location in
                            //現在地を描画
                            Circle()
                                .foregroundStyle(.blue)
                                .padding(2)
                                .background(
                                    Circle()
                                        .fill(.white)
                                )
                        }
                        //検索範囲を描画
                        MapCircle(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), radius: CLLocationDistance(range))
                            .foregroundStyle(.red.opacity(0.6))
                    }
                    .frame(height: 450)
                    //現在地に戻る
                    .mapControls {
                        MapUserLocationButton()
                    }
                    .onAppear {
                        manager.requestLocation()
                    }
                    
                    Text("🔴店舗の範囲: \(range)m")
                        .padding()
                }
            }
            
            //検索ボタン
            Button("検索") {
                viewModel.searchGourmet(with: searchText, lat: latitude, lng: longitude, range: selectionDistance)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    // データがロードされるまで少し待つ
                    isNext = true
                }
            }
            .font(.system(size: 25))
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            .buttonStyle(.borderedProminent)
            .navigationDestination(isPresented: $isNext) {
                //検索結果が0件の時
                if $viewModel.searchResults.isEmpty {
                    Text("検索結果が見つかりませんでした")
                        .font(.system(size: 35))
                // 検索結果がある場合
                } else {
                    //リスト表示
                    List(viewModel.searchResults, id: \.nameLabel) { resultViewModel in
                        ResultView(viewModel: resultViewModel)
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("近くの店舗一覧")
                }
            }
            .navigationBarTitle("グルメ検索")
        }
        .font(.system(size: 20))
    }
    //検索範囲
    private func updateRange(for selection: Int) {
        switch selection {
        case 1: range = 300
        case 2: range = 500
        case 3: range = 1000
        case 4: range = 2000
        case 5: range = 3000
        default: range = 300
        }
    }
}

#Preview {
    ContentView()
}
