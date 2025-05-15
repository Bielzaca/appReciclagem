package br.AppReciclagem.appReciclagem.service.authenticator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class LoginInterceptorAppConfig implements WebMvcConfigurer {

    @Autowired
    private br.AppReciclagem.appReciclagem.service.authenticator.LoginInterceptor logininterceptor;


    public void addInterceptors(InterceptorRegistry registry){
        registry.addInterceptor(logininterceptor).excludePathPatterns(
                "/login",
                "/logar",
                "/error",
                "/cadastroUsuario",
                "/css/**",
                "/js/**"

        );
    }
}
