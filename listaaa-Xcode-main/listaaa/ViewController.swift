//
//  ViewController.swift
//  listaaa
//
//  Created by Alumno ULSA on 24/04/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tvPeliculas: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peliculas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaPelicula") as! CeldaPeliculaController
        celda.lblTitulo.text = peliculas[indexPath.row].titulo
        celda.lblAno.text = peliculas[indexPath.row].anno
        celda.lblDirector.text = peliculas[indexPath.row].director
    
        return celda
    }
    

    var peliculas : [Pelicula] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*peliculas.append(Pelicula(titulo: "Titanic", director: "James Cameron", año: "1996"))
        peliculas.append(Pelicula(titulo: "Mario Bros.", director: "Michael Jelenic", año: "2023"))
        peliculas.append(Pelicula(titulo: "Mario Bros 2.", director: "Michael Jelenic", año: "2023"))*/
        
        let url = URL(string: "http://localhost:8000/api/peliculas")!
        var solicitud = URLRequest(url: url)
        solicitud.setValue("application/json", forHTTPHeaderField: "Content-Type")
        solicitud.setValue("application/json", forHTTPHeaderField: "Accept")
        solicitud.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: solicitud) {
            data, response, error in
            if let data = data {
                if let peliculas = try? JSONDecoder().decode([Pelicula].self, from: data) {
                    self.peliculas = peliculas
                    DispatchQueue.global(qos: .background).async {
                        // Background Thread
                        DispatchQueue.main.async {
                            // Run UI Updates
                            self.tvPeliculas.reloadData()
                        }
                    }
                    
                }
            }
        }
        task.resume()
    }
    
    


}

