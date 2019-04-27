import UIKit
import FirebaseDatabase

class CrearClienteViewController: UIViewController {
    
    private var ref: DatabaseReference = Database.database().reference().child("clientes")
    
    @IBOutlet weak var textFieldNombre: UITextField!
    
    @IBOutlet weak var textFieldApellido: UITextField!
    
    @IBOutlet weak var textFieldEdad: UITextField!
    
    @IBOutlet weak var textFieldFechaNacimiento: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func alClickearBotonCrearCliente(_ sender: UIButton) {
        guard let cliente = self.validarInputs() else { return }
        let clienteMapeado = mapearCliente(cliente)

        self.ref.childByAutoId().setValue(clienteMapeado) { (error, ref) -> Void in
            guard let strongError = error else {
                self.regresar()
                
                return
            }
            
            self.mostrarError(error: strongError)
        }
    }
    
    private func validarInputs() -> Cliente? {
        do {
            let nombre = try textFieldNombre.validatedText(validationType: ValidatorType.required)
            let apellido = try textFieldApellido.validatedText(validationType: ValidatorType.required)
            let edad = try textFieldEdad.validatedText(validationType: ValidatorType.required)
            let fechaNacimiento = try textFieldFechaNacimiento.validatedText(validationType: ValidatorType.required)
            
            return Cliente(nombre: nombre,
                           apellido: apellido,
                           edad: edad,
                           fechaNacimiento: fechaNacimiento)
            
        } catch(let error) {
            self.mostrarError(error: error as! ValidationError)
        }
        
        return nil
    }
    
    private func mapearCliente(_ cliente: Cliente) -> NSDictionary {
        return ["nombre": cliente.nombre,
                "apellido": cliente.apellido,
                "edad": cliente.edad,
                "fechaNacimiento": cliente.fechaNacimiento]
    }
    
    private func regresar() {
        navigationController?.popViewController(animated: true)
    }
}
