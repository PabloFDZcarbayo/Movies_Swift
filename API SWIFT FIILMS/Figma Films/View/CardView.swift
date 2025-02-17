import SwiftUI

struct CardView: View {
    
    var pelicula: Pelicula
    
    @ObservedObject var peliculaViewModel: PeliculaViewModel
    @ObservedObject  var generoViewModel : GeneroViewModel
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                // Imagen de la película
                ZStack(alignment: .topTrailing) {
                    AsyncImage(url: URL(string: pelicula.posterURL)) { image in
                        image.resizable()
                            .frame(width: 150.54, height: 240)
                            .cornerRadius(10)
                            .padding(5)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    // Círculo con la puntuación
                    Circle()
                        .frame(width: 35, height: 35)
                        .foregroundColor(Color(.red))
                        .overlay(
                            Text(String(format: "%.1f", pelicula.voteAverage))
                                .font(Font.custom("Raleway", size: 12).weight(.bold))
                                .foregroundColor(.white)
                        )
                        .padding([.top, .trailing], -11)
                }
                
                // Título de la película
                Text(pelicula.title)
                    .font(Font.custom("Raleway", size: 14).weight(.bold))
                    .tracking(0.80)
                    .foregroundColor(.black)
                    .padding(.leading, 11)
                
                // Géneros de la película
                
                
                
                if let firstGenreId = pelicula.genreIds.first {
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 65, height: 25)
                            .background(Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0.80))
                            .cornerRadius(100)
                        
                        Text(generoViewModel.nombreDelGenero(id: firstGenreId))//aqui va el nombre del genero
                            .font(Font.custom("Raleway", size: 12).weight(.bold))
                            .foregroundColor(.black)
                    }
                    .frame(width: 65, height: 25)
                }
            }
            
        }.onAppear {
            Task {
                await generoViewModel.getGeneros()
            }
            
            
        }
        
    }
        
        struct CardView_Previews: PreviewProvider {
            static var previews: some View {
                // Datos de prueba para la previsualización
                let peliculaSimulada = Pelicula(
                    id: 1,
                    title: "Inception",
                    overview: "Un ladrón especializado en robar secretos a través del uso de la tecnología de invasión de sueños.",
                    genreIds: [18, 80],
                    posterPath: "/mbry0W5PRylSUHsYzdiY2FSJwze.jpg",
                    backdropPath: "/backdrop.jpg",
                    releaseDate: "2010-07-16",
                    voteAverage: 8.8,
                    voteCount: 1200,
                    originalLanguage: "en",
                    popularity: 70.5
                )
                
                
                // ViewModels simulados
                let peliculaViewModel = PeliculaViewModel()
                let generoViewModel = GeneroViewModel()
                // Mostrar la CardView en la previsualización
                CardView(
                    pelicula: peliculaSimulada,
                    peliculaViewModel: peliculaViewModel,
                    generoViewModel: generoViewModel
                )
            }
        }
        
    }

