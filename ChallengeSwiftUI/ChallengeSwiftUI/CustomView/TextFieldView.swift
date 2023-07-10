import SwiftUI

struct TextFieldView: View {
    
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundColor(.blue)
            TextField("", text: $text)
                .padding()
                .background(Color.gray.opacity(0.1).cornerRadius(10))
                .foregroundColor(.blue)
                .font(.headline)
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    @State static var text: String = ""
    
    static var previews: some View {
        TextFieldView(title: "First Name", text: $text)
    }
}

