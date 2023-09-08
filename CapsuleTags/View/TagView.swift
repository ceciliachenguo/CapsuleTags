//
//  TagView.swift
//  CapsuleTags
//
//  Created by Cecilia Chen on 9/7/23.
//

import SwiftUI

struct TagView: View {
    var maxLimit: Int
    @Binding var tags: [Tag]
        
    @Namespace var animation
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 5) {
                ForEach(getRows(),id: \.self){rows in
                    HStack(spacing: 6){
                        ForEach(rows){row in
                            RowView(tag: row)
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width - 50, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .animation(.easeInOut, value: tags)
    }
    
    @ViewBuilder
    func RowView(tag: Tag)->some View{
        Text(tag.text)
            .font(.system(size: 16))
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color.black)
            )
            .foregroundColor(Color.white)
            .lineLimit(1)
            .contentShape(Capsule())
            .contextMenu{
                Button("Delete"){
                    tags.remove(at: getIndex(tag: tag))
                }
            }
            .matchedGeometryEffect(id: tag.id, in: animation)
    }
    
    func getIndex(tag: Tag)->Int{
        let index = tags.firstIndex { currentTag in
            return tag.id == currentTag.id
        } ?? 0
        
        return index
    }
    
    // Splitting the array when it exceeds the screen size....
    func getRows()->[[Tag]]{
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        
        var totalWidth: CGFloat = 0
        
        let screenWidth: CGFloat = UIScreen.main.bounds.width - 50
        
        tags.forEach { tag in
            // adding the capsule size into total width with spacing..
            // 14 + 14 + 6 + 6
            // extra 6 for safety...
            totalWidth += (tag.size + 34)
            
            // checking if totalwidth is greater than size...
            if totalWidth > screenWidth{
                totalWidth = (!currentRow.isEmpty || rows.isEmpty ? (tag.size + 34) : 0)
                
                rows.append(currentRow)
                currentRow.removeAll()
                currentRow.append(tag)
                
            } else {
                currentRow.append(tag)
            }
        }
        
        if !currentRow.isEmpty{
            rows.append(currentRow)
            currentRow.removeAll()
        }
        
        return rows
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func addTag(tags: [Tag],text: String,fontSize: CGFloat,maxLimit: Int,completion: @escaping (Bool,Tag)->()){
    
    let font = UIFont.systemFont(ofSize: fontSize)
    
    let attributes = [NSAttributedString.Key.font: font]
    
    let size = (text as NSString).size(withAttributes: attributes)
    
    let tag = Tag(text: text, size: size.width)
    
    if (getSize(tags: tags) + text.count) < maxLimit{
        completion(false, tag)
    } else {
        completion(true, tag)
    }
}

func getSize(tags: [Tag])->Int{
    var count: Int = 0
    
    tags.forEach { tag in
        count += tag.text.count
    }
    
    return count
}
