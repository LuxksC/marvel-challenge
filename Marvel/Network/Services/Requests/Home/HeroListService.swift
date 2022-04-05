import Foundation

class HeroListService: HeroListServiceProtocol {
	
	let session = URLSession.shared
	
	func execute(handler: @escaping (Result<Response, HeroError>) -> Void) {
		
		let request: HomeRequest = .home
		
		if var baseUrl = URLComponents(string: request.baseURL) {
			
			baseUrl.query = request.path
			
			guard let url = baseUrl.url else { return }
			
			var requestUrl: URLRequest = URLRequest(url: url)
			requestUrl.httpMethod = request.method.name
			
			let dataTask = session.dataTask(with: requestUrl) { data, response, _ in
				
				guard let httpResponse = response as? HTTPURLResponse else { return }
				
				if httpResponse.statusCode == 200 {
					
					do {
						
						guard let jsonData = data else { return handler(.failure(.noProcessData)) }
						
						let decoder = JSONDecoder()
						
						let responseData = try decoder.decode(Response.self, from: jsonData)
						
						handler(.success(responseData))
						
						
					} catch let error {
						handler(.failure(.error(error.localizedDescription)))
					}
					
					
					
				} else if httpResponse.statusCode == 409 {
					handler(.failure(.urlInvalid))
				}
				
				
			}
			
			dataTask.resume()
			
			
			
		}
		
	}
	
}
