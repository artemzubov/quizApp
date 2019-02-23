package com.quizApp.validator;


import com.quizApp.dto.UserDTO;
import com.quizApp.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

@Component
public class UserValidator implements Validator {

    @Autowired
    private UserService userService;

    @Override
    public boolean supports(Class<?> aClass) {
        return UserDTO.class.equals(aClass);
    }

    @Override
    public void validate(Object o, Errors errors) {

        UserDTO userDTO = (UserDTO) o;
        if (userDTO.getName() != null) {
            ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "NotEmpty");
            if (userDTO.getName().length() < 3 || userDTO.getName().length() > 39) {
                errors.rejectValue("name", "Size.userForm.name");
            }
            if (!userDTO.getName().matches("^[а-яА-Яa-zA-Z0-9\\._ \\-]*$")) {
                errors.rejectValue("name", "Regex.userForm.name");
            }
        }

        if (userDTO.getEmail() != null) {
            ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "NotEmpty");
            if (userDTO.getEmail().length() > 39) {
                errors.rejectValue("email", "Size.userForm.email");
            }
            if (userService.getByMail(userDTO.getEmail()) != null) {
                errors.rejectValue("email", "Duplicate.userForm.email");
            }
            if (!userDTO.getEmail().matches("^([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})$")) {
                errors.rejectValue("email", "Regex.userForm.email");
            }
        }

        if (userDTO.getPassword() != null) {
            ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "NotEmpty");
            if (userDTO.getPassword().length() < 3 || userDTO.getPassword().length() > 39) {
                errors.rejectValue("password", "Size.userForm.password");
            }
        }

        if (userDTO.getConfirmPassword() != null) {
            if (!userDTO.getConfirmPassword().equals(userDTO.getPassword())) {
                errors.rejectValue("confirmPassword", "Diff.userForm.confirmPassword");
            }
        }
    }
}
