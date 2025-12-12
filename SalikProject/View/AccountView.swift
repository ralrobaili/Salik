//
//  AccountView.swift
//  SalikProject
//

import SwiftUI

struct AccountView: View {

    @EnvironmentObject var reportStore: ReportStore

    @State private var name = UserDefaults.standard.string(forKey: "userName") ?? "ضيف"
    @State private var phone = UserDefaults.standard.string(forKey: "userPhone") ?? "+966XXXXXXXXX"
    
    @State private var showLogoutAlert = false

    var body: some View {

        ScrollView(showsIndicators: false) {
            VStack(spacing: 28) {

                AccountHeaderView(name: name, phone: phone)

                HStack(spacing: 12) {
                    StatusBox(number: "0", label: "قيد المعالجة")
                    StatusBox(number: "0", label: "تم إرسالها")
                    StatusBox(number: "0", label: "تقارير")
                }
                .padding(.horizontal)

                VStack(spacing: 10) {

                    SettingsRow(title: "اللغة", icon: "globe", value: "العربية")
                    SettingsRow(title: "الإشعارات", icon: "bell", value: "مُفعل")
                    SettingsRow(title: "الخصوصية والأمان", icon: "checkmark.shield")
                    SettingsRow(title: "الشروط والأحكام", icon: "doc.plaintext")
                    SettingsRow(title: "الدعم والمساعدة", icon: "questionmark.circle")

                }
                .padding(.horizontal)

                Button {
                    showLogoutAlert = true
                } label: {
                    HStack {
                        Text("تسجيل خروج")
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.red)
                        Image(systemName: "arrow.right.square")
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.red.opacity(0.35), lineWidth: 1.4)
                    )
                }
                .padding(.horizontal)
                .alert("هل أنت متأكد أنك تريد تسجيل الخروج؟", isPresented: $showLogoutAlert) {
                    Button("نعم", role: .destructive) {
                        UserDefaults.standard.removeObject(forKey: "userName")
                        UserDefaults.standard.removeObject(forKey: "userPhone")

                 
                        if let windowScene = UIApplication.shared.connectedScenes
                            .compactMap({ $0 as? UIWindowScene })
                            .first,
                           let window = windowScene.windows.first {
                            window.rootViewController = UIHostingController(
                                rootView: NavigationStack {
                                    LoginView(reportStore: reportStore)
                                }
                                .environmentObject(reportStore)
                            )
                            window.makeKeyAndVisible()
                        }
                    }
                    Button("إلغاء", role: .cancel) {}
                }

                Text("سالك – الإصدار 1.1")
                    .font(.system(size: 12))
                    .foregroundColor(.gray.opacity(0.6))
                    .padding(.top, 20)
            }
            .padding(.top, 20)
        }
    }
}


struct AccountHeaderView: View {

    var name: String
    var phone: String

    var firstLetter: String {
        return String(name.prefix(1))
    }

    var body: some View {

        HStack(spacing: 14) {

            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.systemGray6))
                    .frame(width: 50, height: 50)

                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .font(.system(size: 20))
            }

            VStack(alignment: .trailing, spacing: 6) {

                Text(name)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)

                HStack(spacing: 4) {

                    Image(systemName: "phone.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))

                    Text(phone)
                        .font(.system(size: 15))
                        .foregroundColor(.gray)

                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }

            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.tabGreenDark)
                    .frame(width: 50, height: 50)

                Text(firstLetter)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
            }

        }
        .padding()
        .background(Color.white)
        .cornerRadius(22)
        .shadow(color: .black.opacity(0.05), radius: 8)
        .padding(.horizontal)
    }
}



struct StatusBox: View {

    var number: String
    var label: String

    var body: some View {

        VStack(spacing: 6) {
            Text(number)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.tabGreenDark)

            Text(label)
                .font(.system(size: 13))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}


struct SettingsRow: View {

    var title: String
    var icon: String
    var value: String? = nil

    var body: some View {

        HStack {

            // القيمة (مثل العربية، مفعل)
            if let value = value {
                Text(value)
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
            }

            Spacer()

            Text(title)
                .foregroundColor(.black)
                .font(.system(size: 16))

            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .frame(width: 40, height: 40)

                Image(systemName: icon)
                    .foregroundColor(.gray)
            }

        }
        .padding(.vertical, 6)
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.03), radius: 4)
    }
}

#Preview {
    AccountView()
        .environmentObject(ReportStore())
}
