import SwiftUI

struct TextFieldView: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                //.font(.headline)
                .foregroundColor(.blue)
            TextField("", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
//        .padding(.horizontal)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    @State static var text: String = ""
    
    static var previews: some View {
        TextFieldView(title: "First Name", text: $text)
         
    }
}
