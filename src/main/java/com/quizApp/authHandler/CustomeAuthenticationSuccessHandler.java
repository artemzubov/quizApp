package com.quizApp.authHandler;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

public class CustomeAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response, Authentication authentication) throws IOException {
        handle(request, response, authentication);
    }

    protected void handle(HttpServletRequest request,
                          HttpServletResponse response, Authentication authentication)
            throws IOException {
        String targetUrl = determineTargetUrl(authentication);
        if (response.isCommitted()) {
            return;
        }
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }

    protected String determineTargetUrl(Authentication authentication) {
        boolean isTeacher = false;
        boolean isAdmin = false;
        boolean isStudent = false;
        boolean isRequest = false;
        boolean isRejected = false;
        Collection<? extends GrantedAuthority> authorities
                = authentication.getAuthorities();

        for (GrantedAuthority grantedAuthority : authorities) {
            if (grantedAuthority.getAuthority().equals("ROLE_TEACHER")) {
                isTeacher = true;
                break;
            } else if (grantedAuthority.getAuthority().equals("ROLE_ADMIN")) {
                isAdmin = true;
                break;
            } else if (grantedAuthority.getAuthority().equals("ROLE_STUDENT")) {
                isStudent = true;
                break;
            } else if (grantedAuthority.getAuthority().equals("ROLE_REQUEST")) {
                isRequest = true;
                break;
            }else if(grantedAuthority.getAuthority().equals("ROLE_REJECTED")){
                isRejected = true;
                break;
            }
        }

        if (isTeacher) {
            return "/quizApp/teacher";
        } else if (isAdmin) {
            return "/quizApp/admin";
        } else if (isStudent) {
            return "/quizApp/student";
        } else if (isRequest) {
            return "/quizApp";
        } else if (isRejected){
            return "/quizApp";
        }return "/quizApp";
    }

    public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
        this.redirectStrategy = redirectStrategy;
    }

    protected RedirectStrategy getRedirectStrategy() {
        return redirectStrategy;
    }
}