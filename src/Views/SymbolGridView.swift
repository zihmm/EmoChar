import SwiftUI

struct SymbolGridView: View {
    let symbols: [SymbolItem]

    private let columns = [GridItem(.adaptive(minimum: 72, maximum: 88))]

    var body: some View {
        ScrollView {
            if symbols.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 40))
                        .foregroundStyle(.tertiary)
                    Text("No symbols found")
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 80)
                .frame(maxWidth: .infinity)
            } else {
                LazyVGrid(columns: columns, spacing: 6) {
                    ForEach(symbols) { symbol in
                        SymbolCellView(symbol: symbol)
                    }
                }
                .padding()
            }
        }
    }
}
