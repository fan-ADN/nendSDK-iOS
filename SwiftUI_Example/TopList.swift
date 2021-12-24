//
//  TopList.swift
//  SwiftUI_Example
//
//  Copyright © 2021 FAN Communications. All rights reserved.
//

import SwiftUI

struct TopList: View {
    
    var body: some View {
        NavigationView{
            List{
                NavigationLink(destination:BannerView()){
                    ListRow(title: "Banner")
                }
                NavigationLink(destination:InterstitialView()){
                    ListRow(title: "Interstitial")
                }
                NavigationLink(destination:NativeView()){
                    ListRow(title: "Native")
                }
                NavigationLink(destination:FullBoardView()){
                    ListRow(title: "FullBoard")
                }
                NavigationLink(destination:VideoView()){
                    ListRow(title: "Video")
                }
                NavigationLink(destination:NativeVideoView()){
                    ListRow(title: "NativeVideo")
                }
            }
        }
    }
}

struct TopList_Previews: PreviewProvider {
    static var previews: some View {
        TopList()
    }
}
