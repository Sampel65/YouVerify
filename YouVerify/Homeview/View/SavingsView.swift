//
//  SavingsView.swift
//  YouVerify
//
//  Created by Samson Oluwapelumi on 10/03/2025.
//

import SwiftUI

struct SavingsView: View {
    @State private var presentPopup = false
    @State private var isNavigating = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("My Savings")
                    .font(.capriolaRegular(size: 20))
                    .padding(.top)
                
                Spacer()
            }
            .onAppear {
                withAnimation(.linear(duration: 0.3)) {
                    presentPopup = true
                }
            }
            .overlay {
                if presentPopup {
                    Popup(isPresented: $presentPopup, dismissOnTapOutside: false) {
                        VStack(spacing: 16) {
                            Image("savingss")
                                .resizable()
                                .frame(width: 100, height: 120)
                            
                            Text("Set saving goals")
                                .font(.capriolaRegular(size: 24))
                                .foregroundColor(.white)
                                .padding(.top, 8)
                            
                            Text("Get ready to start achieving your saving goals.")
                                .font(.capriolaRegular(size: 16))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            
                            NavigationLink(destination: CreateSavingsGoalView().navigationBarBackButtonHidden(true),
                                         isActive: $isNavigating) {
                                Text("Create a savings goal")
                                    .font(.capriolaRegular(size: 16))
                                    .foregroundColor(Color("orangeButton"))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 16)
                                    .background(Color.white)
                                    .cornerRadius(12)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                presentPopup = false
                                isNavigating = true
                            })
                        }
                    }
                }
            }
        }
    }
}

// End of file
