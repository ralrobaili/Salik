//
//  AccountView.swift
//
//  AccountView.swift
//  SalikProject
//
import SwiftUI

struct AccountView: View {

    @State private var name = UserDefaults.standard.string(forKey: "userName") ?? "ضيف"
    @State private var phone = UserDefaults.standard.string(forKey: "userPhone") ?? "+966XXXXXXXXX"

    @State private var showEdit = false

    var body: some View {

        ScrollView {
            VStack(spacing: 26) {

                // بطاقة المستخدم
                HStack {

                    VStack(alignment: .trailing, spacing: 4) {
                        Text(name)
                            .font(.system(size: 20, weight: .bold))

                        Text(phone)
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Button {
                        showEdit = true
                    } label: {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 32))
                            .foregroundColor(.tabGreenDark)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(18)
                .shadow(color: .black.opacity(0.05), radius: 6)

                // أرقام التقارير والتاريخ
                HStack(spacing: 12) {

                    HomeSmallBox(number: "1", label: "قيد المعالجة")
                    HomeSmallBox(number: "2", label: "تم إرسالها")
                    HomeSmallBox(number: "3", label: "تقارير")

                }
                .padding(.horizontal)

                // قائمة الإعدادات
                VStack(spacing: 0) {
                    SettingsRow(title: "اللغة", icon: "globe")
                    SettingsRow(title: "الإشعارات", icon: "bell")
                    SettingsRow(title: "الخصوصية والأمان", icon: "lock.shield")
                    SettingsRow(title: "الشروط والأحكام", icon: "doc.plaintext")
                    SettingsRow(title: "الدعم والمساعدة", icon: "questionmark.circle")
                }
                .padding(.horizontal)

                Button {
                    UserDefaults.standard.removeObject(forKey: "userName")
                    UserDefaults.standard.removeObject(forKey: "userPhone")
                } label: {
                    Text("تسجيل خروج")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(14)
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .sheet(isPresented: $showEdit) {
            EditAccountSheet(name: $name, phone: $phone)
        }
    }
}

struct HomeSmallBox: View {
    let number: String
    let label: String

    var body: some View {
        VStack {
            Text(number)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.tabGreenDark)

            Text(label)
                .font(.system(size: 13))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4)
    }
}

struct SettingsRow: View {
    let title: String
    let icon: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
            Spacer()
            Text(title)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.03), radius: 3)
        .padding(.vertical, 4)
    }
}

struct EditAccountSheet: View {

    @Binding var name: String
    @Binding var phone: String

    @Environment(\.dismiss) var dismiss

    @State private var tempName = ""
    @State private var tempPhone = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("الاسم", text: $tempName)
TextField("رقم الجوال", text: $tempPhone)
            }
            .navigationTitle("تعديل البيانات")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("حفظ") {
                        name = tempName
                        phone = tempPhone
                        UserDefaults.standard.set(name, forKey: "userName")
                        UserDefaults.standard.set(phone, forKey: "userPhone")
                        dismiss()
                    }
                }
            }
            .onAppear {
                tempName = name
                tempPhone = phone
            }
        }
    }
}
#Preview {
    AccountView()
        .environmentObject(UserModel())
        .environmentObject(ReportStore())
}
