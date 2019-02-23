package com.quizApp.dto;

import com.quizApp.model.Role;

import java.util.Objects;

public class UserDTO {

    private Integer id;
    private String name;
    private String email;
    private String password;
    private String confirmPassword;
    private Boolean isEnabled;
    private Role role;

    public UserDTO() {
    }

    public UserDTO(Integer id, String name, String email,
                   String password, String confirmPassword, Boolean isEnabled, Role role) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.confirmPassword = confirmPassword;
        this.isEnabled = isEnabled;
        this.role = role;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public Boolean getEnabled() {
        return isEnabled;
    }

    public void setEnabled(Boolean enabled) {
        isEnabled = enabled;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserDTO user = (UserDTO) o;
        return Objects.equals(getEmail(), user.getEmail());
    }

    @Override
    public int hashCode() {

        return Objects.hash(getId(), getName(), getEmail(), getPassword(), isEnabled, getRole());
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", isEnabled=" + isEnabled +
                ", role=" + role +
                '}';
    }
}