//
//  MainView.swift
//  Figma Films
//
//  Created by Pablo  on 4/1/25.
//

import SwiftUI

struct MainView: View {
    
    //Variable que almacena lo que escribe el usuario en el TextField
    @State  private var peliculaBuscada:String = ""
    @StateObject private var peliculaViewModel = PeliculaViewModel()
    @StateObject private var generoViewModel = GeneroViewModel()
    
    
    //Logica para el filrado de peliculas
    var peliculaFiltradas : [Pelicula] {
        if peliculaBuscada.isEmpty {
            return peliculaViewModel.peliculas//Si el Textfild esta vacio, devuelve todos el array "DatosEjemplo"
        } else {
            return peliculaViewModel.peliculas.filter { pelicula in
                pelicula.title.localizedCaseInsensitiveContains(peliculaBuscada) //El metodo localizedCaseInsentiveContains busca una subcadena dentro de una cadena, ignorando mayusculas y minusculas, con lo cual es realmente util en este caso
            }
        }
    }
    
    var body: some View {
        
        NavigationStack{
            
            //Stack de todos los elementos
            VStack{
                
                //Stack horizontal de titulo Movies e iconos
                HStack{
                    
                    Image("movie_icon")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.horizontal,5)
                    
                    Text("MOVIES")
                        .font(Font.custom("Raleway", size: 30).weight(.heavy))
                        .tracking(3)
                        .foregroundColor(.black)
                    
                    Image("movie_icon")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.horizontal,5)
                    
                }.padding(.bottom,20)
                
                
                
                TextField("Buscar pelicula", text: $peliculaBuscada)
                    .padding(10)
                    .overlay(
                        HStack{
                            Spacer()
                            if !peliculaBuscada.isEmpty {
                                Button(action: {
                                    peliculaBuscada = ""
                                }){
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)
                                }
                            }
                        }
                        
                    ).background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                    .padding(.bottom, 20)
                    .padding(.horizontal, 30)
                
                
                
                HStack{
                    Text("Peliculas mejor valoradas")
                        .font(Font.custom("Raleway", size: 20).weight(.bold))
                        .foregroundColor(.black)
                        .padding(.leading, 32)
                        .padding(.bottom,5)
                    
                    Spacer()
                    
                }
                
                
                
                ScrollView{
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(peliculaFiltradas) { pelicula in
                            NavigationLink(destination: DetailView(pelicula: pelicula, generoViewModel: generoViewModel)) {
                                CardView(pelicula: pelicula, peliculaViewModel : peliculaViewModel, generoViewModel: generoViewModel)
                            }
                        }
                    }
                    .padding(.top, 20)
                    
                }
                
            }.background(
                Image("fondo")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.1)
            )
           
            // Cargar las películas al aparecer la vista
            .onAppear {
                Task {
                   try await peliculaViewModel.peliculasFetch()
                   await generoViewModel.getGeneros()
                    
                }
            }
            
        }
        
    }
    
}

    

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

