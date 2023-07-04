import SwiftUI

struct TextFieldView: View {
    
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundColor(.blue)
            TextField("", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    @State static var text: String = ""
    
    static var previews: some View {
        TextFieldView(title: "First Name", text: $text)
    }
}

