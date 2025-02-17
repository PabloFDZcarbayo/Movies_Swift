//
//  DetailView.swift
//  Figma Films
//
//  Created by Pablo  on 4/1/25.
//
import SwiftUI

struct DetailView: View {
    
    var pelicula: Pelicula
    @ObservedObject var generoViewModel : GeneroViewModel
    
    var body: some View {
        ScrollView{
            
            //Stack vertical de toda la vista
            VStack(alignment: .leading) {
                
                // Imagen
                
                AsyncImage(url: URL(string: pelicula.posterURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .shadow(color: Color.black.opacity(0.3), radius: 10, y: 8)
                        .edgesIgnoringSafeArea(.top)
                } placeholder: {
                    ProgressView()
                }
                
                
                //Stack vertical con toda la información
                VStack(alignment: .leading, spacing: 10) {
                    
                    // Titulo
                    Text(pelicula.title)
                        .font(Font.custom("Raleway", size: 26).weight(.bold))
                        .tracking(1.30)
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                    
                    //Stack Año y Puntuacion
                    HStack{
                        Text(pelicula.releaseDate)
                            .font(Font.custom("Raleway", size: 20).weight(.bold))
                            .tracking(0.80)
                            .foregroundColor(Color(red: 0.68, green: 0.27, blue: 0.27))
                        
                        //  stack solo estrellas, alineadas horizontalmente
                        HStack {
                            ForEach(1...1, id: \.self) { index in
                                Image("star_icon")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                
                            }
                            
                        }
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    
                    
                    
                    // Sinopsis
                    
                    Text("Sinopsis")
                        .font(Font.custom("Raleway", size: 20).weight(.light))
                        .tracking(0.80)
                        .foregroundColor(Color(.gray))
                        .padding(.bottom, 10)
                    
                    
                    Text(pelicula.overview)
                        .font(Font.custom("Raleway", size: 18).weight(.light))
                        .tracking(0.80)
                        .foregroundColor(.black)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding (.bottom, 15)
                    
                    
                    
                    
                    //Categorias
                    
                    Text ("Categorias")
                        .font(Font.custom("Raleway", size: 20).weight(.light))
                        .foregroundColor(Color(.gray))
                    
             
                    // Stack Horizontal duracion
                    HStack{
                        
                        ForEach(pelicula.genreIds, id: \.self){ genreId in
                            
                        
                        ZStack {
                            
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 96.46, height: 25)
                                .background(Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0.80))
                                .cornerRadius(100)
                                .offset(x: 0, y: 16.50)
                                .shadow(
                                    color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4
                                )
                            
                            Text(generoViewModel.nombreDelGenero(id: genreId))
                                .font(Font.custom("Raleway", size: 16).weight(.bold))
                                .tracking(0.80)
                                .foregroundColor(.black)
                                .offset(x: 0.27, y: 16.50)
                            
                        }
                    }
                                 }
                    Spacer()
                }
                .padding(.top ,200 )
                .padding(.horizontal, 20)
            }
            .edgesIgnoringSafeArea(.all)
        }
                       
                       
    }
                       
   
}
                       
                       

struct Previews_DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let peliculasSimuladas = [
            Pelicula(id: 1, title: "Inception", overview: "Un ladrón especializado en robar secretos a través del uso de la tecnología de invasión de sueños.", genreIds: [1, 2], posterPath: "/mbry0W5PRylSUHsYzdiY2FSJwze.jpg", backdropPath: "/backdrop.jpg", releaseDate: "2010-07-16", voteAverage: 8.8, voteCount: 1200, originalLanguage: "en", popularity: 70.5),
            Pelicula(id: 2, title: "The Dark Knight", overview: "El caballero oscuro enfrenta a un nuevo villano, el Joker, que amenaza con sumergir Gotham en el caos.", genreIds: [1, 3], posterPath: "/darkknight.jpg", backdropPath: "/darkknightbackdrop.jpg", releaseDate: "2008-07-18", voteAverage: 9.0, voteCount: 1500, originalLanguage: "en", popularity: 80.0)
        ]
        
        let generoViewModel = GeneroViewModel()
        
        // Aquí estamos utilizando las películas simuladas
        DetailView(pelicula: peliculasSimuladas[0], generoViewModel: generoViewModel)
    }
}
