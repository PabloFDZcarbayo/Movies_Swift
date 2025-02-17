import Foundation

public class GeneroViewModel: ObservableObject {
    @Published var generos: [Genero] = []
    
    
    
    public func getGeneros() async {
        do {
            try await generosFetch()
        } catch {
            print("❌ Error al obtener los géneros: \(error.localizedDescription)")
        }
    }
    
    
    //Peticion API TMDB
    private func generosFetch() async throws {
        
        let api_key = "YOUR API KEY HERE"
        
        var urlComponents = URLComponents(string: "https://api.themoviedb.org/3/genre/movie/list")!
        
        urlComponents.queryItems = [
            URLQueryItem (name: "api_key", value: api_key),
            URLQueryItem (name: "language", value: "es")]
        
        
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
        let generoResponse = try JSONDecoder().decode(GeneroResponse.self, from: data )
        
        DispatchQueue.main.async {
            self.generos = generoResponse.genres
            
            
        }
        
        
    }
    
    struct GeneroResponse: Decodable {
        let genres: [Genero] //Respuesta de la API, el nombre debe coincidir con la respuesta de la API
    }
    
    
    
    
    // Método para obtener el nombre del género por ID
    func nombreDelGenero(id: Int) -> String {
        return generos.first(where: { $0.id == id })?.name ?? "Desconocido"
    }
    
}
