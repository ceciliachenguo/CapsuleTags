//
//  Home.swift
//  CapsuleTags
//
//  Created by Cecilia Chen on 9/7/23.
//

import SwiftUI

struct Home: View {
    
    @State var text: String = ""
    
    @State var tags: [Tag] = []
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Text("Your areas of \ninterest")
                .font(.system(size: 38, weight: .bold))
                .foregroundColor(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TagView(maxLimit: 150, tags: $tags)
                .frame(height: 280)
            
            TextField("Add an interest..", text: $text)
                .font(.callout)
                .padding(.vertical,10)
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .strokeBorder(Color.black, lineWidth: 1)
                )
                .foregroundColor(.black)
                .environment(\.colorScheme, .light)
                .padding(.vertical,18)
            
            Button {
                addTag(tags: tags, text: text, fontSize: 16, maxLimit: 150) { alert, tag in
                    if alert{
                        showAlert.toggle()
                    } else {
                        tags.append(tag)
                        text = ""
                    }
                }
                
            } label: {
                Text("Add Tag")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical,12)
                    .padding(.horizontal,45)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .disabled(text == "")
            .opacity(text == "" ? 0.6 : 1)

        }
        .padding(15)
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .background(
            Color.white
                .ignoresSafeArea()
        )
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Tag Limit Exceeded  try to delete some tags !!!"), dismissButton: .destructive(Text("Ok")))
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
