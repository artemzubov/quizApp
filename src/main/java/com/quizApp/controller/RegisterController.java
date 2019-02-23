package com.quizApp.controller;

import com.quizApp.dto.UserDTO;
import com.quizApp.model.Role;
import com.quizApp.model.User;
import com.quizApp.service.UserService;
import com.quizApp.validator.UserValidator;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

@Controller
public class RegisterController {

    @Autowired
    private UserValidator userValidator;

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    protected AuthenticationManager authenticationManager;

    @GetMapping(value = "/register")
    public String registration(Model model) {
        model.addAttribute("userForm", new User());
        return "register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") UserDTO userForm, BindingResult bindingResult,
                               HttpServletRequest request, HttpServletResponse respons) {

        userValidator.validate(userForm, bindingResult);
        if (bindingResult.hasErrors()) {
            return "register";
        }
        if (userForm.getRole() == null) {   // Нажатая галка возвращает значение, не надатая - почему-то кидает null
            userForm.setRole(Role.ROLE_STUDENT);
        } else if (userForm.getRole() != Role.ROLE_REQUEST) {
            userForm.setRole(Role.ROLE_REQUEST);
        }
        String originalPassword = userForm.getPassword();
        userForm.setPassword(passwordEncoder.encode(userForm.getPassword()));
        User user = new User();
        user.setEnabled(true);
        user.setEmail(userForm.getEmail());
        user.setName(userForm.getName());
        user.setRole(userForm.getRole());
        user.setPassword(userForm.getPassword());
        userService.save(user);
        if (userForm.getRole() == Role.ROLE_STUDENT) {
            authenticateUser(userForm.getEmail(), originalPassword, request);
        }
        return "redirect:/quizApp";
    }

    private void authenticateUser(String email, String password,
                                  HttpServletRequest request) {

        UsernamePasswordAuthenticationToken authToken = new
                UsernamePasswordAuthenticationToken(email, password);
        request.getSession();
        authToken.setDetails(new WebAuthenticationDetails(request));
        Authentication authentication = authenticationManager.authenticate
                (authToken);
        SecurityContextHolder.getContext().
                setAuthentication(authentication);
    }

    @GetMapping(value = "/dynamicValidate")
    @ResponseBody
    public String dynamicValidator(@ModelAttribute("userForm") User userForm,
                                   BindingResult bindingResult,
                                   @RequestParam(value = "input") String input,
                                   @RequestParam(value = "value") String value) {
        if (input == null || value == null) {
            return "";
        }
        switch (input) {
            case "name":
                userForm.setName(value);
                break;
            case "email":
                userForm.setEmail(value);
                break;
            default:
                break;
        }
        userValidator.validate(userForm, bindingResult);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("input", input);
        jsonObject.put("value", value);
        jsonObject.put("msg", "ok");
        if (bindingResult.hasErrors()) {
            String errMsg = "";
            if (bindingResult.getFieldError() != null) {
                for (FieldError fe : bindingResult.getFieldErrors())
                errMsg += fe.getCode();
            }
            List<String> errs = new ArrayList<>();
            Properties properties = new Properties();
            try {
                properties.load(getClass().getResourceAsStream("/userValidator-msgs/userValidator.properties"));
            } catch (IOException e) {           // Пытался подвязвать файл с интернационализацией - не вышло
            }                                   // Во фронте спринг-мезж тэги ругаются на код-проперти, который указан неявно, т.е. как переменная
                if (errMsg.contains("NotEmpty")) { //Это если передать код проперти, а не готовое сообщение, как тут у меня.
                errs.add(properties.getProperty("NotEmpty"));
            }
            if (errMsg.contains("Size.userForm.name")) {
                errs.add(properties.getProperty("Size.userForm.name"));
            }
            if (errMsg.contains("Regex.userForm.name")) {
                errs.add(properties.getProperty("Regex.userForm.name"));
            }
            if (errMsg.contains("Size.userForm.email")) {
                errs.add(properties.getProperty("Size.userForm.email"));
            }
            if (errMsg.contains("Duplicate.userForm.email")) {
                errs.add(properties.getProperty("Duplicate.userForm.email"));
            }
            if (errMsg.contains("Regex.userForm.email")) {
                errs.add(properties.getProperty("Regex.userForm.email"));
            }
            return jsonObject.put("msg", errs).toString();
        }
        return jsonObject.toString();
    }
}

