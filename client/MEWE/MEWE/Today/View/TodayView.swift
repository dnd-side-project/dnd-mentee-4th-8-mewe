//
//  TodayView.swift
//  MEWE
//
//  Created by 1v1 on 2021/01/23.
//

import SwiftUI
import PartialSheet


struct TodayView: View {
    
    @EnvironmentObject var partialSheetManager : PartialSheetManager

    var body: some View {
        NavigationView {
            VStack {
                HStack(){
                    NavigationLink(
                        destination: CategoryView()
                    ){
                        Image(systemName: "line.horizontal.3.decrease")
                            .font(.system(size: 25, weight:.heavy))
                            .foregroundColor(.black)
                    }
                    .isDetailLink(false)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                
                Text(dateForTodayView(date: Date()))
                TodayEmojiView()
                
                HStack {
                    
                    Spacer()
                    
                    Button(action: {
                        showPartialSheet()
                    }) {
                        Text("담기 완료!")
                            .modifier(AddDoneBtnStyling())
                    } //: B
                    
                } //: H
                .padding(.horizontal, 16)
                
                SelectEmoji()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .addPartialSheet(style: getPartialSheetStyle())
            .navigationBarHidden(true)
        }
        
    }
    
    /// Open Partial Sheet
    private func showPartialSheet() {
        partialSheetManager.showPartialSheet {
            RecordEmojiView()
                .frame(height: 450)
                .environmentObject(partialSheetManager)
                .padding(.horizontal)
        }
    }
    
    /// PartialSheet Style
    private func getPartialSheetStyle() -> PartialSheetStyle {
        return PartialSheetStyle(
            background: .solid(.white),
            handlerBarColor: .clear,
            enableCover: true,
            coverColor: Color.black.opacity(0.2),
            cornerRadius: 50,
            minTopDistance: 200
        )
    }
    
    /// Style for Add Done Button
    fileprivate struct AddDoneBtnStyling: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding(8)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(40)
                .font(Font.system(size: 12))
        }
    }
    
}

func dateForTodayView(date: Date) -> String {
    let format = DateFormatter()
    format.dateFormat = "dd MMM yyyy"

    return format.string(from: date)
}


