package br.AppReciclagem.appReciclagem.controller;

import br.AppReciclagem.appReciclagem.model.Usuario;
import br.AppReciclagem.appReciclagem.repository.UsuarioRepository;

import br.AppReciclagem.appReciclagem.service.CookieService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.io.UnsupportedEncodingException;

@Controller
public class LoginController {

    @Autowired
    private UsuarioRepository ur;
    @GetMapping("/login")
    public String login(){
        return "login";
    }



    @GetMapping("/")
    public String dashboard(Model model, HttpServletRequest request) throws UnsupportedEncodingException {
        model.addAttribute("nome", CookieService.getCookie(request, "nomeUsuario"));

        return "redirect:/login";
    }

    @PostMapping("/logar")
    public String loginUsuario (Usuario usuario, Model model, HttpServletResponse response) throws UnsupportedEncodingException {


        Usuario loggedUser = this.ur.login(usuario.getUsuarioLogin(), usuario.getUsuarioSenha());
        if (loggedUser != null){
            CookieService.setCookie(response, "usuarioId", String.valueOf(loggedUser.getId()), 10000);
            CookieService.setCookie(response, "nomeUsuario", loggedUser.getNome(), 10000);

            if (loggedUser.getId() == 1 && "admin".equalsIgnoreCase(loggedUser.getNome())) {
                return "redirect:/admin";
            } else {
                return "redirect:/usuario";
            }
        }
        model.addAttribute("erro", "Combinação de Usuario/Senha inválidos");
        return "login";
    }




    @GetMapping("/cadastroUsuario")
    public String cadastro(){
        return "cadastro";
    }
    @RequestMapping(value = "/cadastroUsuario", method = RequestMethod.POST)
    public String cadastroUsuario(@Valid Usuario usuario, BindingResult result){
        if(result.hasErrors()){
            return "redirect:/cadastroUsuario";
        }
        ur.save(usuario);
        return "redirect:/login";
    }
}
