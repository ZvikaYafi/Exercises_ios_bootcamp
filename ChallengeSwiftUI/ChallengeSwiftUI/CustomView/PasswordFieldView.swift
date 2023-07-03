

import SwiftUI

struct PasswordFieldView: View {
    let title: String
    @Binding var password: String
    @State private var isShowingPassword = false
    
    //
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundColor(.blue)
            
            HStack {
                if isShowingPassword {
                    TextField("", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                } else {
                    SecureField("", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button(action: {
                    isShowingPassword.toggle()
                }) {
                    Image(systemName: isShowingPassword ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

