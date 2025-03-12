//
//  AccountView.swift
//  YouVerify
//
//  Created by Samson Oluwapelumi on 10/03/2025.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                FinTrackText("My Account",
                          size: 15,
                          textAlignment: .center)
                    .frame(maxWidth: .infinity)
                    .padding(.top)
                
                // Profile Card
                VStack(alignment: .leading, spacing: 8) {
                    FinTrackText("Aderinsola Adejuwon",
                              size: 18,
                              color: .white)
                    
                    FinTrackText("janedoe@gmail.com",
                              size: 12,
                              color: .white)
                    
                    FinTrackText("+234 90 1619 2553",
                              size: 12,
                              color: .white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)
                .background(Color("buttoncolor"))
                .cornerRadius(16)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                }
                .overlay(alignment: .topTrailing) {
                    Button(action: {}) {
                        Image("edit")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(12)
                    }
                    .padding(16)
                }
                
                // Settings Options
                VStack(alignment: .leading, spacing: 12) {
                    SettingsRow(imageName: "security", title: "Security", subtitle: "Enable or disable biometrics")
                    SettingsRow(imageName: "insights", title: "Insights and Reports", subtitle: "A detailed summary of how you have managed your money")
                    SettingsRow(imageName: "support", title: "Support", subtitle: "We can assist you if you have any queries")
                    SettingsRow(imageName: "feedback", title: "Give feedback", subtitle: "Helps us better the experience for you.")
                }
                
                // Logout Button
                Button(action: {}) {
                    FinTrackText("Log Out",
                              size: 13,
                              color: .red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 24)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
                        }
                }
                
                // Additional Links
                VStack(spacing: 12) {
                    LinkRow(title: "About fintrack")
                    LinkRow(title: "Privacy & Terms of Service")
                    LinkRow(title: "Request account deletion")
                }
                
                // Contact Info
                VStack(alignment: .leading, spacing: 16) {
                    FinTrackText("Contact info",
                              size: 20,
                              color: .white)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 12) {
                            Image("email")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            FinTrackText("contact@fintrack.com",
                                      size: 16,
                                      color: .white)
                        }
                        
                        HStack(spacing: 12) {
                            Image("phone")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.white)
                            FinTrackText("+234 90 161 92553",
                                      size: 16,
                                      color: .white)
                        }
                    }
                }
                .padding(24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    Color("buttoncolor")
                        .overlay(
                            Image("wave")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .opacity(0.1)
                        )
                )
                .cornerRadius(16)
                
                FinTrackText("V 1.0.0",
                          size: 14,
                          color: .gray)
                    .padding(.vertical, 24)
            }
            .padding(.horizontal, 16)
        }
        .background(Color("backgroundColor"))
    }
}

// Additional helper views
struct SettingsRow: View {
    let imageName: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(imageName)
                .resizable()
                .frame(width: 28, height: 28)
                .padding(8)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                FinTrackText(title,
                          size: 14)
                FinTrackText(subtitle,
                          size: 12,
                          color: .gray)
            }
            
            Spacer()
            
            Image("chevron")
                .resizable()
                .frame(width: 26, height: 30)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        }
    }
}

struct LinkRow: View {
    let title: String
    
    var body: some View {
        HStack {
            FinTrackText(title,
                      size: 13,
                      color: .black)
            Spacer()
            Image("chevron")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.black.opacity(0.3))
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.1), lineWidth: 1)
        }
    }
}
