//
//  ContentView.swift
//  7-GameMarket
//
//  Created by Seyfo on 23.03.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Oyun : Identifiable {
    var id :Int
    var adi : String
    var goruntu : String
    var oy : Int
}
var oyunVerileri = [
Oyun(id: 0, adi: "Resident Evil 3", goruntu:"g2", oy: 3),
Oyun(id: 1, adi: "GTA 5", goruntu:"g3", oy: 5),
Oyun(id: 2, adi: "Assasing's Creed Odesey", goruntu:"g4", oy: 3),
Oyun(id: 3, adi: "Resident Evil 7", goruntu:"g5", oy: 2),
Oyun(id: 4, adi: "Watch Dogs 2", goruntu:"g6", oy: 1),
Oyun(id: 5, adi: "The Evil Within 2", goruntu:"g7", oy: 2),
Oyun(id: 6, adi: "Tomb Raider 2014", goruntu:"g8", oy: 4),
Oyun(id: 7, adi: "Shadow Of Tomb Raider", goruntu:"g1", oy: 4)
]

struct Home : View {
    @State var ara = ""
    @State var index = 0
    @State var sutunlar = Array(repeating: GridItem(.flexible(),spacing: 15), count: 2)
    
    var body: some View{
        ScrollView{
            
            LazyVStack{
                
                HStack{
                    Text("Game Store").font(.title).fontWeight(.bold)
                    Spacer()
                }.padding(.horizontal)
                
                TextField("Search", text: self.$ara)
                    .padding(.vertical, 10).padding(.horizontal)
                    .background(.black .opacity(0.07))
                    .cornerRadius(10).padding(.horizontal).padding(.top, 15)
                
                
                TabView(selection: self.$index){
                    // 0. indexteki sekme seçili olacak
                    
                    ForEach(0...5, id: \.self) { index in
                        Image("p\(index)").resizable()
                            .frame(height: self.index == index ? 230 : 180)
                            .cornerRadius(15).padding(.horizontal)
                            .tag(index)
                        
                    }
           
                }.frame(height: 230)
                    .padding(.top, 25)
                    .tabViewStyle(PageTabViewStyle())
                    .animation(.easeOut)
                
                HStack{
                    Text("Popular").font(.title).fontWeight(.bold)
                    Spacer()
                    
                    Button{
                        withAnimation{
                            if self.sutunlar.count == 2 { // 2 sütünlu görünümdeysek
                                self.sutunlar.removeLast()
                            }else {
                                // Tek sütun var. 2.sütuna çıkarmalıyız
                                self.sutunlar.append(GridItem(.flexible(),spacing: 15))
                            }
                        }
                    }label: {
                        Image(systemName: self.sutunlar.count == 2 ? "rectangle.grid.1x2": "square.grid.2x2")
                            .font(.system(size: 24)).foregroundColor(.black)
                    }
                }.padding(.horizontal).padding(.top, 25)
                
                LazyVGrid(columns: sutunlar, spacing: 25){
                    ForEach(oyunVerileri){ oyun in
                        // GridView çağrılacak
                        GridView(oyun: oyun, sutunlar: self.$sutunlar)
                        
                        
                        
                        
                    }
                    
                    
                    
                }.padding([.horizontal, .top])
                
                
                
                
            }// VStack End
            .padding(.vertical)
            
            
            
            
        }//ScrollView Bitiş
        .background(.black.opacity(0.05))
    }
}

struct GridView : View {
    
    var oyun : Oyun
    
    @Binding var sutunlar : [GridItem]
    @Namespace var namespace
    
    var body: some View {
        
        VStack{
            
            if self.sutunlar.count == 2 { // 2 Sütünlu görünüm
                VStack(spacing: 15){
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        
                        Image(oyun.goruntu).resizable().frame(height: 250).cornerRadius(15)
                        
                        Button{} label: {
                            Image(systemName: "heart.fill").foregroundColor(.red).padding(.all, 10)
                                .background(.white).clipShape(Circle())
                        }.padding(.all, 5)
                        
                        
                        
                    }.matchedGeometryEffect(id: "goruntu", in: self.namespace)
                    
                    Text(oyun.adi).fontWeight(.bold).lineLimit(1)
                        .matchedGeometryEffect(id: "baslik", in: self.namespace)
                    
                    Button{}label: {
                        Text("Buy").foregroundColor(.white)
                            .padding(.vertical, 5).padding(.horizontal, 25)
                            .background(.red).cornerRadius(10)
                    }.matchedGeometryEffect(id: "buy", in: self.namespace)
                    
                }
                
                
                
                
                
            }else { // Tek sütunlu görünüm
                
                HStack(spacing: 15){
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                        Image(oyun.goruntu).resizable()
                            .frame(width: (UIScreen.main.bounds.width - 45 ) / 2, height: 250).cornerRadius(15)
                        
                        Button{}label: {
                            Image(systemName: "heart.fill").foregroundColor(.red)
                                .padding(.all, 10).background(.white).opacity(0.8)
                                .clipShape(Circle())
                        }.padding(.all, 5)
                    }.matchedGeometryEffect(id: "goruntu", in: self.namespace)
                    
                    VStack(alignment: .leading, spacing: 10){
                        
                        Text(oyun.adi).fontWeight(.bold).matchedGeometryEffect(id: "baslik", in: self.namespace)
                        HStack(spacing: 10){
                            ForEach(1...5, id: \.self) { oy in
                                Image(systemName: "star.fill")
                                    .foregroundColor(self.oyun.oy >= oy ? .yellow : .gray)
                                
                            }
                            Spacer()
                        }
                        Button{}label: {
                            Text("Buy").foregroundColor(.white)
                                .padding(.vertical,10)
                                .padding(.horizontal,25)
                                .background(.red)
                                .cornerRadius(10)
                        }.padding(.top, 10).matchedGeometryEffect(id: "buy", in: self.namespace)
                        
                    } // VStack End
                    
                    
                    
                }// HStack End
                .padding(.trailing).background(.white).cornerRadius(15)
                
            }
            
            
            
        }
        
        
        
        
        
    }
    
    
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
