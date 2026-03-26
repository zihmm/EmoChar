import SwiftUI

struct ContentView: View {
    @State private var selectedItem: SidebarItem? = .emojis
    @State private var searchText = ""

    var filteredSymbols: [SymbolItem] {
        let category: SymbolCategory
        switch selectedItem {
        case .arrows: category = .arrows
        case .math:   category = .math
        case .misc:   category = .misc
        default:      return []  // emoji view handles its own filtering
        }
        let symbols = SymbolData.items(for: category)
        guard !searchText.isEmpty else { return symbols }
        return symbols.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.char.contains(searchText)
        }
    }

    var body: some View {
        NavigationSplitView {
            SidebarView(selectedItem: $selectedItem)
        } detail: {
            if selectedItem == .emojis || selectedItem == nil {
                EmojiContentView(searchText: $searchText)
            } else {
                SymbolGridView(symbols: filteredSymbols)
            }
        }
        .searchable(text: $searchText, placement: .toolbar, prompt: "Search symbols")
        .frame(minWidth: 700, minHeight: 460)
    }
}
