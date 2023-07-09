import SwiftUI

// Creating a general structure that accepts a Destination
struct ButtonView<Destination: View>: View {
    
    var destination: Destination
    var title: String
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(title)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 2)
                )
        }
    }
}


struct ButoonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(destination: Text("Destination View"), title: "Button Title")
    }
}
