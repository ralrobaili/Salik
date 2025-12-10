//
//  AccountView.swift
//  SalikProject
//
//  Created by raghad alenezi on 16/06/1447 AH.
//


import SwiftUI

struct AccountView: View {

    @EnvironmentObject var user: UserModel
    @State private var showLogoutAlert = false
    @State private var goLogin = false

    private var displayName: String {
        user.name.isEmpty ? "سميه" : user.name
    }

    private var displayPhone: String {
        user.phone.isEmpty ? "+966512345678" : user.phone
    }

    var body: some View {

        VStack(spacing: 0) {

            Text("الحساب")
                .font(.system(size: 22, weight: .semibold))
                .padding(.top, 16)
                .padding(.bottom, 8)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))

            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {

                    VStack(spacing: 18) {

                        HStack(spacing: 12) {

                            Button {
                                print("فتح صفحة البروفايل قريباً")
                            } label: {
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.white)
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Image(systemName: "person")
                                            .font(.system(size: 26))
                                            .foregroundColor(.gray)
                                    )
                            }

                            VStack(alignment: .trailing, spacing: 6) {
                                Text(displayName)
                                    .font(.system(size: 20, weight: .bold))

                                HStack(spacing: 4) {
                                    Text(displayPhone)
                                        .font(.system(size: 15))
                                        .foregroundColor(.gray)

                                    Image(systemName: "phone")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)

                            ZStack {
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.tabGreenDark)
                                    .frame(width: 56, height: 56)

                                Text(String(displayName.prefix(1)))
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(14)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.05), radius: 5, y: 1)

                        HStack(spacing: 14) {
                            statBox(number: 0, title: "تقارير")
                            statBox(number: 0, title: "تم إرسالها")
                            statBox(number: 0, title: "قيد المعالجة")
                        }

                    }
                    .padding(.horizontal)

                    VStack(spacing: 20) {
                        settingsRow(title: "اللغة", icon: "globe", value: "العربية")
                        settingsRow(title: "الإشعارات", icon: "bell", value: "مفعل")
                        settingsRow(title: "الخصوصية والأمان", icon:"shield")
                        settingsRow(title: "الشروط والأحكام", icon: "doc.text")
                        settingsRow(title: "الدعم والمساعدة", icon: "questionmark.circle")
                    }
                    .padding()
                    .
background(Color.white)
                    .cornerRadius(22)
                    .shadow(color: .black.opacity(0.05), radius: 5, y: 1)
                    .padding(.horizontal)

                    Button {
                        showLogoutAlert = true
                    } label: {
                        HStack {
                            Spacer()
                            Text("تسجيل خروج")
                                .foregroundColor(.red)
                                .font(.system(size: 17, weight: .medium))
                            Spacer()
                        }
                        .padding()
                        .background(Color.red.opacity(0.08))
                        .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    .padding(.top, 2)
                    .alert("هل أنت متأكد من تسجيل الخروج؟", isPresented: $showLogoutAlert) {
                        Button("نعم", role: .destructive) {
                            user.name = ""
                            user.phone = ""
                            goLogin = true
                        }
                        Button("إلغاء", role: .cancel) {}
                    }

                    Text("سالك الإصدار 1.1")
                        .font(.footnote)
                        .foregroundColor(.gray.opacity(0.7))
                        .padding(.vertical, 10)

                    Spacer().frame(height: 30)
                }
            }
            .background(Color(.systemGray6))
        }
        .navigationDestination(isPresented: $goLogin) {
            LoginView()
                .environmentObject(user)
                .navigationBarBackButtonHidden(true)
        }
        .navigationBarBackButtonHidden(true)
    }
}



func statBox(number: Int, title: String) -> some View {
    VStack(spacing: 6) {
        Text("\(number)")
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(Color.tabGreenDark)

        Text(title)
            .font(.system(size: 14))
            .foregroundColor(.gray)
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(Color.white)
    .cornerRadius(18)
    .shadow(color: .black.opacity(0.05), radius: 4, y: 1)
}

func settingsRow(title: String, icon: String, value: String? = nil) -> some View {
    HStack {
        if let value = value {
            Text(value)
                .foregroundColor(.gray)
        }

        Spacer()

        Text(title)
            .foregroundColor(.black)

        Image(systemName: icon)
            .foregroundColor(.gray)
    }
    .padding(.vertical, 14)
    .padding(.horizontal)
}
#Preview {
    AccountView()
        .environmentObject(UserModel())
}
