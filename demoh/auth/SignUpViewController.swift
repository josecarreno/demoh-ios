import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var textFieldCorreo: UITextField!
    @IBOutlet weak var textFieldContrasenia: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func alClickearBotonCrear(_ sender: UIButton) {
        guard let authModel = self.validarInputs() else { return }
        
        self.mostrarCargando(onView: self.view)
        
        Auth.auth().createUser(withEmail: authModel.correo,
                               password: authModel.constrasenia) { authResult, error in
                                self.ocultarCargando()
                                self.manejarRespuesta(error)
        }
    }
    
    private func manejarRespuesta(_ error: Error?) {
        if (error != nil) {
            self.mostrarError(error: error!)
        } else {
            self.mostrarExito(accion: { action in self.regresar() })
        }
    }
    
    private func validarInputs() -> AuthModel? {
        do {
            let email = try textFieldCorreo.validatedText(validationType: ValidatorType.email)
            let password = try textFieldContrasenia.validatedText(validationType: ValidatorType.password)
            
            return AuthModel(correo: email, constrasenia: password)
        } catch(let error) {
            self.mostrarError(error: error as! ValidationError)
        }
        
        return nil
    }
    
    private func mostrarExito(accion: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: "Cuenta creada",
                                      message: "Usa tu nueva cuenta para acceder",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: accion) )
        
        self.present(alert, animated: true)
    }
    
    private func regresar() {
        navigationController?.popViewController(animated: true)
    }
}
