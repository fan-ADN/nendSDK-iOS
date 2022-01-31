//
//  VideoView.swift
//  SwiftUI_Example
//
//  Copyright © 2021 FAN Communications. All rights reserved.
//

import SwiftUI
import NendAd

struct VideoView: View {
    var body: some View {
        VStack {
            RewardedVideo()
            Divider()
            InterstitialVideo()
        }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
