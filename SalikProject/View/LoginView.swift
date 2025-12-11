import SwiftUI

struct LoginView: View {

    @ObservedObject var reportStore: ReportStore

    @State private var phoneNumber: String = ""
    @State private var goToHome = false
    @State private var goToGuest = false

    private var isValidPhone: Bool {
        let digitsOnly = phoneNumber.allSatisfy { $0.isNumber }
        return digitsOnly && phoneNumber.count == 9 && phoneNumber.first == "5"
    }

    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()

            VStack(spacing: 20) {

                Spacer().frame(height: 80)

                Image("salikimg")
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 28))
                    .shadow(color: .black.opacity(0.1), radius: 12, y: 5)

                Text("سالك")
                    .font(.system(size: 30, weight: .bold))

                Spacer().frame(height: 30)

                VStack(spacing: 22) {

                    Text("تسجيل الدخول")
                        .font(.system(size: 22, weight: .semibold))

                    HStack {
                        TextField(" +966 رقم الجوال", text: $phoneNumber)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)

                        Image(systemName: "phone")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.gray.opacity(0.3), lineWidth: 1)
                    )

                    Button {
                        if isValidPhone {
                            UserDefaults.standard.set("ضيف", forKey: "userName")
                            UserDefaults.standard.set("+966 " + phoneNumber, forKey: "userPhone")
                            goToHome = true
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("إرسال رمز التحقق")
                                .foregroundColor(.white)
                            Image(systemName: "arrow.left")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .background(isValidPhone ? Color(hex: "#4B9960") : Color(hex: "#A9CDA8"))
                        .cornerRadius(12)
                    }
                    .disabled(!isValidPhone)

                    HStack {
                        Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.3))
                        Text("أو").foregroundColor(.gray)
                        Rectangle().frame(height: 1).foregroundColor(.gray.opacity(0.3))
                    }

                    Button {
                        UserDefaults.standard.set("ضيف", forKey: "userName")
                        UserDefaults.standard.removeObject(forKey: "userPhone")
                        goToGuest = true
                    } label: {
                        HStack {
                            Spacer()
                            Text("الدخول كضيف")
                            Image(systemName: "person")
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                }
                .padding()
                .background(.white)
.cornerRadius(30)
                .padding(.horizontal)

                Spacer()

                Text("بتسجيل الدخول أنت توافق على شروط الاستخدام وسياسة الخصوصية")
                    .font(.footnote)
                    .foregroundColor(.gray.opacity(0.8))

                Spacer().frame(height: 20)
            }
        }
        .navigationDestination(isPresented: $goToHome) {
            MainTabView(reportStore: reportStore)
                .navigationBarBackButtonHidden(true)
        }
        .navigationDestination(isPresented: $goToGuest) {
            MainTabView(reportStore: reportStore)
                .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    NavigationStack {
        LoginView(reportStore: ReportStore())
    }
}
