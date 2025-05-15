package br.AppReciclagem.appReciclagem.service.authenticator;

import br.AppReciclagem.appReciclagem.service.CookieService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.IOException;


@Component
public class LoginInterceptor implements HandlerInterceptor {




    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {



        if(CookieService.getCookie(request, "usuarioId") != null){
            int idUsuario;
            idUsuario = Integer.parseInt(CookieService.getCookie(request, "usuarioId"));
            String nomeUsuario = CookieService.getCookie(request, "nomeUsuario");
            if (idUsuario == 1 && nomeUsuario.equals("admin")){

                return true;
            }
            if(idUsuario != 1 && !nomeUsuario.equals("admin")){

                return true;
            }


        }
        response.sendRedirect("login");
        return false;


    }
}
