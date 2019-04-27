/* Adaptado de https://github.com/Arrlindii/AAValidators */

import Foundation

public enum ValidationError: Error {
    case email
    case passwordRequired
    case passwordTooShort
}

extension ValidationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .email: return NSLocalizedString("Correo inválido", comment: "")
        case .passwordRequired: return NSLocalizedString("Contraseña requerida", comment: "")
        case .passwordTooShort: return NSLocalizedString("La contraseña debe tener al menos 6 caracteres", comment: "")
        }
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case email
    case password
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        }
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError.passwordRequired}
        guard value.count >= 6 else { throw ValidationError.passwordTooShort }
        
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$",
                                       options: .caseInsensitive)
                .firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError.email
            }
        } catch {
            throw ValidationError.email
        }
        
        return value
    }
}
