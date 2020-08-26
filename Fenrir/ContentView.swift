//
//  ContentView.swift
//  Fenrir
//
//  Created by CooperHsu on 2020/8/26.
//  Copyright © 2020 CooperHsu. All rights reserved.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    let screen = UIScreen.main.bounds
    @EnvironmentObject var appData: AppData
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            VStack {
                TitleText()
                RRectangle(screen: screen)
                MainText()
                Spacer()
            }
            .padding()
            .frame(width: screen.width, height: screen.height / 2)
            GetDataBtn()
        }
        .onAppear(){
            self.appData.showingAlert = self.appData.getData(self.appData.url)
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: screen.height)
            .background(Color.white)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AppData())
    }
}

struct MainText: View {
    @EnvironmentObject var appData: AppData
    var body: some View {
        Text(self.appData.resp)
            .font(.headline)
            .lineLimit(10)
            .lineSpacing(5)
            .foregroundColor(.purple)
    }
}

struct RRectangle: View {
    let screen: CGRect
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20), style: .circular)
            .fill(Color.purple)
            .frame(width: screen.width - 100, height: 8)
            .opacity(0.2)
    }
}

struct TitleText: View {
    var body: some View {
        Text("今天天气")
            .font(.largeTitle)
    }
}

struct GetDataBtn: View {
    @EnvironmentObject var appData:AppData
    var body: some View {
        VStack {
            Button(action: {
                self.appData.showingAlert = self.appData.getData(self.appData.url)
            })
            {
                Text("戳我查询")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.purple)
                    .cornerRadius(10)
            }
            .alert(isPresented: self.$appData.showingAlert){
                Alert(title: Text("GetData Error!"),
                      message: Text("\(self.appData.resp)"),
                      dismissButton: .default(Text("我知道了")))
            }
        }
    }
}
