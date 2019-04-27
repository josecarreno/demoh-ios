import UIKit.UITextField

/* Tomado de https://github.com/Arrlindii/AAValidators */
extension UITextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
}
