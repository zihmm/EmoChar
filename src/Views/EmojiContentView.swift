import SwiftUI

struct EmojiContentView: View {
    @Binding var searchText: String
    @State private var selectedCategory: SymbolCategory = .people

    private let columns = [GridItem(.adaptive(minimum: 72, maximum: 88))]

    // All emoji symbols flattened for search
    private var allEmojiSymbols: [SymbolItem] {
        SymbolCategory.emojiCategories.flatMap { SymbolData.items(for: $0) }
    }

    private var searchResults: [SymbolItem] {
        allEmojiSymbols.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.char.contains(searchText)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Category segmented control — hidden during search
            if searchText.isEmpty {
                Picker(selection: $selectedCategory, label: EmptyView()) {
                    ForEach(SymbolCategory.emojiCategories) { cat in
                        Text(cat.rawValue).tag(cat)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)

                Divider()
            }

            if searchText.isEmpty {
                // Sectioned grid — one section per emoji sub-category
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(SymbolCategory.emojiCategories) { category in
                                sectionView(for: category)
                            }
                        }
                        .padding(.bottom)
                    }
                    .onChange(of: selectedCategory) { target in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            proxy.scrollTo(target, anchor: .top)
                        }
                    }
                }
            } else {
                // Flat filtered results
                SymbolGridView(symbols: searchResults)
            }
        }
    }

    @ViewBuilder
    private func sectionView(for category: SymbolCategory) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            // Section header acts as the scroll anchor
            Label(category.rawValue, systemImage: category.systemImage)
                .font(.headline)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 14)
                .padding(.top, 14)
                .padding(.bottom, 2)
                .id(category)

            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(SymbolData.items(for: category)) { symbol in
                    SymbolCellView(symbol: symbol)
                }
            }
            .padding(.horizontal, 8)
        }
    }
}
