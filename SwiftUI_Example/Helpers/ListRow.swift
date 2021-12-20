import SwiftUI

struct ListRow: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 10.0)
            
            Spacer()
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ListRow(title: "Test1")
            ListRow(title: "Test2")
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
