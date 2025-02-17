//
//  PeliculaViewModel.swift
//  Figma Films
//
//  Created by Pablo  on 31/1/25.
//

import Foundation

public class PeliculaViewModel: ObservableObject {
    @Published var peliculas: [Pelicula] = []
    
    
    public func GetPeliculas() async {
        
        do{
            try await peliculasFetch()
            
        }catch {
            print("❌ Error al obtener los géneros: \(error.localizedDescription)")
        }
    }
    
    
    public func peliculasFetch() async  throws {
        
        let api_key = "YOUR API KEY HERE"
        
        var  urlComponents = URLComponents(string: "https://api.themoviedb.org/3/movie/top_rated")!
        
        
        urlComponents.queryItems = [
            URLQueryItem (name: "api_key", value: api_key),
            URLQueryItem (name: "language", value: "es"),
            URLQueryItem (name: "page", value: "1")
        ]
        
        
        guard let url = urlComponents.url else {
            print("URL inválida")
            return
        }
        
        
        //Creamos la solicitud
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //Realizamos la solicitud
        let (data,response) = try await URLSession.shared.data(for: request)
       
        
        //Verificamos la respuesta
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print ("Error en la solicitud")
            return
        }
        
        //Decodificamos la respuesta
        let peliculaResponse = try JSONDecoder().decode(PeliculaResponse.self, from: data )
        
        DispatchQueue.main.async {
            self.peliculas = peliculaResponse.results
            
            
        }
        
    }
    
    
   
    struct PeliculaResponse: Decodable {
        let results: [Pelicula]  // Respuesta de la API, debe coincidir con el nombre, que nos devuelve la API
    }
    
    
}
