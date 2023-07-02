import SwiftUI

struct ButoonView<Destination: View>: View {
    var destination: Destination
    var title: String
     
    var body: some View {
        NavigationLink(destination: destination) {
            Text(title)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity)
                .padding()
                .cornerRadius(10)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.blue, lineWidth: 2)
                )
        }
    }
}

struct ButoonView_Previews: PreviewProvider {
    static var previews: some View {
        ButoonView(destination: Text("Destination View"), title: "Button Title")
    }
}
